{
    Copyright (c) 1998-2002 by the Free Pascal development team

    Basic Processor information for the MIPS

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

Unit CPUInfo;

{$i fpcdefs.inc}

Interface

  uses
    globtype;

Type
   bestreal = double;
{$if FPC_FULLVERSION>20700}
   bestrealrec = TDoubleRec;
{$endif FPC_FULLVERSION>20700}
   ts32real = single;
   ts64real = double;
   ts80real = type double;
   ts128real = type double;
   ts64comp = comp;

   pbestreal=^bestreal;

   { possible supported processors for this target }
   tcputype =
      (cpu_none,
       cpu_mips1,
       cpu_mips2,
       cpu_mips3,
       cpu_mips4,
       cpu_mips5,
       cpu_mips32,
       cpu_mips32r2,
       cpu_pic32mx
      );

   tfputype =(fpu_none,fpu_soft,fpu_mips2,fpu_mips3);

   tabitype = 
     (
     abi_none,
     abi_default,
     abi_o32,
     abi_n32,
     abi_o64,
     abi_n64,
     abi_eabi
     );

Const
   {# Size of native extended floating point type }
   extended_size = 8;
   { calling conventions supported by the code generator }
   supported_calling_conventions : tproccalloptions = [
     pocall_internproc,
     pocall_stdcall,
     pocall_safecall,
     { same as stdcall only different name mangling }
     pocall_cdecl,
     { same as stdcall only different name mangling }
     pocall_cppdecl
   ];

   { cpu strings as accepted by 
     GNU assembler in -arch=XXX option 
     this ilist needs to be uppercased }
   cputypestr : array[tcputype] of string[8] = ('',
     { cpu_mips1        } 'MIPS1',
     { cpu_mips2        } 'MIPS2',
     { cpu_mips3        } 'MIPS3',
     { cpu_mips4        } 'MIPS4',
     { cpu_mips5        } 'MIPS5',
     { cpu_mips32       } 'MIPS32',
     { cpu_mips32r2     } 'MIPS32R2',
     { cpu_pic32mx      } 'PIC32MX'
   );

   fputypestr : array[tfputype] of string[9] = (
     'NONE',
     'SOFT',
     'MIPS2','MIPS3'
   );

   { abi strings as accepted by 
     GNU assembler in -abi=XXX option }
   abitypestr : array[tabitype] of string[4] =
     ({ abi_none    } '',
      { abi_default } '32',
      { abi_o32     } '32',
      { abi_n32     } 'n32',
      { abi_o64     } 'o64',
      { abi_n64     } '64',
      { abi_eabi    } 'eabi'
     );

   mips_abi : tabitype = abi_default;

type
   tcpuflags=(
     CPUMIPS_HAS_CMOV,             { conditional move instructions (mips4+) }
     CPUMIPS_HAS_ISA32R2           { mips32r2 instructions (also on PIC32)  }
   );

   tcontrollerdatatype = record
     controllertypestr, controllerunitstr: string;
     linkerscript: string;
     linkerdefines: array of tlinkerdefine;
     cputype : tcputype; fputype: tfputype;
     flashbase, flashsize, srambase, sramsize, eeprombase, eepromsize, bootbase, bootsize: dword; 
   end;

const
  cpu_capabilities : array[tcputype] of set of tcpuflags =
    ( { cpu_none }     [],
      { cpu_mips1 }    [],
      { cpu_mips2 }    [],
      { cpu_mips3 }    [],
      { cpu_mips4 }    [CPUMIPS_HAS_CMOV],
      { cpu_mips5 }    [CPUMIPS_HAS_CMOV],
      { cpu_mips32 }   [CPUMIPS_HAS_CMOV],
      { cpu_mips32r2 } [CPUMIPS_HAS_CMOV,CPUMIPS_HAS_ISA32R2],
      { cpu_pic32mx }  [CPUMIPS_HAS_CMOV,CPUMIPS_HAS_ISA32R2]
    );

{$ifndef MIPSEL}
type
   tcontrollertype =
     (ct_none
     );


Const
   { Is there support for dealing with multiple microcontrollers available }
   { for this platform? }
   ControllerSupport = false;
   
   embedded_controllers : array of tcontrollerdatatype = nil;

   { Supported optimizations, only used for information }
   supported_optimizerswitches = [{$ifndef llvm}cs_opt_regvar,{$endif}cs_opt_loopunroll,cs_opt_nodecse,
                                  cs_opt_reorder_fields,cs_opt_fastmath];

   level1optimizerswitches = genericlevel1optimizerswitches;
   level2optimizerswitches = level1optimizerswitches + [{$ifndef llvm}cs_opt_regvar,{$endif}cs_opt_stackframe,cs_opt_nodecse];
   level3optimizerswitches = level2optimizerswitches + [cs_opt_loopunroll];
   level4optimizerswitches = genericlevel4optimizerswitches + level3optimizerswitches + [];

function SetMipsABIType(const s : string) : boolean;

Implementation

uses
  cutils;

function SetMipsABIType(const s : string) : boolean;

  var
    abi : tabitype;
  begin
    SetMipsABIType:=false;
    for abi := low(tabitype) to high(tabitype) do
      if (lower(s)=abitypestr[abi]) then
        begin
          mips_abi:=abi;
          SetMipsABIType:=true;
          break;
        end;
  end;
           
end.
