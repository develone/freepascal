{
    Copyright (c) 1998-2011, 2019 by Florian Klaempfl and Jonas Maebe, Dmitry Boyarintsev

    Generate WebAssembly code for math nodes

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 ****************************************************************************
}
unit nwasmmat;

{$i fpcdefs.inc}

interface

    uses
      node,nmat,ncgmat,ncghlmat;

    type
      twasmmoddivnode = class(tmoddivnode)
        protected
          function use_moddiv64bitint_helper: boolean; override;
        public
         procedure pass_generate_code;override;
      end;

      twasmshlshrnode = class(tshlshrnode)
         procedure pass_generate_code;override;
      end;

      twasmnotnode = class(tcgnotnode)
      protected
        procedure second_boolean;override;
      end;

      twasmunaryminusnode = class(tcgunaryminusnode)
        procedure second_float;override;
      end;

implementation

    uses
      globtype,systems,constexp,
      cutils,verbose,globals,compinnr,
      symconst,symdef,
      aasmbase,aasmcpu,aasmtai,aasmdata,
      defutil,
      cgbase,cgobj,pass_2,procinfo,
      ncon,
      cpubase,
      hlcgobj,hlcgcpu,cgutils;

{*****************************************************************************
                             twasmmoddivnode
*****************************************************************************}

    function twasmmoddivnode.use_moddiv64bitint_helper: boolean;
      begin
        result:=
          (left.resultdef.typ=orddef) and
          (right.resultdef.typ=orddef) and
          ((torddef(left.resultdef).ordtype=u64bit) or
           (torddef(right.resultdef).ordtype=u64bit));
      end;


    procedure twasmmoddivnode.pass_generate_code;
      var
        tmpreg: tregister;
        lab: tasmlabel;
        ovloc: tlocation;
        op: topcg;
        isu32int: boolean;
      begin
         secondpass(left);
         secondpass(right);
         location_reset(location,LOC_REGISTER,left.location.size);
         location.register:=hlcg.getintregister(current_asmdata.CurrAsmList,resultdef);


        if nodetype=divn then
          begin
            thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,left.resultdef,left.location);
            if is_signed(resultdef) then
              op:=OP_IDIV
            else
              op:=OP_DIV;
            thlcgwasm(hlcg).a_op_loc_stack(current_asmdata.CurrAsmList,op,right.resultdef,right.location)
          end
        else
          begin
            { must be handled via a helper }
            if torddef(resultdef).ordtype=u64bit then
              internalerror(2011010416);
            if (torddef(resultdef).ordtype<>u32bit) then
              begin
                isu32int:=false;
                thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,left.resultdef,left.location);
                thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,right.resultdef,right.location);
              end
            else
              begin
                isu32int:=true;
                if left.location.loc=LOC_CONSTANT then
                  thlcgwasm(hlcg).a_load_const_stack(current_asmdata.CurrAsmList,s64inttype,left.location.value,R_INTREGISTER)
                else
                  begin
                    thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,left.resultdef,left.location);
                    thlcgwasm(hlcg).resize_stack_int_val(current_asmdata.CurrAsmList,u32inttype,s64inttype,false);
                  end;
                if right.location.loc=LOC_CONSTANT then
                  thlcgwasm(hlcg).a_load_const_stack(current_asmdata.CurrAsmList,s64inttype,right.location.value,R_INTREGISTER)
                else
                  begin
                    thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,right.resultdef,right.location);
                    thlcgwasm(hlcg).resize_stack_int_val(current_asmdata.CurrAsmList,u32inttype,s64inttype,false);
                  end;
              end;
            if isu32int or
               (torddef(resultdef).ordtype=s64bit) then
              begin
                current_asmdata.CurrAsmList.concat(taicpu.op_none(a_i64_rem_s));
                thlcgwasm(hlcg).decstack(current_asmdata.CurrAsmList,1);
              end
            else
              begin
                current_asmdata.CurrAsmList.concat(taicpu.op_none(a_i32_rem_s));
                thlcgwasm(hlcg).decstack(current_asmdata.CurrAsmList,1);
              end;
            if isu32int then
              thlcgwasm(hlcg).resize_stack_int_val(current_asmdata.CurrAsmList,s64inttype,u32inttype,false);
          end;
         thlcgwasm(hlcg).a_load_stack_reg(current_asmdata.CurrAsmList,resultdef,location.register);
         if (cs_check_overflow in current_settings.localswitches) and
            is_signed(resultdef) then
           begin
             { the JVM raises an exception for integer div-iby-zero -> only
               overflow in case left is low(inttype) and right is -1 ->
               check by adding high(inttype) to left and and'ing with right
               -> result is -1 only in case above conditions are fulfilled)
             }
             tmpreg:=hlcg.getintregister(current_asmdata.CurrAsmList,resultdef);
             hlcg.location_force_reg(current_asmdata.CurrAsmList,right.location,right.resultdef,resultdef,true);
             hlcg.a_op_const_reg_reg(current_asmdata.CurrAsmList,OP_ADD,resultdef,torddef(resultdef).high,right.location.register,tmpreg);
             hlcg.location_force_reg(current_asmdata.CurrAsmList,left.location,left.resultdef,resultdef,true);
             hlcg.a_op_reg_reg(current_asmdata.CurrAsmList,OP_AND,resultdef,left.location.register,tmpreg);
             current_asmdata.getjumplabel(lab);
             hlcg.a_cmp_const_reg_label(current_asmdata.CurrAsmList,resultdef,OC_NE,-1,tmpreg,lab);
             hlcg.g_call_system_proc(current_asmdata.CurrAsmList,'fpc_overflow',[],nil);
             hlcg.a_label(current_asmdata.CurrAsmList,lab);
           end;
      end;


{*****************************************************************************
                             twasmshlshrnode
*****************************************************************************}

    procedure twasmshlshrnode.pass_generate_code;
      var
        op : topcg;
      begin
        secondpass(left);
        secondpass(right);
        location_reset(location,LOC_REGISTER,left.location.size);
        location.register:=hlcg.getintregister(current_asmdata.CurrAsmList,resultdef);

        thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,left.resultdef,left.location);
        thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,right.resultdef,right.location);
        thlcgwasm(hlcg).resize_stack_int_val(current_asmdata.CurrAsmList,right.resultdef,left.resultdef,false);
        if nodetype=shln then
          op:=OP_SHL
        else
          op:=OP_SHR;
        thlcgwasm(hlcg).a_op_stack(current_asmdata.CurrAsmList,op,resultdef);
        thlcgwasm(hlcg).a_load_stack_reg(current_asmdata.CurrAsmList,resultdef,location.register);
      end;


{*****************************************************************************
                               twasmnotnode
*****************************************************************************}

    procedure twasmnotnode.second_boolean;
      begin
        secondpass(left);
        if not(left.location.loc in [LOC_REGISTER,LOC_CREGISTER]) then
          hlcg.location_force_reg(current_asmdata.CurrAsmList,left.location,left.resultdef,left.resultdef,false);
        location_reset(location,LOC_REGISTER,left.location.size);
        location.register:=cg.getintregister(current_asmdata.CurrAsmList,location.size);
        { perform the NOT operation }
        hlcg.a_op_reg_reg(current_asmdata.CurrAsmList,OP_NOT,left.resultdef,left.location.register,location.register);
      end;

{*****************************************************************************
                            twasmunaryminustnode
*****************************************************************************}

    procedure twasmunaryminusnode.second_float;
      var
        opc: tasmop;
      begin
        secondpass(left);
        location_reset(location,LOC_FPUREGISTER,def_cgsize(resultdef));
        location.register:=hlcg.getfpuregister(current_asmdata.CurrAsmList,resultdef);
        thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,left.resultdef,left.location);
        if (tfloatdef(left.resultdef).floattype=s32real) then
          opc:=a_f32_neg
        else
          opc:=a_f64_neg;
        current_asmdata.CurrAsmList.concat(taicpu.op_none(opc));
        thlcgwasm(hlcg).a_load_stack_reg(current_asmdata.CurrAsmList,resultdef,location.register);
      end;


begin
   cmoddivnode:=twasmmoddivnode;
   cshlshrnode:=twasmshlshrnode;
   cnotnode:=twasmnotnode;
   cunaryminusnode:=twasmunaryminusnode;
end.
