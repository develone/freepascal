{
    Copyright (c) 2005-2017 by Free Pascal Compiler team

    This unit implements support import, export, link routines
    for the Embedded Target

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
unit t_embed;

{$i fpcdefs.inc}

interface


implementation

    uses
       SysUtils,
       cutils,cfileutl,cclasses,
       globtype,globals,systems,verbose,comphook,cscript,fmodule,i_embed,link,
       cpuinfo;

    type
       TlinkerEmbedded=class(texternallinker)
       private
          Function  WriteResponseFile: Boolean;
          Function  GenerateUF2(binFile,uf2File : string;baseAddress : longWord):boolean;
       public
          constructor Create; override;
          procedure SetDefaultInfo; override;
          function  MakeExecutable:boolean; override;
          function postprocessexecutable(const fn : string;isdll:boolean):boolean;
       end;

       { TlinkerEmbedded_SdccSdld - the sdld linker from the SDCC project ( http://sdcc.sourceforge.net/ ) }

       TlinkerEmbedded_SdccSdld=class(texternallinker)
       private
          Function  WriteResponseFile: Boolean;
       public
{          constructor Create; override;}
          procedure SetDefaultInfo; override;
          function  MakeExecutable:boolean; override;
{          function postprocessexecutable(const fn : string;isdll:boolean):boolean;}
       end;



{*****************************************************************************
                                  TlinkerEmbedded
*****************************************************************************}

Constructor TlinkerEmbedded.Create;
begin
  Inherited Create;
  SharedLibFiles.doubles:=true;
  StaticLibFiles.doubles:=true;
end;


procedure TlinkerEmbedded.SetDefaultInfo;
const
{$ifdef mips}
  {$ifdef mipsel}
    platform_select='-EL';
  {$else}
    platform_select='-EB';
  {$endif}
{$else}
  platform_select='';
{$endif}
begin
  with Info do
   begin
     ExeCmd[1]:='ld -g '+platform_select+' $OPT $DYNLINK $STATIC $GCSECTIONS $STRIP $MAP -L. -o $EXE -T $RES';
   end;
end;


Function TlinkerEmbedded.WriteResponseFile: Boolean;
Var
  linkres  : TLinkRes;
  i        : longint;
  HPath    : TCmdStrListItem;
  s,s1,s2  : TCmdStr;
  prtobj,
  cprtobj  : string[80];
  linklibc : boolean;
  found1,
  found2   : boolean;
{$if defined(ARM)}
  LinkStr  : string;
{$endif}
begin
  WriteResponseFile:=False;
  linklibc:=(SharedLibFiles.Find('c')<>nil);
{$if defined(ARM) or defined(i386) or defined(x86_64) or defined(AVR) or defined(MIPSEL) or defined(RISCV32) or defined(XTENSA)}
  prtobj:='';
{$else}
  prtobj:='prt0';
{$endif}
  cprtobj:='cprt0';
  if linklibc then
    prtobj:=cprtobj;

  { Open link.res file }
  LinkRes:=TLinkRes.Create(outputexedir+Info.ResName,true);

  { Write path to search libraries }
  HPath:=TCmdStrListItem(current_module.locallibrarysearchpath.First);
  while assigned(HPath) do
   begin
    s:=HPath.Str;
    if (cs_link_on_target in current_settings.globalswitches) then
     s:=ScriptFixFileName(s);
    LinkRes.Add('-L'+s);
    HPath:=TCmdStrListItem(HPath.Next);
   end;
  HPath:=TCmdStrListItem(LibrarySearchPath.First);
  while assigned(HPath) do
   begin
    s:=HPath.Str;
    if s<>'' then
     LinkRes.Add('SEARCH_DIR("'+s+'")');
    HPath:=TCmdStrListItem(HPath.Next);
   end;

  LinkRes.Add('INPUT (');
  { add objectfiles, start with prt0 always }
  //s:=FindObjectFile('prt0','',false);
  if prtobj<>'' then
    begin
      s:=FindObjectFile(prtobj,'',false);
      LinkRes.AddFileName(s);
    end;

  { try to add crti and crtbegin if linking to C }
  if linklibc then
   begin
     if librarysearchpath.FindFile('crtbegin.o',false,s) then
      LinkRes.AddFileName(s);
     if librarysearchpath.FindFile('crti.o',false,s) then
      LinkRes.AddFileName(s);
   end;

  while not ObjectFiles.Empty do
   begin
    s:=ObjectFiles.GetFirst;
    if s<>'' then
     begin
      { vlink doesn't use SEARCH_DIR for object files }
      if not(cs_link_on_target in current_settings.globalswitches) then
       s:=FindObjectFile(s,'',false);
      LinkRes.AddFileName((maybequoted(s)));
     end;
   end;

  { Write staticlibraries }
  if not StaticLibFiles.Empty then
   begin
    { vlink doesn't need, and doesn't support GROUP }
    if (cs_link_on_target in current_settings.globalswitches) then
     begin
      LinkRes.Add(')');
      LinkRes.Add('GROUP(');
     end;
    while not StaticLibFiles.Empty do
     begin
      S:=StaticLibFiles.GetFirst;
      LinkRes.AddFileName((maybequoted(s)));
     end;
   end;

  if (cs_link_on_target in current_settings.globalswitches) then
   begin
    LinkRes.Add(')');

    { Write sharedlibraries like -l<lib>, also add the needed dynamic linker
      here to be sure that it gets linked this is needed for glibc2 systems (PFV) }
    linklibc:=false;
    while not SharedLibFiles.Empty do
     begin
      S:=SharedLibFiles.GetFirst;
      if s<>'c' then
       begin
        i:=Pos(target_info.sharedlibext,S);
        if i>0 then
         Delete(S,i,255);
        LinkRes.Add('-l'+s);
       end
      else
       begin
        LinkRes.Add('-l'+s);
        linklibc:=true;
       end;
     end;
    { be sure that libc&libgcc is the last lib }
    if linklibc then
     begin
      LinkRes.Add('-lc');
      LinkRes.Add('-lgcc');
     end;
   end
  else
   begin
    while not SharedLibFiles.Empty do
     begin
      S:=SharedLibFiles.GetFirst;
      LinkRes.Add('lib'+s+target_info.staticlibext);
     end;
    LinkRes.Add(')');
   end;

  { objects which must be at the end }
  if linklibc then
   begin
     found1:=librarysearchpath.FindFile('crtend.o',false,s1);
     found2:=librarysearchpath.FindFile('crtn.o',false,s2);
     if found1 or found2 then
      begin
        LinkRes.Add('INPUT(');
        if found1 then
         LinkRes.AddFileName(s1);
        if found2 then
         LinkRes.AddFileName(s2);
        LinkRes.Add(')');
      end;
   end;

{$ifdef ARM}
  case current_settings.controllertype of
      ct_none:
           begin
           end;
      ct_lpc810m021fn8,
      ct_lpc811m001fdh16,
      ct_lpc812m101fdh16,
      ct_lpc812m101fd20,
      ct_lpc812m101fdh20,
      ct_lpc1110fd20,
      ct_lpc1111fdh20_002,
      ct_lpc1111fhn33_101,
      ct_lpc1111fhn33_102,
      ct_lpc1111fhn33_103,
      ct_lpc1111fhn33_201,
      ct_lpc1111fhn33_202,
      ct_lpc1111fhn33_203,
      ct_lpc1112fd20_102,
      ct_lpc1112fdh20_102,
      ct_lpc1112fdh28_102,
      ct_lpc1112fhn33_101,
      ct_lpc1112fhn33_102,
      ct_lpc1112fhn33_103,
      ct_lpc1112fhn33_201,
      ct_lpc1112fhn24_202,
      ct_lpc1112fhn33_202,
      ct_lpc1112fhn33_203,
      ct_lpc1112fhi33_202,
      ct_lpc1112fhi33_203,
      ct_lpc1113fhn33_201,
      ct_lpc1113fhn33_202,
      ct_lpc1113fhn33_203,
      ct_lpc1113fhn33_301,
      ct_lpc1113fhn33_302,
      ct_lpc1113fhn33_303,
      ct_lpc1113bfd48_301,
      ct_lpc1113bfd48_302,
      ct_lpc1113bfd48_303,
      ct_lpc1114fdh28_102,
      ct_lpc1114fn28_102,
      ct_lpc1114fhn33_201,
      ct_lpc1114fhn33_202,
      ct_lpc1114fhn33_203,
      ct_lpc1114fhn33_301,
      ct_lpc1114fhn33_302,
      ct_lpc1114fhn33_303,
      ct_lpc1114fhn33_333,
      ct_lpc1114fhi33_302,
      ct_lpc1114fhi33_303,
      ct_lpc1114bfd48_301,
      ct_lpc1114bfd48_302,
      ct_lpc1114bfd48_303,
      ct_lpc1114bfd48_323,
      ct_lpc1114bfd48_333,
      ct_lpc1115bfd48_303,
      ct_lpc11c12fd48_301,
      ct_lpc11c14fd48_301,
      ct_lpc11c22fd48_301,
      ct_lpc11c24fd48_301,
      ct_lpc11d24fd48_301,
      ct_lpc1224fbd48_101,
      ct_lpc1224fbd48_121,
      ct_lpc1224fbd64_101,
      ct_lpc1224fbd64_121,
      ct_lpc1225fbd48_301,
      ct_lpc1225fbd48_321,
      ct_lpc1225fbd64_301,
      ct_lpc1225fbd64_321,
      ct_lpc1226fbd48_301,
      ct_lpc1226fbd64_301,
      ct_lpc1227fbd48_301,
      ct_lpc1227fbd64_301,
      ct_lpc12d27fbd100_301,
      ct_lpc1311fhn33,
      ct_lpc1311fhn33_01,
      ct_lpc1313fhn33,
      ct_lpc1313fhn33_01,
      ct_lpc1313fbd48,
      ct_lpc1313fbd48_01,
      ct_lpc1315fhn33,
      ct_lpc1315fbd48,
      ct_lpc1316fhn33,
      ct_lpc1316fbd48,
      ct_lpc1317fhn33,
      ct_lpc1317fbd48,
      ct_lpc1317fbd64,
      ct_lpc1342fhn33,
      ct_lpc1342fbd48,
      ct_lpc1343fhn33,
      ct_lpc1343fbd48,
      ct_lpc1345fhn33,
      ct_lpc1345fbd48,
      ct_lpc1346fhn33,
      ct_lpc1346fbd48,
      ct_lpc1347fhn33,
      ct_lpc1347fbd48,
      ct_lpc1347fbd64,
      ct_lpc2114,
      ct_lpc2124,
      ct_lpc2194,
      ct_lpc1768,
      ct_at91sam7s256,
      ct_at91sam7se256,
      ct_at91sam7x256,
      ct_at91sam7xc256,

      //Old Stuff for compatibility
      ct_stm32f100x4, // LD&MD value line, 4=16,6=32,8=64,b=128
      ct_stm32f100x6,
      ct_stm32f100x8,
      ct_stm32f100xB,
      ct_stm32f100xC, // HD value line, r=512,d=384,c=256
      ct_stm32f100xD,
      ct_stm32f100xE,
      ct_stm32f101x4, // LD Access line, 4=16,6=32
      ct_stm32f101x6,
      ct_stm32f101x8, // MD Access line, 8=64,B=128
      ct_stm32f101xB,
      ct_stm32f101xC, // HD Access line, C=256,D=384,E=512
      ct_stm32f101xD,
      ct_stm32f101xE,
      ct_stm32f101xF, // XL Access line, F=768,G=1M
      ct_stm32f101xG,
      ct_stm32f102x4, // LD usb access line, 4=16,6=32
      ct_stm32f102x6,
      ct_stm32f102x8, // MD usb access line, 8=64,B=128
      ct_stm32f102xB,
      ct_stm32f103x4, // LD performance line, 4=16,6=32
      ct_stm32f103x6,
      ct_stm32f103x8, // MD performance line, 8=64,B=128
      ct_stm32f103xB,
      ct_stm32f103xC, // HD performance line, C=256,D=384,E=512
      ct_stm32f103xD,
      ct_stm32f103xE,
      ct_stm32f103xF, // XL performance line, F=768,G=1M
      ct_stm32f103xG,
      ct_stm32f105x8,
      ct_stm32f105xb,
      ct_stm32f105xc,
      ct_stm32f107x8, // MD and HD connectivity line, 8=64,B=128,C=256
      ct_stm32f107xB,
      ct_stm32f107xC,

      { ST Microelectronics f0 family }
      ct_stm32f030c6,
      ct_stm32f030c8,
      ct_stm32f030cc,
      ct_stm32f030f4,
      ct_stm32f030k6,
      ct_stm32f030r8,
      ct_stm32f030rc,
      ct_stm32f031c4,
      ct_stm32f031c6,
      ct_stm32f031e6,
      ct_stm32f031f4,
      ct_stm32f031f6,
      ct_stm32f031g4,
      ct_stm32f031g6,
      ct_stm32f031k4,
      ct_stm32f031k6,
      ct_stm32f038c6,
      ct_stm32f038e6,
      ct_stm32f038f6,
      ct_stm32f038g6,
      ct_stm32f038k6,
      ct_stm32f042c4,
      ct_stm32f042c6,
      ct_stm32f042f4,
      ct_stm32f042f6,
      ct_stm32f042g4,
      ct_stm32f042g6,
      ct_stm32f042k4,
      ct_stm32f042k6,
      ct_stm32f042t6,
      ct_stm32f048c6,
      ct_stm32f048g6,
      ct_stm32f048t6,
      ct_stm32f051c4,
      ct_stm32f051c6,
      ct_stm32f051c8,
      ct_stm32f051k4,
      ct_stm32f051k6,
      ct_stm32f051k8,
      ct_stm32f051r4,
      ct_stm32f051r6,
      ct_stm32f051r8,
      ct_stm32f051t8,
      ct_stm32f058c8,
      ct_stm32f058r8,
      ct_stm32f058t8,
      ct_stm32f070c6,
      ct_stm32f070cb,
      ct_stm32f070f6,
      ct_stm32f070rb,
      ct_stm32f071c8,
      ct_stm32f071cb,
      ct_stm32f071rb,
      ct_stm32f071v8,
      ct_stm32f071vb,
      ct_stm32f072c8,
      ct_stm32f072cb,
      ct_stm32f072r8,
      ct_stm32f072rb,
      ct_stm32f072v8,
      ct_stm32f072vb,
      ct_stm32f078cb,
      ct_stm32f078rb,
      ct_stm32f078vb,
      ct_stm32f091cb,
      ct_stm32f091cc,
      ct_stm32f091rb,
      ct_stm32f091rc,
      ct_stm32f091vb,
      ct_stm32f091vc,
      ct_stm32f098cc,
      ct_stm32f098rc,
      ct_stm32f098vc,
      ct_nucleof030r8,
      ct_nucleof031k6,
      ct_nucleof042k6,
      ct_nucleof070rb,
      ct_nucleof072rb,
      ct_nucleof091rc,
      ct_stm32f0308discovery,
      ct_stm32f072bdiscovery,
      ct_stm32f0discovery,

      { ST Microelectronics f1 family }
      ct_stm32f100c4,
      ct_stm32f100c6,
      ct_stm32f100c8,
      ct_stm32f100cb,
      ct_stm32f100r4,
      ct_stm32f100r6,
      ct_stm32f100r8,
      ct_stm32f100rb,
      ct_stm32f100rc,
      ct_stm32f100rd,
      ct_stm32f100re,
      ct_stm32f100v8,
      ct_stm32f100vb,
      ct_stm32f100vc,
      ct_stm32f100vd,
      ct_stm32f100ve,
      ct_stm32f100zc,
      ct_stm32f100zd,
      ct_stm32f100ze,
      ct_stm32f101c4,
      ct_stm32f101c6,
      ct_stm32f101c8,
      ct_stm32f101cb,
      ct_stm32f101r4,
      ct_stm32f101r6,
      ct_stm32f101r8,
      ct_stm32f101rb,
      ct_stm32f101rc,
      ct_stm32f101rd,
      ct_stm32f101re,
      ct_stm32f101rf,
      ct_stm32f101rg,
      ct_stm32f101t4,
      ct_stm32f101t6,
      ct_stm32f101t8,
      ct_stm32f101tb,
      ct_stm32f101v8,
      ct_stm32f101vb,
      ct_stm32f101vc,
      ct_stm32f101vd,
      ct_stm32f101ve,
      ct_stm32f101vf,
      ct_stm32f101vg,
      ct_stm32f101zc,
      ct_stm32f101zd,
      ct_stm32f101ze,
      ct_stm32f101zf,
      ct_stm32f101zg,
      ct_stm32f102c4,
      ct_stm32f102c6,
      ct_stm32f102c8,
      ct_stm32f102cb,
      ct_stm32f102r4,
      ct_stm32f102r6,
      ct_stm32f102r8,
      ct_stm32f102rb,
      ct_stm32f103c4,
      ct_stm32f103c6,
      ct_stm32f103c8,
      ct_stm32f103cb,
      ct_stm32f103r4,
      ct_stm32f103r6,
      ct_stm32f103r8,
      ct_stm32f103rb,
      ct_stm32f103rc,
      ct_stm32f103rd,
      ct_stm32f103re,
      ct_stm32f103rf,
      ct_stm32f103rg,
      ct_stm32f103t4,
      ct_stm32f103t6,
      ct_stm32f103t8,
      ct_stm32f103tb,
      ct_stm32f103v8,
      ct_stm32f103vb,
      ct_stm32f103vc,
      ct_stm32f103vd,
      ct_stm32f103ve,
      ct_stm32f103vf,
      ct_stm32f103vg,
      ct_stm32f103zc,
      ct_stm32f103zd,
      ct_stm32f103ze,
      ct_stm32f103zf,
      ct_stm32f103zg,
      ct_stm32f105r8,
      ct_stm32f105rb,
      ct_stm32f105rc,
      ct_stm32f105v8,
      ct_stm32f105vb,
      ct_stm32f105vc,
      ct_stm32f107rb,
      ct_stm32f107rc,
      ct_stm32f107vb,
      ct_stm32f107vc,
      ct_nucleof103rb,
      ct_stm32vldiscovery,
      ct_bluepill,

      { ST Microelectronics f2 family }
      ct_stm32f205rb,
      ct_stm32f205rc,
      ct_stm32f205re,
      ct_stm32f205rf,
      ct_stm32f205rg,
      ct_stm32f205vb,
      ct_stm32f205vc,
      ct_stm32f205ve,
      ct_stm32f205vf,
      ct_stm32f205vg,
      ct_stm32f205zc,
      ct_stm32f205ze,
      ct_stm32f205zf,
      ct_stm32f205zg,
      ct_stm32f207ic,
      ct_stm32f207ie,
      ct_stm32f207if,
      ct_stm32f207ig,
      ct_stm32f207vc,
      ct_stm32f207ve,
      ct_stm32f207vf,
      ct_stm32f207vg,
      ct_stm32f207zc,
      ct_stm32f207ze,
      ct_stm32f207zf,
      ct_stm32f207zg,
      ct_stm32f215re,
      ct_stm32f215rg,
      ct_stm32f215ve,
      ct_stm32f215vg,
      ct_stm32f215ze,
      ct_stm32f215zg,
      ct_stm32f217ie,
      ct_stm32f217ig,
      ct_stm32f217ve,
      ct_stm32f217vg,
      ct_stm32f217ze,
      ct_stm32f217zg,
      ct_nucleof207zg,

      { ST Microelectronics f3 family }
      ct_stm32f301c6,
      ct_stm32f301c8,
      ct_stm32f301k6,
      ct_stm32f301k8,
      ct_stm32f301r6,
      ct_stm32f301r8,
      ct_stm32f302c6,
      ct_stm32f302c8,
      ct_stm32f302cb,
      ct_stm32f302cc,
      ct_stm32f302k6,
      ct_stm32f302k8,
      ct_stm32f302r6,
      ct_stm32f302r8,
      ct_stm32f302rb,
      ct_stm32f302rc,
      ct_stm32f302rd,
      ct_stm32f302re,
      ct_stm32f302vb,
      ct_stm32f302vc,
      ct_stm32f302vd,
      ct_stm32f302ve,
      ct_stm32f302zd,
      ct_stm32f302ze,
      ct_stm32f303c6,
      ct_stm32f303c8,
      ct_stm32f303cb,
      ct_stm32f303cc,
      ct_stm32f303k6,
      ct_stm32f303k8,
      ct_stm32f303r6,
      ct_stm32f303r8,
      ct_stm32f303rb,
      ct_stm32f303rc,
      ct_stm32f303rd,
      ct_stm32f303re,
      ct_stm32f303vb,
      ct_stm32f303vc,
      ct_stm32f303vd,
      ct_stm32f303ve,
      ct_stm32f303zd,
      ct_stm32f303ze,
      ct_stm32f318c8,
      ct_stm32f318k8,
      ct_stm32f328c8,
      ct_stm32f334c4,
      ct_stm32f334c6,
      ct_stm32f334c8,
      ct_stm32f334k4,
      ct_stm32f334k6,
      ct_stm32f334k8,
      ct_stm32f334r6,
      ct_stm32f334r8,
      ct_stm32f358cc,
      ct_stm32f358rc,
      ct_stm32f358vc,
      ct_stm32f373c8,
      ct_stm32f373cb,
      ct_stm32f373cc,
      ct_stm32f373r8,
      ct_stm32f373rb,
      ct_stm32f373rc,
      ct_stm32f373v8,
      ct_stm32f373vb,
      ct_stm32f373vc,
      ct_stm32f378cc,
      ct_stm32f378rc,
      ct_stm32f378vc,
      ct_stm32f398ve,
      ct_nucleof302r8,
      ct_nucleof303k8,
      ct_nucleof303re,
      ct_nucleof303ze,
      ct_nucleof334r8,
      ct_stm32f3348discovery,
      ct_stm32f3discovery,

      { ST Microelectronics f4 family }
      ct_stm32f401cb,
      ct_stm32f401cc,
      ct_stm32f401cd,
      ct_stm32f401ce,
      ct_stm32f401rb,
      ct_stm32f401rc,
      ct_stm32f401rd,
      ct_stm32f401re,
      ct_stm32f401vb,
      ct_stm32f401vc,
      ct_stm32f401vd,
      ct_stm32f401ve,
      ct_stm32f405oe,
      ct_stm32f405og,
      ct_stm32f405rg,
      ct_stm32f405vg,
      ct_stm32f405zg,
      ct_stm32f407ie,
      ct_stm32f407ig,
      ct_stm32f407ve,
      ct_stm32f407vg,
      ct_stm32f407ze,
      ct_stm32f407zg,
      ct_stm32f410c8,
      ct_stm32f410cb,
      ct_stm32f410r8,
      ct_stm32f410rb,
      ct_stm32f410t8,
      ct_stm32f410tb,
      ct_stm32f411cc,
      ct_stm32f411ce,
      ct_stm32f411rc,
      ct_stm32f411re,
      ct_stm32f411vc,
      ct_stm32f411ve,
      ct_stm32f412ce,
      ct_stm32f412cg,
      ct_stm32f412re,
      ct_stm32f412rep,
      ct_stm32f412rg,
      ct_stm32f412rgp,
      ct_stm32f412ve,
      ct_stm32f412vg,
      ct_stm32f412ze,
      ct_stm32f412zg,
      ct_stm32f413cg,
      ct_stm32f413ch,
      ct_stm32f413mg,
      ct_stm32f413mh,
      ct_stm32f413rg,
      ct_stm32f413rh,
      ct_stm32f413vg,
      ct_stm32f413vh,
      ct_stm32f413zg,
      ct_stm32f413zh,
      ct_stm32f415og,
      ct_stm32f415rg,
      ct_stm32f415vg,
      ct_stm32f415zg,
      ct_stm32f417ie,
      ct_stm32f417ig,
      ct_stm32f417ve,
      ct_stm32f417vg,
      ct_stm32f417ze,
      ct_stm32f417zg,
      ct_stm32f423ch,
      ct_stm32f423mh,
      ct_stm32f423rh,
      ct_stm32f423vh,
      ct_stm32f423zh,
      ct_stm32f427ag,
      ct_stm32f427ai,
      ct_stm32f427ig,
      ct_stm32f427ii,
      ct_stm32f427vg,
      ct_stm32f427vi,
      ct_stm32f427zg,
      ct_stm32f427zi,
      ct_stm32f429ag,
      ct_stm32f429ai,
      ct_stm32f429be,
      ct_stm32f429bg,
      ct_stm32f429bi,
      ct_stm32f429ie,
      ct_stm32f429ig,
      ct_stm32f429ii,
      ct_stm32f429ne,
      ct_stm32f429ng,
      ct_stm32f429ni,
      ct_stm32f429ve,
      ct_stm32f429vg,
      ct_stm32f429vi,
      ct_stm32f429ze,
      ct_stm32f429zg,
      ct_stm32f429zi,
      ct_stm32f437ai,
      ct_stm32f437ig,
      ct_stm32f437ii,
      ct_stm32f437vg,
      ct_stm32f437vi,
      ct_stm32f437zg,
      ct_stm32f437zi,
      ct_stm32f439ai,
      ct_stm32f439bg,
      ct_stm32f439bi,
      ct_stm32f439ig,
      ct_stm32f439ii,
      ct_stm32f439ng,
      ct_stm32f439ni,
      ct_stm32f439vg,
      ct_stm32f439vi,
      ct_stm32f439zg,
      ct_stm32f439zi,
      ct_stm32f446mc,
      ct_stm32f446me,
      ct_stm32f446rc,
      ct_stm32f446re,
      ct_stm32f446vc,
      ct_stm32f446ve,
      ct_stm32f446zc,
      ct_stm32f446ze,
      ct_stm32f469ae,
      ct_stm32f469ag,
      ct_stm32f469ai,
      ct_stm32f469be,
      ct_stm32f469bg,
      ct_stm32f469bi,
      ct_stm32f469ie,
      ct_stm32f469ig,
      ct_stm32f469ii,
      ct_stm32f469ne,
      ct_stm32f469ng,
      ct_stm32f469ni,
      ct_stm32f469ve,
      ct_stm32f469vg,
      ct_stm32f469vi,
      ct_stm32f469ze,
      ct_stm32f469zg,
      ct_stm32f469zi,
      ct_stm32f479ag,
      ct_stm32f479ai,
      ct_stm32f479bg,
      ct_stm32f479bi,
      ct_stm32f479ig,
      ct_stm32f479ii,
      ct_stm32f479ng,
      ct_stm32f479ni,
      ct_stm32f479vg,
      ct_stm32f479vi,
      ct_stm32f479zg,
      ct_stm32f479zi,
      ct_nucleof401re,
      ct_nucleof410rb,
      ct_nucleof411re,
      ct_nucleof412zg,
      ct_nucleof413zh,
      ct_nucleof429zi,
      ct_nucleof439zi,
      ct_nucleof446re,
      ct_nucleof446ze,
      ct_stm32f401cdiscovery,
      ct_stm32f407gdiscovery,
      ct_stm32f411ediscovery,
      ct_stm32f412gdiscovery,
      ct_stm32f413hdiscovery,
      ct_stm32f429idiscovery,
      ct_stm32f469idiscovery,

      { ST Microelectronics f7 family }
      ct_stm32f722ic,
      ct_stm32f722ie,
      ct_stm32f722rc,
      ct_stm32f722re,
      ct_stm32f722vc,
      ct_stm32f722ve,
      ct_stm32f722zc,
      ct_stm32f722ze,
      ct_stm32f723ic,
      ct_stm32f723ie,
      ct_stm32f723vc,
      ct_stm32f723ve,
      ct_stm32f723zc,
      ct_stm32f723ze,
      ct_stm32f730i8,
      ct_stm32f730r8,
      ct_stm32f730v8,
      ct_stm32f730z8,
      ct_stm32f732ie,
      ct_stm32f732re,
      ct_stm32f732ve,
      ct_stm32f732ze,
      ct_stm32f733ie,
      ct_stm32f733ve,
      ct_stm32f733ze,
      ct_stm32f745ie,
      ct_stm32f745ig,
      ct_stm32f745ve,
      ct_stm32f745vg,
      ct_stm32f745ze,
      ct_stm32f745zg,
      ct_stm32f746be,
      ct_stm32f746bg,
      ct_stm32f746ie,
      ct_stm32f746ig,
      ct_stm32f746ne,
      ct_stm32f746ng,
      ct_stm32f746ve,
      ct_stm32f746vg,
      ct_stm32f746ze,
      ct_stm32f746zg,
      ct_stm32f750n8,
      ct_stm32f750v8,
      ct_stm32f750z8,
      ct_stm32f756bg,
      ct_stm32f756ig,
      ct_stm32f756ng,
      ct_stm32f756vg,
      ct_stm32f756zg,
      ct_stm32f765bg,
      ct_stm32f765bi,
      ct_stm32f765ig,
      ct_stm32f765ii,
      ct_stm32f765ng,
      ct_stm32f765ni,
      ct_stm32f765vg,
      ct_stm32f765vi,
      ct_stm32f765zg,
      ct_stm32f765zi,
      ct_stm32f767bg,
      ct_stm32f767bi,
      ct_stm32f767ig,
      ct_stm32f767ii,
      ct_stm32f767ng,
      ct_stm32f767ni,
      ct_stm32f767vg,
      ct_stm32f767vi,
      ct_stm32f767zg,
      ct_stm32f767zi,
      ct_stm32f768ai,
      ct_stm32f769ag,
      ct_stm32f769ai,
      ct_stm32f769bg,
      ct_stm32f769bi,
      ct_stm32f769ig,
      ct_stm32f769ii,
      ct_stm32f769ng,
      ct_stm32f769ni,
      ct_stm32f777bi,
      ct_stm32f777ii,
      ct_stm32f777ni,
      ct_stm32f777vi,
      ct_stm32f777zi,
      ct_stm32f778ai,
      ct_stm32f779ai,
      ct_stm32f779bi,
      ct_stm32f779ii,
      ct_stm32f779ni,
      ct_nucleof722ze,
      ct_nucleof746zg,
      ct_nucleof767zi,
      ct_stm32f723ediscovery,
      ct_stm32f7308dk,
      ct_stm32f746gdiscovery,
      ct_stm32f7508dk,
      ct_stm32f769idiscovery,

      { ST Microelectronics g0 family }
      ct_stm32g030c6,
      ct_stm32g030c8,
      ct_stm32g030f6,
      ct_stm32g030j6,
      ct_stm32g030k6,
      ct_stm32g030k8,
      ct_stm32g031c4,
      ct_stm32g031c6,
      ct_stm32g031c8,
      ct_stm32g031f4,
      ct_stm32g031f6,
      ct_stm32g031f8,
      ct_stm32g031g4,
      ct_stm32g031g6,
      ct_stm32g031g8,
      ct_stm32g031j4,
      ct_stm32g031j6,
      ct_stm32g031k4,
      ct_stm32g031k6,
      ct_stm32g031k8,
      ct_stm32g031y8,
      ct_stm32g041c6,
      ct_stm32g041c8,
      ct_stm32g041f6,
      ct_stm32g041f8,
      ct_stm32g041g6,
      ct_stm32g041g8,
      ct_stm32g041j6,
      ct_stm32g041k6,
      ct_stm32g041k8,
      ct_stm32g041y8,
      ct_stm32g070cb,
      ct_stm32g070kb,
      ct_stm32g070rb,
      ct_stm32g071c6,
      ct_stm32g071c8,
      ct_stm32g071cb,
      ct_stm32g071eb,
      ct_stm32g071g6,
      ct_stm32g071g8,
      ct_stm32g071g8n,
      ct_stm32g071gb,
      ct_stm32g071gbn,
      ct_stm32g071k6,
      ct_stm32g071k8,
      ct_stm32g071k8n,
      ct_stm32g071kb,
      ct_stm32g071kbn,
      ct_stm32g071r6,
      ct_stm32g071r8,
      ct_stm32g071rb,
      ct_stm32g081cb,
      ct_stm32g081eb,
      ct_stm32g081gb,
      ct_stm32g081gbn,
      ct_stm32g081kb,
      ct_stm32g081kbn,
      ct_stm32g081rb,
      ct_stm32g0b0ce,
      ct_stm32g0b0ke,
      ct_stm32g0b0re,
      ct_stm32g0b0ve,
      ct_stm32g0b1cc,
      ct_stm32g0b1ce,
      ct_stm32g0b1kc,
      ct_stm32g0b1kcn,
      ct_stm32g0b1ke,
      ct_stm32g0b1ken,
      ct_stm32g0b1mc,
      ct_stm32g0b1me,
      ct_stm32g0b1rc,
      ct_stm32g0b1re,
      ct_stm32g0b1vc,
      ct_stm32g0b1ve,
      ct_stm32g0c1cc,
      ct_stm32g0c1ce,
      ct_stm32g0c1kc,
      ct_stm32g0c1kcn,
      ct_stm32g0c1ke,
      ct_stm32g0c1ken,
      ct_stm32g0c1mc,
      ct_stm32g0c1me,
      ct_stm32g0c1rc,
      ct_stm32g0c1re,
      ct_stm32g0c1vc,
      ct_stm32g0c1ve,
      ct_nucleog031k8,
      ct_nucleog070rb,
      ct_nucleog071rb,
      ct_nucleog0b1re,
      ct_stm32g0316discovery,
      ct_stm32g071bdiscovery,

      { ST Microelectronics g4 family }
      ct_stm32g431c6,
      ct_stm32g431c8,
      ct_stm32g431cb,
      ct_stm32g431k6,
      ct_stm32g431k8,
      ct_stm32g431kb,
      ct_stm32g431m6,
      ct_stm32g431m8,
      ct_stm32g431mb,
      ct_stm32g431r6,
      ct_stm32g431r8,
      ct_stm32g431rb,
      ct_stm32g431v6,
      ct_stm32g431v8,
      ct_stm32g431vb,
      ct_stm32g441cb,
      ct_stm32g441kb,
      ct_stm32g441mb,
      ct_stm32g441rb,
      ct_stm32g441vb,
      ct_stm32g471cc,
      ct_stm32g471ce,
      ct_stm32g471mc,
      ct_stm32g471me,
      ct_stm32g471qc,
      ct_stm32g471qe,
      ct_stm32g471rc,
      ct_stm32g471re,
      ct_stm32g471vc,
      ct_stm32g471ve,
      ct_stm32g473cb,
      ct_stm32g473cc,
      ct_stm32g473ce,
      ct_stm32g473mb,
      ct_stm32g473mc,
      ct_stm32g473me,
      ct_stm32g473pb,
      ct_stm32g473pc,
      ct_stm32g473pe,
      ct_stm32g473qb,
      ct_stm32g473qc,
      ct_stm32g473qe,
      ct_stm32g473rb,
      ct_stm32g473rc,
      ct_stm32g473re,
      ct_stm32g473vb,
      ct_stm32g473vc,
      ct_stm32g473ve,
      ct_stm32g474cb,
      ct_stm32g474cc,
      ct_stm32g474ce,
      ct_stm32g474mb,
      ct_stm32g474mc,
      ct_stm32g474me,
      ct_stm32g474pb,
      ct_stm32g474pc,
      ct_stm32g474pe,
      ct_stm32g474qb,
      ct_stm32g474qc,
      ct_stm32g474qe,
      ct_stm32g474rb,
      ct_stm32g474rc,
      ct_stm32g474re,
      ct_stm32g474vb,
      ct_stm32g474vc,
      ct_stm32g474ve,
      ct_stm32g483ce,
      ct_stm32g483me,
      ct_stm32g483pe,
      ct_stm32g483qe,
      ct_stm32g483re,
      ct_stm32g483ve,
      ct_stm32g484ce,
      ct_stm32g484me,
      ct_stm32g484pe,
      ct_stm32g484qe,
      ct_stm32g484re,
      ct_stm32g484ve,
      ct_stm32g491cc,
      ct_stm32g491ce,
      ct_stm32g491kc,
      ct_stm32g491ke,
      ct_stm32g491mc,
      ct_stm32g491mcsx,
      ct_stm32g491me,
      ct_stm32g491mesx,
      ct_stm32g491rc,
      ct_stm32g491re,
      ct_stm32g491vc,
      ct_stm32g491ve,
      ct_stm32g4a1ce,
      ct_stm32g4a1ke,
      ct_stm32g4a1me,
      ct_stm32g4a1mesx,
      ct_stm32g4a1re,
      ct_stm32g4a1ve,
      ct_bg474edpow1,
      ct_nucleog431kb,
      ct_nucleog431rb,
      ct_nucleog474re,
      ct_nucleog491re,

      { ST Microelectronics h7 family }
      ct_stm32h723ve,
      ct_stm32h723vg,
      ct_stm32h723ze,
      ct_stm32h723zg,
      ct_stm32h725ae,
      ct_stm32h725ag,
      ct_stm32h725ie,
      ct_stm32h725ig,
      ct_stm32h725re,
      ct_stm32h725rg,
      ct_stm32h725ve,
      ct_stm32h725vg,
      ct_stm32h725ze,
      ct_stm32h725zg,
      ct_stm32h730abq,
      ct_stm32h730ibq,
      ct_stm32h730vb,
      ct_stm32h730zb,
      ct_stm32h733vg,
      ct_stm32h733zg,
      ct_stm32h735ag,
      ct_stm32h735ig,
      ct_stm32h735rg,
      ct_stm32h735vg,
      ct_stm32h735zg,
      ct_stm32h742ag,
      ct_stm32h742ai,
      ct_stm32h742bg,
      ct_stm32h742bi,
      ct_stm32h742ig,
      ct_stm32h742ii,
      ct_stm32h742vg,
      ct_stm32h742vi,
      ct_stm32h742xg,
      ct_stm32h742xi,
      ct_stm32h742zg,
      ct_stm32h742zi,
      ct_stm32h743ag,
      ct_stm32h743ai,
      ct_stm32h743bg,
      ct_stm32h743bi,
      ct_stm32h743ig,
      ct_stm32h743ii,
      ct_stm32h743vg,
      ct_stm32h743vi,
      ct_stm32h743xg,
      ct_stm32h743xi,
      ct_stm32h743zg,
      ct_stm32h743zi,
      ct_stm32h745bg,
      ct_stm32h745bi,
      ct_stm32h745ig,
      ct_stm32h745ii,
      ct_stm32h745xg,
      ct_stm32h745xi,
      ct_stm32h745zg,
      ct_stm32h745zi,
      ct_stm32h747ag,
      ct_stm32h747ai,
      ct_stm32h747bg,
      ct_stm32h747bi,
      ct_stm32h747ig,
      ct_stm32h747ii,
      ct_stm32h747xg,
      ct_stm32h747xi,
      ct_stm32h747zi,
      ct_stm32h750ib,
      ct_stm32h750vb,
      ct_stm32h750xb,
      ct_stm32h750zb,
      ct_stm32h753ai,
      ct_stm32h753bi,
      ct_stm32h753ii,
      ct_stm32h753vi,
      ct_stm32h753xi,
      ct_stm32h753zi,
      ct_stm32h755bi,
      ct_stm32h755ii,
      ct_stm32h755xi,
      ct_stm32h755zi,
      ct_stm32h757ai,
      ct_stm32h757bi,
      ct_stm32h757ii,
      ct_stm32h757xi,
      ct_stm32h757zi,
      ct_stm32h7a3agq,
      ct_stm32h7a3aiq,
      ct_stm32h7a3ig,
      ct_stm32h7a3igq,
      ct_stm32h7a3ii,
      ct_stm32h7a3iiq,
      ct_stm32h7a3lgq,
      ct_stm32h7a3liq,
      ct_stm32h7a3ng,
      ct_stm32h7a3ni,
      ct_stm32h7a3qiq,
      ct_stm32h7a3rg,
      ct_stm32h7a3ri,
      ct_stm32h7a3vg,
      ct_stm32h7a3vgq,
      ct_stm32h7a3vi,
      ct_stm32h7a3viq,
      ct_stm32h7a3zg,
      ct_stm32h7a3zgq,
      ct_stm32h7a3zi,
      ct_stm32h7a3ziq,
      ct_stm32h7b0abq,
      ct_stm32h7b0ib,
      ct_stm32h7b0ibq,
      ct_stm32h7b0rb,
      ct_stm32h7b0vb,
      ct_stm32h7b0zb,
      ct_stm32h7b3aiq,
      ct_stm32h7b3ii,
      ct_stm32h7b3iiq,
      ct_stm32h7b3liq,
      ct_stm32h7b3ni,
      ct_stm32h7b3qiq,
      ct_stm32h7b3ri,
      ct_stm32h7b3vi,
      ct_stm32h7b3viq,
      ct_stm32h7b3zi,
      ct_stm32h7b3ziq,
      ct_nucleoh723zg,
      ct_nucleoh743zi,
      ct_nucleoh743zi2,
      ct_nucleoh745ziq,
      ct_nucleoh753zi,
      ct_nucleoh755ziq,
      ct_nucleoh7a3ziq,
      ct_stm32h735gdk,
      ct_stm32h745idiscovery,
      ct_stm32h747idiscovery,
      ct_stm32h750bdk,
      ct_stm32h7b3idk,

      { ST Microelectronics l0 family }
      ct_stm32l010c6,
      ct_stm32l010f4,
      ct_stm32l010k4,
      ct_stm32l010k8,
      ct_stm32l010r8,
      ct_stm32l010rb,
      ct_stm32l011d3,
      ct_stm32l011d4,
      ct_stm32l011e3,
      ct_stm32l011e4,
      ct_stm32l011f3,
      ct_stm32l011f4,
      ct_stm32l011g3,
      ct_stm32l011g4,
      ct_stm32l011k3,
      ct_stm32l011k4,
      ct_stm32l021d4,
      ct_stm32l021f4,
      ct_stm32l021g4,
      ct_stm32l021k4,
      ct_stm32l031c4,
      ct_stm32l031c6,
      ct_stm32l031e4,
      ct_stm32l031e6,
      ct_stm32l031f4,
      ct_stm32l031f6,
      ct_stm32l031g4,
      ct_stm32l031g6,
      ct_stm32l031g6s,
      ct_stm32l031k4,
      ct_stm32l031k6,
      ct_stm32l041c4,
      ct_stm32l041c6,
      ct_stm32l041e6,
      ct_stm32l041f6,
      ct_stm32l041g6,
      ct_stm32l041g6s,
      ct_stm32l041k6,
      ct_stm32l051c6,
      ct_stm32l051c8,
      ct_stm32l051k6,
      ct_stm32l051k8,
      ct_stm32l051r6,
      ct_stm32l051r8,
      ct_stm32l051t6,
      ct_stm32l051t8,
      ct_stm32l052c6,
      ct_stm32l052c8,
      ct_stm32l052k6,
      ct_stm32l052k8,
      ct_stm32l052r6,
      ct_stm32l052r8,
      ct_stm32l052t6,
      ct_stm32l052t8,
      ct_stm32l053c6,
      ct_stm32l053c8,
      ct_stm32l053r6,
      ct_stm32l053r8,
      ct_stm32l062c8,
      ct_stm32l062k8,
      ct_stm32l063c8,
      ct_stm32l063r8,
      ct_stm32l071c8,
      ct_stm32l071cb,
      ct_stm32l071cz,
      ct_stm32l071k8,
      ct_stm32l071kb,
      ct_stm32l071kz,
      ct_stm32l071rb,
      ct_stm32l071rz,
      ct_stm32l071v8,
      ct_stm32l071vb,
      ct_stm32l071vz,
      ct_stm32l072cb,
      ct_stm32l072cz,
      ct_stm32l072kb,
      ct_stm32l072kz,
      ct_stm32l072rb,
      ct_stm32l072rz,
      ct_stm32l072v8,
      ct_stm32l072vb,
      ct_stm32l072vz,
      ct_stm32l073cb,
      ct_stm32l073cz,
      ct_stm32l073rb,
      ct_stm32l073rz,
      ct_stm32l073v8,
      ct_stm32l073vb,
      ct_stm32l073vz,
      ct_stm32l081cb,
      ct_stm32l081cz,
      ct_stm32l081kz,
      ct_stm32l082cz,
      ct_stm32l082kb,
      ct_stm32l082kz,
      ct_stm32l083cb,
      ct_stm32l083cz,
      ct_stm32l083rb,
      ct_stm32l083rz,
      ct_stm32l083v8,
      ct_stm32l083vb,
      ct_stm32l083vz,
      ct_bl072zlrwan1,
      ct_nucleol010rb,
      ct_nucleol011k4,
      ct_nucleol031k6,
      ct_nucleol053r8,
      ct_nucleol073rz,
      ct_stm32l0538discovery,

      { ST Microelectronics l1 family }
      ct_stm32l100c6,
      ct_stm32l100c6a,
      ct_stm32l100r8,
      ct_stm32l100r8a,
      ct_stm32l100rb,
      ct_stm32l100rba,
      ct_stm32l100rc,
      ct_stm32l151c6,
      ct_stm32l151c6a,
      ct_stm32l151c8,
      ct_stm32l151c8a,
      ct_stm32l151cb,
      ct_stm32l151cba,
      ct_stm32l151cc,
      ct_stm32l151qc,
      ct_stm32l151qd,
      ct_stm32l151qe,
      ct_stm32l151r6,
      ct_stm32l151r6a,
      ct_stm32l151r8,
      ct_stm32l151r8a,
      ct_stm32l151rb,
      ct_stm32l151rba,
      ct_stm32l151rc,
      ct_stm32l151rca,
      ct_stm32l151rd,
      ct_stm32l151re,
      ct_stm32l151uc,
      ct_stm32l151v8,
      ct_stm32l151v8a,
      ct_stm32l151vb,
      ct_stm32l151vba,
      ct_stm32l151vc,
      ct_stm32l151vca,
      ct_stm32l151vd,
      ct_stm32l151vdx,
      ct_stm32l151ve,
      ct_stm32l151zc,
      ct_stm32l151zd,
      ct_stm32l151ze,
      ct_stm32l152c6,
      ct_stm32l152c6a,
      ct_stm32l152c8,
      ct_stm32l152c8a,
      ct_stm32l152cb,
      ct_stm32l152cba,
      ct_stm32l152cc,
      ct_stm32l152qc,
      ct_stm32l152qd,
      ct_stm32l152qe,
      ct_stm32l152r6,
      ct_stm32l152r6a,
      ct_stm32l152r8,
      ct_stm32l152r8a,
      ct_stm32l152rb,
      ct_stm32l152rba,
      ct_stm32l152rc,
      ct_stm32l152rca,
      ct_stm32l152rd,
      ct_stm32l152re,
      ct_stm32l152uc,
      ct_stm32l152v8,
      ct_stm32l152v8a,
      ct_stm32l152vb,
      ct_stm32l152vba,
      ct_stm32l152vc,
      ct_stm32l152vca,
      ct_stm32l152vd,
      ct_stm32l152vdx,
      ct_stm32l152ve,
      ct_stm32l152zc,
      ct_stm32l152zd,
      ct_stm32l152ze,
      ct_stm32l162qc,
      ct_stm32l162qd,
      ct_stm32l162rc,
      ct_stm32l162rca,
      ct_stm32l162rd,
      ct_stm32l162re,
      ct_stm32l162vc,
      ct_stm32l162vca,
      ct_stm32l162vd,
      ct_stm32l162vdx,
      ct_stm32l162ve,
      ct_stm32l162zc,
      ct_stm32l162zd,
      ct_stm32l162ze,
      ct_nucleol152re,
      ct_stm32l100cdiscovery,
      ct_stm32l152cdiscovery,
      ct_stm32ldiscovery,

      { ST Microelectronics l4 family }
      ct_stm32l412c8,
      ct_stm32l412cb,
      ct_stm32l412cbp,
      ct_stm32l412k8,
      ct_stm32l412kb,
      ct_stm32l412r8,
      ct_stm32l412rb,
      ct_stm32l412rbp,
      ct_stm32l412t8,
      ct_stm32l412tb,
      ct_stm32l412tbp,
      ct_stm32l422cb,
      ct_stm32l422kb,
      ct_stm32l422rb,
      ct_stm32l422tb,
      ct_stm32l431cb,
      ct_stm32l431cc,
      ct_stm32l431kb,
      ct_stm32l431kc,
      ct_stm32l431rb,
      ct_stm32l431rc,
      ct_stm32l431vc,
      ct_stm32l432kb,
      ct_stm32l432kc,
      ct_stm32l433cb,
      ct_stm32l433cc,
      ct_stm32l433rb,
      ct_stm32l433rc,
      ct_stm32l433rcp,
      ct_stm32l433vc,
      ct_stm32l442kc,
      ct_stm32l443cc,
      ct_stm32l443rc,
      ct_stm32l443vc,
      ct_stm32l451cc,
      ct_stm32l451ce,
      ct_stm32l451rc,
      ct_stm32l451re,
      ct_stm32l451vc,
      ct_stm32l451ve,
      ct_stm32l452cc,
      ct_stm32l452ce,
      ct_stm32l452rc,
      ct_stm32l452re,
      ct_stm32l452rep,
      ct_stm32l452vc,
      ct_stm32l452ve,
      ct_stm32l462ce,
      ct_stm32l462re,
      ct_stm32l462ve,
      ct_stm32l471qe,
      ct_stm32l471qg,
      ct_stm32l471re,
      ct_stm32l471rg,
      ct_stm32l471ve,
      ct_stm32l471vg,
      ct_stm32l471ze,
      ct_stm32l471zg,
      ct_stm32l475rc,
      ct_stm32l475re,
      ct_stm32l475rg,
      ct_stm32l475vc,
      ct_stm32l475ve,
      ct_stm32l475vg,
      ct_stm32l476je,
      ct_stm32l476jg,
      ct_stm32l476jgp,
      ct_stm32l476me,
      ct_stm32l476mg,
      ct_stm32l476qe,
      ct_stm32l476qg,
      ct_stm32l476rc,
      ct_stm32l476re,
      ct_stm32l476rg,
      ct_stm32l476vc,
      ct_stm32l476ve,
      ct_stm32l476vg,
      ct_stm32l476ze,
      ct_stm32l476zg,
      ct_stm32l476zgp,
      ct_stm32l485jc,
      ct_stm32l485je,
      ct_stm32l486jg,
      ct_stm32l486qg,
      ct_stm32l486rg,
      ct_stm32l486vg,
      ct_stm32l486zg,
      ct_stm32l496ae,
      ct_stm32l496ag,
      ct_stm32l496agp,
      ct_stm32l496qe,
      ct_stm32l496qg,
      ct_stm32l496qgp,
      ct_stm32l496re,
      ct_stm32l496rg,
      ct_stm32l496rgp,
      ct_stm32l496ve,
      ct_stm32l496vg,
      ct_stm32l496vgp,
      ct_stm32l496wgp,
      ct_stm32l496ze,
      ct_stm32l496zg,
      ct_stm32l496zgp,
      ct_stm32l4a6ag,
      ct_stm32l4a6agp,
      ct_stm32l4a6qg,
      ct_stm32l4a6qgp,
      ct_stm32l4a6rg,
      ct_stm32l4a6rgp,
      ct_stm32l4a6vg,
      ct_stm32l4a6vgp,
      ct_stm32l4a6zg,
      ct_stm32l4a6zgp,
      ct_stm32l4p5ae,
      ct_stm32l4p5ag,
      ct_stm32l4p5agp,
      ct_stm32l4p5ce,
      ct_stm32l4p5cg,
      ct_stm32l4p5cgp,
      ct_stm32l4p5qe,
      ct_stm32l4p5qg,
      ct_stm32l4p5qgp,
      ct_stm32l4p5re,
      ct_stm32l4p5rg,
      ct_stm32l4p5rgp,
      ct_stm32l4p5ve,
      ct_stm32l4p5vg,
      ct_stm32l4p5vgp,
      ct_stm32l4p5ze,
      ct_stm32l4p5zg,
      ct_stm32l4p5zgp,
      ct_stm32l4q5ag,
      ct_stm32l4q5cg,
      ct_stm32l4q5qg,
      ct_stm32l4q5rg,
      ct_stm32l4q5vg,
      ct_stm32l4q5zg,
      ct_stm32l4r5ag,
      ct_stm32l4r5ai,
      ct_stm32l4r5qg,
      ct_stm32l4r5qi,
      ct_stm32l4r5vg,
      ct_stm32l4r5vi,
      ct_stm32l4r5zg,
      ct_stm32l4r5zi,
      ct_stm32l4r5zip,
      ct_stm32l4r7ai,
      ct_stm32l4r7vi,
      ct_stm32l4r7zi,
      ct_stm32l4r9ag,
      ct_stm32l4r9ai,
      ct_stm32l4r9vg,
      ct_stm32l4r9vi,
      ct_stm32l4r9zg,
      ct_stm32l4r9zi,
      ct_stm32l4r9zip,
      ct_stm32l4s5ai,
      ct_stm32l4s5qi,
      ct_stm32l4s5vi,
      ct_stm32l4s5zi,
      ct_stm32l4s7ai,
      ct_stm32l4s7vi,
      ct_stm32l4s7zi,
      ct_stm32l4s9ai,
      ct_stm32l4s9vi,
      ct_stm32l4s9zi,
      ct_bl462ecell1,
      ct_bl475eiot01a1,
      ct_bl475eiot01a2,
      ct_bl4s5iiot01a,
      ct_nucleol412kb,
      ct_nucleol412rbp,
      ct_nucleol432kc,
      ct_nucleol433rcp,
      ct_nucleol452re,
      ct_nucleol452rep,
      ct_nucleol476rg,
      ct_nucleol496zg,
      ct_nucleol496zgp,
      ct_nucleol4a6zg,
      ct_nucleol4p5zg,
      ct_nucleol4r5zi,
      ct_nucleol4r5zip,
      ct_stm32l476gdiscovery,
      ct_stm32l496gdiscovery,
      ct_stm32l4p5gdk,
      ct_stm32l4r9idiscovery,

      { ST Microelectronics wb family }
      ct_stm32wb30cea,
      ct_stm32wb35cca,
      ct_stm32wb35cea,
      ct_stm32wb50cg,
      ct_stm32wb55cc,
      ct_stm32wb55ce,
      ct_stm32wb55cg,
      ct_stm32wb55rc,
      ct_stm32wb55re,
      ct_stm32wb55rg,
      ct_stm32wb55vc,
      ct_stm32wb55ve,
      ct_stm32wb55vg,
      ct_stm32wb55vy,
      ct_stm32wb5mmg,
      ct_nucleowb55,
      ct_nucleowb55rg,
      ct_nucleowb55usbdongle,

      { TI - 64 K Flash, 16 K SRAM Devices }
      ct_lm3s1110,
      ct_lm3s1133,
      ct_lm3s1138,
      ct_lm3s1150,
      ct_lm3s1162,
      ct_lm3s1165,
      ct_lm3s1166,
      ct_lm3s2110,
      ct_lm3s2139,
      ct_lm3s6100,
      ct_lm3s6110,

      { TI 128 K Flash, 32 K SRAM devices - Fury Class }
      ct_lm3s1601,
      ct_lm3s1608,
      ct_lm3s1620,
      ct_lm3s1635,
      ct_lm3s1636,
      ct_lm3s1637,
      ct_lm3s1651,
      ct_lm3s2601,
      ct_lm3s2608,
      ct_lm3s2620,
      ct_lm3s2637,
      ct_lm3s2651,
      ct_lm3s6610,
      ct_lm3s6611,
      ct_lm3s6618,
      ct_lm3s6633,
      ct_lm3s6637,
      ct_lm3s8630,

      { TI 256 K Flase, 32 K SRAM devices - Fury Class }
      ct_lm3s1911,
      ct_lm3s1918,
      ct_lm3s1937,
      ct_lm3s1958,
      ct_lm3s1960,
      ct_lm3s1968,
      ct_lm3s1969,
      ct_lm3s2911,
      ct_lm3s2918,
      ct_lm3s2919,
      ct_lm3s2939,
      ct_lm3s2948,
      ct_lm3s2950,
      ct_lm3s2965,
      ct_lm3s6911,
      ct_lm3s6918,
      ct_lm3s6938,
      ct_lm3s6950,
      ct_lm3s6952,
      ct_lm3s6965,
      ct_lm3s8930,
      ct_lm3s8933,
      ct_lm3s8938,
      ct_lm3s8962,
      ct_lm3s8970,
      ct_lm3s8971,

      { TI - Tempest Tempest - 256 K Flash, 64 K SRAM }
      ct_lm3s5951,
      ct_lm3s5956,
      ct_lm3s1b21,
      ct_lm3s2b93,
      ct_lm3s5b91,
      ct_lm3s9b81,
      ct_lm3s9b90,
      ct_lm3s9b92,
      ct_lm3s9b95,
      ct_lm3s9b96,
      
      ct_lm3s5d51,
      
      { TI - Stellaris something }
      ct_lm4f120h5,
      
      { Infineon }
      ct_xmc4500x1024,
      ct_xmc4500x768,
      ct_xmc4502x768,
      ct_xmc4504x512,

      { Allwinner }
      ct_allwinner_a20,

      { Freescale }
      ct_mk20dx128vfm5,
      ct_mk20dx128vft5,
      ct_mk20dx128vlf5,
      ct_mk20dx128vlh5,
      ct_teensy30,
      ct_mk20dx128vmp5,

      ct_mk20dx32vfm5,
      ct_mk20dx32vft5,
      ct_mk20dx32vlf5,
      ct_mk20dx32vlh5,
      ct_mk20dx32vmp5,

      ct_mk20dx64vfm5,
      ct_mk20dx64vft5,
      ct_mk20dx64vlf5,
      ct_mk20dx64vlh5,
      ct_mk20dx64vmp5,

      ct_mk20dx128vlh7,
      ct_mk20dx128vlk7,
      ct_mk20dx128vll7,
      ct_mk20dx128vmc7,

      ct_mk20dx256vlh7,
      ct_mk20dx256vlk7,
      ct_mk20dx256vll7,
      ct_mk20dx256vmc7,
      ct_teensy31,
      ct_teensy32,

      ct_mk20dx64vlh7,
      ct_mk20dx64vlk7,
      ct_mk20dx64vmc7,

      ct_mk22fn512cap12,
      ct_mk22fn512cbp12,
      ct_mk22fn512vdc12,
      ct_mk22fn512vlh12,
      ct_mk22fn512vll12,
      ct_mk22fn512vmp12,
      ct_freedom_k22f,
 
      { Atmel }
      ct_sam3x8e,
      ct_samd21e18a,
      ct_samd21g18a,
      ct_samd21j18a,
      ct_samd51g19a,
      ct_samd51j19a,
      ct_samd51p19a,
      ct_arduino_due,
      ct_flip_n_click,
      ct_xiao,
      ct_feather_m0,
      ct_itsybitsy_m0,
      ct_metro_m0,
      ct_trinket_m0,
      ct_wio_terminal,
      ct_feather_m4,
      ct_itsybitsy_m4,
      ct_metro_m4,
      
      { Nordic Semiconductor }
      ct_nrf51422_xxaa,
      ct_nrf51422_xxab,
      ct_nrf51422_xxac,
      ct_nrf51822_xxaa,
      ct_nrf51822_xxab,
      ct_nrf51822_xxac,
      ct_nrf52832_xxaa,
      ct_nrf52840_xxaa,
      
      ct_sc32442b,

      { Raspberry Pi 2 }
      ct_raspi2,

      { Raspberry rp2040 }
      ct_rp2040,
      ct_rppico,
      ct_feather_rp2040,
      ct_itzybitzy_rp2040,
      ct_tiny_2040,
      ct_qtpy_rp2040,

      ct_thumb2bare:
        begin
         with embedded_controllers[current_settings.controllertype] do
          with linkres do
            begin
              if (embedded_controllers[current_settings.controllertype].controllerunitstr='MK20D5')
              or (embedded_controllers[current_settings.controllertype].controllerunitstr='MK20D7')
              or (embedded_controllers[current_settings.controllertype].controllerunitstr='MK22F51212')
              or (embedded_controllers[current_settings.controllertype].controllerunitstr='MK64F12') then
                Add('ENTRY(_LOWLEVELSTART)')
              else
                Add('ENTRY(_START)');
              Add('MEMORY');
              Add('{');
              if flashsize<>0 then
                begin
                  LinkStr := '    flash : ORIGIN = 0x' + IntToHex(flashbase,8)
                    + ', LENGTH = 0x' + IntToHex(flashsize,8);
                  Add(LinkStr);
                end;

              LinkStr := '    ram : ORIGIN = 0x' + IntToHex(srambase,8)
              	+ ', LENGTH = 0x' + IntToHex(sramsize,8);
              Add(LinkStr);

              Add('}');
              Add('_stack_top = 0x' + IntToHex(sramsize+srambase,8) + ';');
    
              // Add Checksum Calculation for LPC Controllers so that the bootloader starts the uploaded binary 
              if (controllerunitstr = 'LPC8xx') or (controllerunitstr = 'LPC11XX') or (controllerunitstr = 'LPC122X') then
                Add('Startup_Checksum = 0 - (_stack_top + _START + 1 + NonMaskableInt_interrupt + 1 + Hardfault_interrupt + 1);');
              if (controllerunitstr = 'LPC13XX') then
                Add('Startup_Checksum = 0 - (_stack_top + _START + 1 + NonMaskableInt_interrupt + 1 + MemoryManagement_interrupt + 1 + BusFault_interrupt + 1 + UsageFault_interrupt + 1);');
            end;
        end
    else
      if not (cs_link_nolink in current_settings.globalswitches) then
      	 internalerror(200902011);
  end;

  with linkres do
    begin
      Add('SECTIONS');
      Add('{');
      if (embedded_controllers[current_settings.controllertype].controllerunitstr='RP2040') then
      begin
        Add('    .boot2 :');
        Add('    {');
        Add('    _boot2_start = .;');
        Add('    KEEP(*(.boot2))');
        Add('    ASSERT(!( . == _boot2_start ), "RP2040: Error, a device specific 2nd stage bootloader is required for booting");');
        Add('    ASSERT(( . == _boot2_start + 256 ), "RP2040: Error, 2nd stage bootloader in section .boot2 is required to be 256 bytes");');
        if embedded_controllers[current_settings.controllertype].flashsize<>0 then
          Add('    } >flash')
        else
          Add('    } >ram');
      end;
      Add('     .text :');
      Add('    {');
      Add('    _text_start = .;');
      Add('    KEEP(*(.init .init.*))');
      if (embedded_controllers[current_settings.controllertype].controllerunitstr='MK20D5')
         or (embedded_controllers[current_settings.controllertype].controllerunitstr='MK20D7')
         or (embedded_controllers[current_settings.controllertype].controllerunitstr='MK22F51212')
         or (embedded_controllers[current_settings.controllertype].controllerunitstr='MK64F12') then
        begin
          Add('    . = 0x400;');
          Add('    KEEP(*(.flash_config *.flash_config.*))');
        end;
      Add('    *(.text .text.*)');
      Add('    *(.strings)');
      Add('    *(.rodata .rodata.*)');
      Add('    *(.comment)');
      Add('    . = ALIGN(4);');
      Add('    _etext = .;');
      if embedded_controllers[current_settings.controllertype].flashsize<>0 then
        begin
          Add('    } >flash');
          Add('    .note.gnu.build-id : { *(.note.gnu.build-id) } >flash ');
        end
      else
        begin
          Add('    } >ram');
          Add('    .note.gnu.build-id : { *(.note.gnu.build-id) } >ram ');
        end;

      Add('    .data :');
      Add('    {');
      Add('    _data = .;');
      Add('    *(.data .data.*)');
      // Special Section for the Raspberry Pico, needed for linking to spi
      Add('    *(.time_critical*)');
      Add('    KEEP (*(.fpc .fpc.n_version .fpc.n_links))');
      Add('    _edata = .;');
      if embedded_controllers[current_settings.controllertype].flashsize<>0 then
        begin
          Add('    } >ram AT >flash');
        end
      else
        begin
          Add('    } >ram');
        end;
      Add('    .bss :');
      Add('    {');
      Add('    _bss_start = .;');
      Add('    *(.bss .bss.*)');
      Add('    *(COMMON)');
      Add('    } >ram');
      Add('. = ALIGN(4);');
      Add('_bss_end = . ;');
      Add('}');
      Add('_end = .;');
    end;
{$endif ARM}

{$ifdef i386}
  with linkres do
    begin
      Add('ENTRY(_START)');
      Add('SECTIONS');
      Add('{');
      Add('     . = 0x100000;');
      Add('     .text ALIGN (0x1000) :');
      Add('    {');
      Add('    _text = .;');
      Add('    KEEP(*(.init .init.*))');
      Add('    *(.text .text.*)');
      Add('    *(.strings)');
      Add('    *(.rodata .rodata.*)');
      Add('    *(.comment)');
      Add('    _etext = .;');
      Add('    }');
      Add('    .data ALIGN (0x1000) :');
      Add('    {');
      Add('    _data = .;');
      Add('    *(.data .data.*)');
      Add('    KEEP (*(.fpc .fpc.n_version .fpc.n_links))');
      Add('    _edata = .;');
      Add('    }');
      Add('    . = ALIGN(4);');
      Add('    .bss :');
      Add('    {');
      Add('    _bss_start = .;');
      Add('    *(.bss .bss.*)');
      Add('    *(COMMON)');
      Add('    }');
      Add('_bss_end = . ;');
      Add('}');
      Add('_end = .;');
    end;
{$endif i386}

{$ifdef x86_64}
  with linkres do
    begin
      Add('ENTRY(_START)');
      Add('SECTIONS');
      Add('{');
      Add('     . = 0x100000;');
      Add('     .text ALIGN (0x1000) :');
      Add('    {');
      Add('    _text = .;');
      Add('    KEEP(*(.init .init.*))');
      Add('    *(.text .text.*)');
      Add('    *(.strings)');
      Add('    *(.rodata .rodata.*)');
      Add('    *(.comment)');
      Add('    _etext = .;');
      Add('    }');
      Add('    .data ALIGN (0x1000) :');
      Add('    {');
      Add('    _data = .;');
      Add('    *(.data .data.*)');
      Add('    KEEP (*(.fpc .fpc.n_version .fpc.n_links))');
      Add('    _edata = .;');
      Add('    }');
      Add('    . = ALIGN(4);');
      Add('    .bss :');
      Add('    {');
      Add('    _bss_start = .;');
      Add('    *(.bss .bss.*)');
      Add('    *(COMMON)');
      Add('    }');
      Add('_bss_end = . ;');
      Add('}');
      Add('_end = .;');
    end;
{$endif x86_64}

{$ifdef AVR}
  with linkres do
    begin
      { linker script from ld 2.19 }
      Add('ENTRY(_START)');
      Add('OUTPUT_FORMAT("elf32-avr","elf32-avr","elf32-avr")');
      case current_settings.cputype of
       cpu_avr1:
         Add('OUTPUT_ARCH(avr:1)');
       cpu_avr2:
         Add('OUTPUT_ARCH(avr:2)');
       cpu_avr25:
         Add('OUTPUT_ARCH(avr:25)');
       cpu_avr3:
         Add('OUTPUT_ARCH(avr:3)');
       cpu_avr31:
         Add('OUTPUT_ARCH(avr:31)');
       cpu_avr35:
         Add('OUTPUT_ARCH(avr:35)');
       cpu_avr4:
         Add('OUTPUT_ARCH(avr:4)');
       cpu_avr5:
         Add('OUTPUT_ARCH(avr:5)');
       cpu_avr51:
         Add('OUTPUT_ARCH(avr:51)');
       cpu_avr6:
         Add('OUTPUT_ARCH(avr:6)');
       cpu_avrxmega3:
         Add('OUTPUT_ARCH(avr:103)');
       cpu_avrtiny:
         Add('OUTPUT_ARCH(avr:100)');
       else
         Internalerror(2015072701);
      end;
      Add('MEMORY');
      with embedded_controllers[current_settings.controllertype] do
        begin
          Add('{');
          Add('  text      (rx)   : ORIGIN = 0, LENGTH = 0x'+IntToHex(flashsize,6));
          Add('  data      (rw!x) : ORIGIN = 0x'+IntToHex($800000+srambase,6)+', LENGTH = 0x'+IntToHex(sramsize,6));
          Add('  eeprom    (rw!x) : ORIGIN = 0x810000, LENGTH = 0x'+IntToHex(eepromsize,6));
          Add('  fuse      (rw!x) : ORIGIN = 0x820000, LENGTH = 1K');
          Add('  lock      (rw!x) : ORIGIN = 0x830000, LENGTH = 1K');
          Add('  signature (rw!x) : ORIGIN = 0x840000, LENGTH = 1K');
          Add('}');
          Add('_stack_top = 0x' + IntToHex(srambase+sramsize-1,4) + ';');
        end;
      Add('SECTIONS');
      Add('{');
      Add('  /* Read-only sections, merged into text segment: */');
      Add('  .hash          : { *(.hash)		}');
      Add('  .dynsym        : { *(.dynsym)		}');
      Add('  .dynstr        : { *(.dynstr)		}');
      Add('  .gnu.version   : { *(.gnu.version)	}');
      Add('  .gnu.version_d   : { *(.gnu.version_d)	}');
      Add('  .gnu.version_r   : { *(.gnu.version_r)	}');
      Add('  .rel.init      : { *(.rel.init)		}');
      Add('  .rela.init     : { *(.rela.init)	}');
      Add('  .rel.text      :');
      Add('    {');
      Add('      *(.rel.text)');
      Add('      *(.rel.text.*)');
      Add('      *(.rel.gnu.linkonce.t*)');
      Add('    }');
      Add('  .rela.text     :');
      Add('    {');
      Add('      *(.rela.text)');
      Add('      *(.rela.text.*)');
      Add('      *(.rela.gnu.linkonce.t*)');
      Add('    }');
      Add('  .rel.fini      : { *(.rel.fini)		}');
      Add('  .rela.fini     : { *(.rela.fini)	}');
      Add('  .rel.rodata    :');
      Add('    {');
      Add('      *(.rel.rodata)');
      Add('      *(.rel.rodata.*)');
      Add('      *(.rel.gnu.linkonce.r*)');
      Add('    }');
      Add('  .rela.rodata   :');
      Add('    {');
      Add('      *(.rela.rodata)');
      Add('      *(.rela.rodata.*)');
      Add('      *(.rela.gnu.linkonce.r*)');
      Add('    }');
      Add('  .rel.data      :');
      Add('    {');
      Add('      *(.rel.data)');
      Add('      *(.rel.data.*)');
      Add('      *(.rel.gnu.linkonce.d*)');
      Add('    }');
      Add('  .rela.data     :');
      Add('    {');
      Add('      *(.rela.data)');
      Add('      *(.rela.data.*)');
      Add('      *(.rela.gnu.linkonce.d*)');
      Add('    }');
      Add('  .rel.ctors     : { *(.rel.ctors)	}');
      Add('  .rela.ctors    : { *(.rela.ctors)	}');
      Add('  .rel.dtors     : { *(.rel.dtors)	}');
      Add('  .rela.dtors    : { *(.rela.dtors)	}');
      Add('  .rel.got       : { *(.rel.got)		}');
      Add('  .rela.got      : { *(.rela.got)		}');
      Add('  .rel.bss       : { *(.rel.bss)		}');
      Add('  .rela.bss      : { *(.rela.bss)		}');
      Add('  .rel.plt       : { *(.rel.plt)		}');
      Add('  .rela.plt      : { *(.rela.plt)		}');
      Add('  /* Internal text space or external memory.  */');
      Add('  .text   :');
      Add('  {');
      Add('    KEEP(*(.init .init.*))');
      Add('    /* For data that needs to reside in the lower 64k of progmem.  */');
      Add('    *(.progmem.gcc*)');
      Add('    *(.progmem*)');
      Add('    . = ALIGN(2);');
      Add('     __trampolines_start = . ;');
      Add('    /* The jump trampolines for the 16-bit limited relocs will reside here.  */');
      Add('    *(.trampolines)');
      Add('    *(.trampolines*)');
      Add('     __trampolines_end = . ;');
      Add('    /* For future tablejump instruction arrays for 3 byte pc devices.');
      Add('       We don''t relax jump/call instructions within these sections.  */');
      Add('    *(.jumptables)');
      Add('    *(.jumptables*)');
      Add('    /* For code that needs to reside in the lower 128k progmem.  */');
      Add('    *(.lowtext)');
      Add('    *(.lowtext*)');
      Add('     __ctors_start = . ;');
      Add('     *(.ctors)');
      Add('     __ctors_end = . ;');
      Add('     __dtors_start = . ;');
      Add('     *(.dtors)');
      Add('     __dtors_end = . ;');
      Add('    KEEP(SORT(*)(.ctors))');
      Add('    KEEP(SORT(*)(.dtors))');
      Add('    /* From this point on, we don''t bother about wether the insns are');
      Add('       below or above the 16 bits boundary.  */');
      Add('    *(.init0)  /* Start here after reset.  */');
      Add('    KEEP (*(.init0))');
      Add('    *(.init1)');
      Add('    KEEP (*(.init1))');
      Add('    *(.init2)  /* Clear __zero_reg__, set up stack pointer.  */');
      Add('    KEEP (*(.init2))');
      Add('    *(.init3)');
      Add('    KEEP (*(.init3))');
      Add('    *(.init4)  /* Initialize data and BSS.  */');
      Add('    KEEP (*(.init4))');
      Add('    *(.init5)');
      Add('    KEEP (*(.init5))');
      Add('    *(.init6)  /* C++ constructors.  */');
      Add('    KEEP (*(.init6))');
      Add('    *(.init7)');
      Add('    KEEP (*(.init7))');
      Add('    *(.init8)');
      Add('    KEEP (*(.init8))');
      Add('    *(.init9)  /* Call main().  */');
      Add('    KEEP (*(.init9))');
      Add('    *(.text)');
      Add('    . = ALIGN(2);');
      Add('    *(.text.*)');
      Add('    . = ALIGN(2);');
      Add('    *(.fini9)  /* _exit() starts here.  */');
      Add('    KEEP (*(.fini9))');
      Add('    *(.fini8)');
      Add('    KEEP (*(.fini8))');
      Add('    *(.fini7)');
      Add('    KEEP (*(.fini7))');
      Add('    *(.fini6)  /* C++ destructors.  */');
      Add('    KEEP (*(.fini6))');
      Add('    *(.fini5)');
      Add('    KEEP (*(.fini5))');
      Add('    *(.fini4)');
      Add('    KEEP (*(.fini4))');
      Add('    *(.fini3)');
      Add('    KEEP (*(.fini3))');
      Add('    *(.fini2)');
      Add('    KEEP (*(.fini2))');
      Add('    *(.fini1)');
      Add('    KEEP (*(.fini1))');
      Add('    *(.fini0)  /* Infinite loop after program termination.  */');
      Add('    KEEP (*(.fini0))');
      Add('     _etext = . ;');
      Add('  }  > text');
      Add('  .data	  : AT (ADDR (.text) + SIZEOF (.text))');
      Add('  {');
      Add('     PROVIDE (__data_start = .) ;');
      Add('    *(.data)');
      Add('    *(.data*)');
      Add('    *(.rodata)  /* We need to include .rodata here if gcc is used */');
      Add('    *(.rodata*) /* with -fdata-sections.  */');
      Add('    *(.gnu.linkonce.d*)');
      Add('    . = ALIGN(2);');
      Add('     _edata = . ;');
      Add('     PROVIDE (__data_end = .) ;');
      Add('  }  > data');
      Add('  .bss   : AT (ADDR (.bss))');
      Add('  {');
      Add('     PROVIDE (__bss_start = .) ;');
      Add('    *(.bss)');
      Add('    *(.bss*)');
      Add('    *(COMMON)');
      Add('     PROVIDE (__bss_end = .) ;');
      Add('  }  > data');
      Add('   __data_load_start = LOADADDR(.data);');
      Add('   __data_load_end = __data_load_start + SIZEOF(.data);');
      Add('  /* Global data not cleared after reset.  */');
      Add('  .noinit  :');
      Add('  {');
      Add('     PROVIDE (__noinit_start = .) ;');
      Add('    *(.noinit*)');
      Add('     PROVIDE (__noinit_end = .) ;');
      Add('     _end = . ;');
      Add('     PROVIDE (__heap_start = .) ;');
      Add('  }  > data');
      Add('  .eeprom  :');
      Add('  {');
      Add('    *(.eeprom*)');
      Add('     __eeprom_end = . ;');
      Add('  }  > eeprom');
      Add('  .fuse  :');
      Add('  {');
      Add('    KEEP(*(.fuse))');
      Add('    KEEP(*(.lfuse))');
      Add('    KEEP(*(.hfuse))');
      Add('    KEEP(*(.efuse))');
      Add('  }  > fuse');
      Add('  .lock  :');
      Add('  {');
      Add('    KEEP(*(.lock*))');
      Add('  }  > lock');
      Add('  .signature  :');
      Add('  {');
      Add('    KEEP(*(.signature*))');
      Add('  }  > signature');
      Add('  /* Stabs debugging sections.  */');
      Add('  .stab 0 : { *(.stab) }');
      Add('  .stabstr 0 : { *(.stabstr) }');
      Add('  .stab.excl 0 : { *(.stab.excl) }');
      Add('  .stab.exclstr 0 : { *(.stab.exclstr) }');
      Add('  .stab.index 0 : { *(.stab.index) }');
      Add('  .stab.indexstr 0 : { *(.stab.indexstr) }');
      Add('  .comment 0 : { *(.comment) }');
      Add('  /* DWARF debug sections.');
      Add('     Symbols in the DWARF debugging sections are relative to the beginning');
      Add('     of the section so we begin them at 0.  */');
      Add('  /* DWARF 1 */');
      Add('  .debug          0 : { *(.debug) }');
      Add('  .line           0 : { *(.line) }');
      Add('  /* GNU DWARF 1 extensions */');
      Add('  .debug_srcinfo  0 : { *(.debug_srcinfo) }');
      Add('  .debug_sfnames  0 : { *(.debug_sfnames) }');
      Add('  /* DWARF 1.1 and DWARF 2 */');
      Add('  .debug_aranges  0 : { *(.debug_aranges) }');
      Add('  .debug_pubnames 0 : { *(.debug_pubnames) }');
      Add('  /* DWARF 2 */');
      Add('  .debug_info     0 : { *(.debug_info) *(.gnu.linkonce.wi.*) }');
      Add('  .debug_abbrev   0 : { *(.debug_abbrev) }');
      Add('  .debug_line     0 : { *(.debug_line) }');
      Add('  .debug_frame    0 : { *(.debug_frame) }');
      Add('  .debug_str      0 : { *(.debug_str) }');
      Add('  .debug_loc      0 : { *(.debug_loc) }');
      Add('  .debug_macinfo  0 : { *(.debug_macinfo) }');
      Add('  /* DWARF 3 */');
      Add('  .debug_pubtypes 0 : { *(.debug_pubtypes) }');
      Add('  .debug_ranges   0 : { *(.debug_ranges) }');
      Add('  /* DWARF Extension.  */');
      Add('  .debug_macro    0 : { *(.debug_macro) }');

      Add('}');
    end;
{$endif AVR}

{$ifdef MIPSEL}
  case current_settings.controllertype of
      ct_none:
           begin
           end;
      ct_pic32mx110f016b,
      ct_pic32mx110f016c,
      ct_pic32mx110f016d,
      ct_pic32mx120f032b,
      ct_pic32mx120f032c,
      ct_pic32mx120f032d,
      ct_pic32mx130f064b,
      ct_pic32mx130f064c,
      ct_pic32mx130f064d,
      ct_pic32mx150f128b,
      ct_pic32mx150f128c,
      ct_pic32mx150f128d,
      ct_pic32mx210f016b,
      ct_pic32mx210f016c,
      ct_pic32mx210f016d,
      ct_pic32mx220f032b,
      ct_pic32mx220f032c,
      ct_pic32mx220f032d,
      ct_pic32mx230f064b,
      ct_pic32mx230f064c,
      ct_pic32mx230f064d,
      ct_pic32mx250f128b,
      ct_pic32mx250f128c,
      ct_pic32mx250f128d,
      ct_pic32mx775f256h,
      ct_pic32mx775f256l,
      ct_pic32mx775f512h,
      ct_pic32mx775f512l,
      ct_pic32mx795f512h,
      ct_pic32mx795f512l:
        begin
         with embedded_controllers[current_settings.controllertype] do
          with linkres do
            begin
              Add('OUTPUT_FORMAT("elf32-tradlittlemips")');
              Add('OUTPUT_ARCH(pic32mx)');
              Add('ENTRY(_reset)');
              Add('PROVIDE(_vector_spacing = 0x00000001);');
              Add('_ebase_address = 0x'+IntToHex(flashbase,8)+';');
              Add('_RESET_ADDR              = 0xBFC00000;');
              Add('_BEV_EXCPT_ADDR          = 0xBFC00380;');
              Add('_DBG_EXCPT_ADDR          = 0xBFC00480;');
              Add('_GEN_EXCPT_ADDR          = _ebase_address + 0x180;');
              Add('MEMORY');
              Add('{');
              if flashsize<>0 then
                begin
                  Add('  kseg0_program_mem          : ORIGIN = 0x'+IntToHex(flashbase,8)+', LENGTH = 0x'+IntToHex(flashsize,8));
                  //TODO This should better be placed into the controllertype records
                  Add('  kseg1_boot_mem             : ORIGIN = 0xBFC00000, LENGTH = 0xbef');
                  Add('  config3                    : ORIGIN = 0xBFC00BF0, LENGTH = 0x4');
                  Add('  config2                    : ORIGIN = 0xBFC00BF4, LENGTH = 0x4');
                  Add('  config1                    : ORIGIN = 0xBFC00BF8, LENGTH = 0x4');
                  Add('  config0                    : ORIGIN = 0xBFC00BFC, LENGTH = 0x4');
                end;

              Add('  ram                        : ORIGIN = 0x' + IntToHex(srambase,8)
              	+ ', LENGTH = 0x' + IntToHex(sramsize,8));

              Add('}');
              Add('_stack_top = 0x' + IntToHex(sramsize+srambase,8) + ';');
            end;
        end
  end;

  with linkres do
    begin
      Add('SECTIONS');
      Add('{');
      Add('    .reset _RESET_ADDR :');
      Add('    {');
      Add('      KEEP(*(.reset .reset.*))');
      Add('      KEEP(*(.startup .startup.*))');
      Add('    } > kseg1_boot_mem');
      Add('    .bev_excpt _BEV_EXCPT_ADDR :');
      Add('    {');
      Add('      KEEP(*(.bev_handler))');
      Add('    } > kseg1_boot_mem');

      Add('    .text :');
      Add('    {');
      Add('    _text_start = .;');
      Add('    . = _text_start + 0x180;');
      Add('    KEEP(*(.gen_handler))');
      Add('    . = _text_start + 0x200;');
      Add('    KEEP(*(.init .init.*))');
      Add('    *(.text .text.*)');
      Add('    *(.strings)');
      Add('    *(.rodata .rodata.*)');
      Add('    *(.comment)');
      Add('    _etext = .;');
      if embedded_controllers[current_settings.controllertype].flashsize<>0 then
        begin
          Add('    } >kseg0_program_mem');
        end
      else
        begin
          Add('    } >ram');
        end;
      Add('    .note.gnu.build-id : { *(.note.gnu.build-id) }');

      Add('    .data :');
      Add('    {');
      Add('    _data = .;');
      Add('    *(.data .data.*)');
      Add('    KEEP (*(.fpc .fpc.n_version .fpc.n_links))');
      Add('    . = .;');
      Add('    _gp = ALIGN(16) + 0x7ff0;');
      Add('    _edata = .;');
      if embedded_controllers[current_settings.controllertype].flashsize<>0 then
        begin
          Add('    } >ram AT >kseg0_program_mem');
        end
      else
        begin
          Add('    } >ram');
        end;
      Add('  .config_BFC00BF0 : {');
      Add('    KEEP(*(.config_BFC00BF0))');
      Add('  } > config3');
      Add('  .config_BFC00BF4 : {');
      Add('    KEEP(*(.config_BFC00BF4))');
      Add('  } > config2');
      Add('  .config_BFC00BF8 : {');
      Add('    KEEP(*(.config_BFC00BF8))');
      Add('  } > config1');
      Add('  .config_BFC00BFC : {');
      Add('    KEEP(*(.config_BFC00BFC))');
      Add('  } > config0');
      Add('    .bss :');
      Add('    {');
      Add('    _bss_start = .;');
      Add('    *(.bss .bss.*)');
      Add('    *(COMMON)');
      Add('    } >ram');
      Add('. = ALIGN(4);');
      Add('_bss_end = . ;');
      Add('  .comment       0 : { *(.comment) }');
      Add('  /* DWARF debug sections.');
      Add('     Symbols in the DWARF debugging sections are relative to the beginning');
      Add('     of the section so we begin them at 0.  */');
      Add('  /* DWARF 1 */');
      Add('  .debug          0 : { *(.debug) }');
      Add('  .line           0 : { *(.line) }');
      Add('  /* GNU DWARF 1 extensions */');
      Add('  .debug_srcinfo  0 : { *(.debug_srcinfo) }');
      Add('  .debug_sfnames  0 : { *(.debug_sfnames) }');
      Add('  /* DWARF 1.1 and DWARF 2 */');
      Add('  .debug_aranges  0 : { *(.debug_aranges) }');
      Add('  .debug_pubnames 0 : { *(.debug_pubnames) }');
      Add('  /* DWARF 2 */');
      Add('  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }');
      Add('  .debug_abbrev   0 : { *(.debug_abbrev) }');
      Add('  /DISCARD/         : { *(.debug_line) }');
      Add('  .debug_frame    0 : { *(.debug_frame) }');
      Add('  .debug_str      0 : { *(.debug_str) }');
      Add('  /DISCARD/         : { *(.debug_loc) }');
      Add('  .debug_macinfo  0 : { *(.debug_macinfo) }');
      Add('  /* SGI/MIPS DWARF 2 extensions */');
      Add('  .debug_weaknames 0 : { *(.debug_weaknames) }');
      Add('  .debug_funcnames 0 : { *(.debug_funcnames) }');
      Add('  .debug_typenames 0 : { *(.debug_typenames) }');
      Add('  .debug_varnames  0 : { *(.debug_varnames) }');
      Add('  /* DWARF 3 */');
      Add('  .debug_pubtypes 0 : { *(.debug_pubtypes) }');
      Add('  .debug_ranges   0 : { *(.debug_ranges) }');
      Add('  .gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }');
      Add('  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }');
      Add('  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }');
      Add('  .mdebug.abi32 : { KEEP(*(.mdebug.abi32)) }');
      Add('  .mdebug.abiN32 : { KEEP(*(.mdebug.abiN32)) }');
      Add('  .mdebug.abi64 : { KEEP(*(.mdebug.abi64)) }');
      Add('  .mdebug.abiO64 : { KEEP(*(.mdebug.abiO64)) }');
      Add('  .mdebug.eabi32 : { KEEP(*(.mdebug.eabi32)) }');
      Add('  .mdebug.eabi64 : { KEEP(*(.mdebug.eabi64)) }');
      Add('  /DISCARD/ : { *(.rel.dyn) }');
      Add('  /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) *(.gnu.lto_*) }');
      Add('}');
      Add('_end = .;');
    end;
{$endif MIPSEL}

{$ifdef RISCV32}
  with linkres do
    begin
      Add('OUTPUT_ARCH("riscv")');
      Add('ENTRY(_START)');
      Add('MEMORY');
      with embedded_controllers[current_settings.controllertype] do
        begin
          Add('{');
          Add('  flash      (rx)   : ORIGIN = 0x'+IntToHex(flashbase,6)+', LENGTH = 0x'+IntToHex(flashsize,6));
          Add('  ram        (rw!x) : ORIGIN = 0x'+IntToHex(srambase,6)+', LENGTH = 0x'+IntToHex(sramsize,6));
          Add('}');
          Add('_stack_top = 0x' + IntToHex(srambase+sramsize-1,4) + ';');
        end;
      Add('SECTIONS');
      Add('{');
      Add('  .text :');
      Add('  {');
      Add('    _text_start = .;');
      Add('    KEEP(*(.init .init.*))');
      Add('    *(.text .text.*)');
      Add('    *(.strings)');
      Add('    *(.rodata .rodata.*)');
      Add('    *(.comment)');
      Add('    . = ALIGN(4);');
      Add('    _etext = .;');
      if embedded_controllers[current_settings.controllertype].flashsize<>0 then
        begin
          Add('  } >flash');
          //Add('    .note.gnu.build-id : { *(.note.gnu.build-id) } >flash ');
        end
      else
        begin
          Add('  } >ram');
          //Add('    .note.gnu.build-id : { *(.note.gnu.build-id) } >ram ');
        end;

      Add('  .data :');
      Add('  {');
      Add('    _data = .;');
      Add('    *(.data .data.*)');
      Add('    KEEP (*(.fpc .fpc.n_version .fpc.n_links))');
      Add('    _edata = .;');
      if embedded_controllers[current_settings.controllertype].flashsize<>0 then
        begin
          Add('  } >ram AT >flash');
        end
      else
        begin
          Add('  } >ram');
        end;
      Add('  .bss :');
      Add('  {');
      Add('    _bss_start = .;');
      Add('    *(.bss .bss.*)');
      Add('    *(COMMON)');
      Add('  } >ram');
      Add('  . = ALIGN(4);');
      Add('  _bss_end = . ;');
      Add('  /* Stabs debugging sections.  */');
      Add('  .stab          0 : { *(.stab) }');
      Add('  .stabstr       0 : { *(.stabstr) }');
      Add('  .stab.excl     0 : { *(.stab.excl) }');
      Add('  .stab.exclstr  0 : { *(.stab.exclstr) }');
      Add('  .stab.index    0 : { *(.stab.index) }');
      Add('  .stab.indexstr 0 : { *(.stab.indexstr) }');
      Add('  .comment       0 : { *(.comment) }');
      Add('  /* DWARF debug sections.');
      Add('     Symbols in the DWARF debugging sections are relative to the beginning');
      Add('     of the section so we begin them at 0.  */');
      Add('  /* DWARF 1 */');
      Add('  .debug          0 : { *(.debug) }');
      Add('  .line           0 : { *(.line) }');
      Add('  /* GNU DWARF 1 extensions */');
      Add('  .debug_srcinfo  0 : { *(.debug_srcinfo) }');
      Add('  .debug_sfnames  0 : { *(.debug_sfnames) }');
      Add('  /* DWARF 1.1 and DWARF 2 */');
      Add('  .debug_aranges  0 : { *(.debug_aranges) }');
      Add('  .debug_pubnames 0 : { *(.debug_pubnames) }');
      Add('  /* DWARF 2 */');
      Add('  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }');
      Add('  .debug_abbrev   0 : { *(.debug_abbrev) }');
      Add('  .debug_line     0 : { *(.debug_line) }');
      Add('  .debug_frame    0 : { *(.debug_frame) }');
      Add('  .debug_str      0 : { *(.debug_str) }');
      Add('  .debug_loc      0 : { *(.debug_loc) }');
      Add('  .debug_macinfo  0 : { *(.debug_macinfo) }');
      Add('  /* SGI/MIPS DWARF 2 extensions */');
      Add('  .debug_weaknames 0 : { *(.debug_weaknames) }');
      Add('  .debug_funcnames 0 : { *(.debug_funcnames) }');
      Add('  .debug_typenames 0 : { *(.debug_typenames) }');
      Add('  .debug_varnames  0 : { *(.debug_varnames) }');
      Add('  /* DWARF 3 */');
      Add('  .debug_pubtypes 0 : { *(.debug_pubtypes) }');
      Add('  .debug_ranges   0 : { *(.debug_ranges) }');

      Add('}');
      Add('_end = .;');

    end;
  {$endif RISCV32}

  {$ifdef XTENSA}
  with linkres do
    begin
      Add('/* Script for -z combreloc: combine and sort reloc sections */');
      Add('/* Copyright (C) 2014-2018 Free Software Foundation, Inc.');
      Add('   Copying and distribution of this script, with or without modification,');
      Add('   are permitted in any medium without royalty provided the copyright');
      Add('   notice and this notice are preserved.  */');
      Add('ENTRY(_start)');
      Add('SEARCH_DIR("=/builds/idf/crosstool-NG/builds/xtensa-esp32-elf/xtensa-esp32-elf/lib"); SEARCH_DIR("=/usr/local/lib"); SEARCH_DIR("=/lib"); SEARCH_DIR("=/usr/lib");');
      Add('SECTIONS');
      Add('{');
      Add('  /* Read-only sections, merged into text segment: */');
      Add('  PROVIDE (__executable_start = 0x400000); . = 0x400000 + SIZEOF_HEADERS;');
      Add('  .interp         : { *(.interp) }');
      Add('  .note.gnu.build-id : { *(.note.gnu.build-id) }');
      Add('  .hash           : { *(.hash) }');
      Add('  .gnu.hash       : { *(.gnu.hash) }');
      Add('  .dynsym         : { *(.dynsym) }');
      Add('  .dynstr         : { *(.dynstr) }');
      Add('  .gnu.version    : { *(.gnu.version) }');
      Add('  .gnu.version_d  : { *(.gnu.version_d) }');
      Add('  .gnu.version_r  : { *(.gnu.version_r) }');
      Add('  .rela.dyn       :');
      Add('    {');
      Add('      *(.rela.init)');
      Add('      *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*)');
      Add('      *(.rela.fini)');
      Add('      *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*)');
      Add('      *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*)');
      Add('      *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*)');
      Add('      *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*)');
      Add('      *(.rela.ctors)');
      Add('      *(.rela.dtors)');
      Add('      *(.rela.got)');
      Add('      *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*)');
      Add('    }');
      Add('  .rela.plt       : { *(.rela.plt) }');
      Add('  /* .plt* sections are embedded in .text */');
      Add('  .text           :');
      Add('  {');
      Add('    *(.got.plt* .plt*)');
      Add('    KEEP (*(.init.literal))');
      Add('    KEEP (*(SORT_NONE(.init)))');
      Add('    *(.literal .text .stub .literal.* .text.* .gnu.linkonce.literal.* .gnu.linkonce.t.*.literal .gnu.linkonce.t.*)');
      Add('    /* .gnu.warning sections are handled specially by elf32.em.  */');
      Add('    *(.gnu.warning)');
      Add('    KEEP (*(.fini.literal))');
      Add('    KEEP (*(SORT_NONE(.fini)))');
      Add('  } =0');
      Add('  PROVIDE (__etext = .);');
      Add('  PROVIDE (_etext = .);');
      Add('  PROVIDE (etext = .);');
      Add('  .rodata         : { *(.rodata .rodata.* .gnu.linkonce.r.*) }');
      Add('  .rodata1        : { *(.rodata1) }');
      Add('  .got.loc        : { *(.got.loc) }');
      Add('  .xt_except_table   : ONLY_IF_RO { KEEP (*(.xt_except_table .xt_except_table.* .gnu.linkonce.e.*)) }');
      Add('  .eh_frame_hdr : { *(.eh_frame_hdr) }');
      Add('  .eh_frame       : ONLY_IF_RO { KEEP (*(.eh_frame)) }');
      Add('  .gcc_except_table   : ONLY_IF_RO { *(.gcc_except_table .gcc_except_table.*) }');
      Add('  /* Adjust the address for the data segment.  We want to adjust up to');
      Add('     the same address within the page on the next page up.  */');
      Add('  . = ALIGN(CONSTANT (MAXPAGESIZE)) + (. & (CONSTANT (MAXPAGESIZE) - 1));');
      Add('  /* Exception handling  */');
      Add('  .eh_frame       : ONLY_IF_RW { KEEP (*(.eh_frame)) }');
      Add('  .gcc_except_table   : ONLY_IF_RW { *(.gcc_except_table .gcc_except_table.*) }');
      Add('  /* Thread Local Storage sections  */');
      Add('  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }');
      Add('  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }');
      Add('  .preinit_array     :');
      Add('  {');
      Add('    PROVIDE_HIDDEN (__preinit_array_start = .);');
      Add('    KEEP (*(.preinit_array))');
      Add('    PROVIDE_HIDDEN (__preinit_array_end = .);');
      Add('  }');
      Add('  .init_array     :');
      Add('  {');
      Add('     PROVIDE_HIDDEN (__init_array_start = .);');
      Add('     KEEP (*(SORT(.init_array.*)))');
      Add('     KEEP (*(.init_array))');
      Add('     PROVIDE_HIDDEN (__init_array_end = .);');
      Add('  }');
      Add('  .fini_array     :');
      Add('  {');
      Add('    PROVIDE_HIDDEN (__fini_array_start = .);');
      Add('    KEEP (*(SORT(.fini_array.*)))');
      Add('    KEEP (*(.fini_array))');
      Add('    PROVIDE_HIDDEN (__fini_array_end = .);');
      Add('  }');
      Add('  .ctors          :');
      Add('  {');
      Add('    /* gcc uses crtbegin.o to find the start of');
      Add('       the constructors, so we make sure it is');
      Add('       first.  Because this is a wildcard, it');
      Add('       doesn''t matter if the user does not');
      Add('       actually link against crtbegin.o; the');
      Add('       linker won''t look for a file to match a');
      Add('       wildcard.  The wildcard also means that it');
      Add('       doesn''t matter which directory crtbegin.o');
      Add('       is in.  */');
      Add('    KEEP (*crtbegin.o(.ctors))');
      Add('    KEEP (*crtbegin?.o(.ctors))');
      Add('    /* We don''t want to include the .ctor section from');
      Add('       the crtend.o file until after the sorted ctors.');
      Add('       The .ctor section from the crtend file contains the');
      Add('       end of ctors marker and it must be last */');
      Add('    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .ctors))');
      Add('    KEEP (*(SORT(.ctors.*)))');
      Add('    KEEP (*(.ctors))');
      Add('  }');
      Add('  .dtors          :');
      Add('  {');
      Add('    KEEP (*crtbegin.o(.dtors))');
      Add('    KEEP (*crtbegin?.o(.dtors))');
      Add('    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .dtors))');
      Add('    KEEP (*(SORT(.dtors.*)))');
      Add('    KEEP (*(.dtors))');
      Add('  }');
      Add('  .jcr            : { KEEP (*(.jcr)) }');
      Add('  .data.rel.ro : { *(.data.rel.ro.local* .gnu.linkonce.d.rel.ro.local.*) *(.data.rel.ro .data.rel.ro.* .gnu.linkonce.d.rel.ro.*) }');
      Add('  .xt_except_table   : ONLY_IF_RW { KEEP (*(.xt_except_table .xt_except_table.* .gnu.linkonce.e.*)) }');
      Add('  .dynamic        : { *(.dynamic) }');
      Add('  .got            : { *(.got) }');
      Add('  .data           :');
      Add('  {');
      Add('    *(.data .data.* .gnu.linkonce.d.*)');
      Add('    SORT(CONSTRUCTORS)');
      Add('    KEEP (*(.fpc .fpc.n_version .fpc.n_links))');
      Add('  }');
      Add('  .data1          : { *(.data1) }');
      Add('  .xt_except_desc   :');
      Add('  {');
      Add('    *(.xt_except_desc .xt_except_desc.* .gnu.linkonce.h.*)');
      Add('    *(.xt_except_desc_end)');
      Add('  }');
      Add('  .lit4           :');
      Add('  {');
      Add('    PROVIDE (_lit4_start = .);');
      Add('    *(.lit4 .lit4.* .gnu.linkonce.lit4.*)');
      Add('    PROVIDE (_lit4_end = .);');
      Add('  }');
      Add('  _edata = .; PROVIDE (edata = .);');
      Add('  __bss_start = .;');
      Add('  .bss            :');
      Add('  {');
      Add('   *(.dynbss)');
      Add('   *(.bss .bss.* .gnu.linkonce.b.*)');
      Add('   *(COMMON)');
      Add('   /* Align here to ensure that the .bss section occupies space up to');
      Add('      _end.  Align after .bss to ensure correct alignment even if the');
      Add('      .bss section disappears because there are no input sections.');
      Add('      FIXME: Why do we need it? When there is no .bss section, we don''t');
      Add('      pad the .data section.  */');
      Add('   . = ALIGN(. != 0 ? 32 / 8 : 1);');
      Add('  }');
      Add('  . = ALIGN(32 / 8);');
      Add('  . = ALIGN(32 / 8);');
      Add('  _end = .; PROVIDE (end = .);');
      Add('  /* Stabs debugging sections.  */');
      Add('  .stab          0 : { *(.stab) }');
      Add('  .stabstr       0 : { *(.stabstr) }');
      Add('  .stab.excl     0 : { *(.stab.excl) }');
      Add('  .stab.exclstr  0 : { *(.stab.exclstr) }');
      Add('  .stab.index    0 : { *(.stab.index) }');
      Add('  .stab.indexstr 0 : { *(.stab.indexstr) }');
      Add('  .comment       0 : { *(.comment) }');
      Add('  /* DWARF debug sections.');
      Add('     Symbols in the DWARF debugging sections are relative to the beginning');
      Add('     of the section so we begin them at 0.  */');
      Add('  /* DWARF 1 */');
      Add('  .debug          0 : { *(.debug) }');
      Add('  .line           0 : { *(.line) }');
      Add('  /* GNU DWARF 1 extensions */');
      Add('  .debug_srcinfo  0 : { *(.debug_srcinfo) }');
      Add('  .debug_sfnames  0 : { *(.debug_sfnames) }');
      Add('  /* DWARF 1.1 and DWARF 2 */');
      Add('  .debug_aranges  0 : { *(.debug_aranges) }');
      Add('  .debug_pubnames 0 : { *(.debug_pubnames) }');
      Add('  /* DWARF 2 */');
      Add('  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }');
      Add('  .debug_abbrev   0 : { *(.debug_abbrev) }');
      Add('  .debug_line     0 : { *(.debug_line .debug_line.* .debug_line_end ) }');
      Add('  .debug_frame    0 : { *(.debug_frame) }');
      Add('  .debug_str      0 : { *(.debug_str) }');
      Add('  .debug_loc      0 : { *(.debug_loc) }');
      Add('  .debug_macinfo  0 : { *(.debug_macinfo) }');
      Add('  /* SGI/MIPS DWARF 2 extensions */');
      Add('  .debug_weaknames 0 : { *(.debug_weaknames) }');
      Add('  .debug_funcnames 0 : { *(.debug_funcnames) }');
      Add('  .debug_typenames 0 : { *(.debug_typenames) }');
      Add('  .debug_varnames  0 : { *(.debug_varnames) }');
      Add('  /* DWARF 3 */');
      Add('  .debug_pubtypes 0 : { *(.debug_pubtypes) }');
      Add('  .debug_ranges   0 : { *(.debug_ranges) }');
      Add('  /* DWARF Extension.  */');
      Add('  .debug_macro    0 : { *(.debug_macro) }');
      Add('  .debug_addr     0 : { *(.debug_addr) }');
      Add('  .gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }');
      Add('  .xt.lit       0 : { KEEP (*(.xt.lit .xt.lit.* .gnu.linkonce.p.*)) }');
      Add('  .xt.insn      0 : { KEEP (*(.xt.insn .gnu.linkonce.x.*)) }');
      Add('  .xt.prop      0 : { KEEP (*(.xt.prop .xt.prop.* .gnu.linkonce.prop.*)) }');
      Add('  /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink)  *(.gnu.lto_*) }');
      Add('}');
    end;
{$endif XTENSA}

  { Write and Close response }
  linkres.writetodisk;
  linkres.free;

  WriteResponseFile:=True;

end;


function TlinkerEmbedded.MakeExecutable:boolean;
var
  binstr,
  cmdstr,
  mapstr: TCmdStr;
  success : boolean;
  StaticStr,
  GCSectionsStr,
  DynLinkStr,
  StripStr,
  FixedExeFileName: string;
begin
  { for future use }
  StaticStr:='';
  StripStr:='';
  mapstr:='';
  DynLinkStr:='';
  FixedExeFileName:=maybequoted(ScriptFixFileName(ChangeFileExt(current_module.exefilename,'.elf')));

  GCSectionsStr:='--gc-sections';
  //if not(cs_link_extern in current_settings.globalswitches) then
  if not(cs_link_nolink in current_settings.globalswitches) then
   Message1(exec_i_linking,current_module.exefilename);

  if (cs_link_map in current_settings.globalswitches) then
   mapstr:='-Map '+maybequoted(ChangeFileExt(current_module.exefilename,'.map'));

{ Write used files and libraries }
  WriteResponseFile();

{ Call linker }
  SplitBinCmd(Info.ExeCmd[1],binstr,cmdstr);
  Replace(cmdstr,'$OPT',Info.ExtraOptions);
  if not(cs_link_on_target in current_settings.globalswitches) then
   begin
    Replace(cmdstr,'$EXE',FixedExeFileName);
    Replace(cmdstr,'$RES',(maybequoted(ScriptFixFileName(outputexedir+Info.ResName))));
    Replace(cmdstr,'$STATIC',StaticStr);
    Replace(cmdstr,'$STRIP',StripStr);
    Replace(cmdstr,'$MAP',mapstr);
    Replace(cmdstr,'$GCSECTIONS',GCSectionsStr);
    Replace(cmdstr,'$DYNLINK',DynLinkStr);
   end
  else
   begin
    Replace(cmdstr,'$EXE',FixedExeFileName);
    Replace(cmdstr,'$RES',maybequoted(ScriptFixFileName(outputexedir+Info.ResName)));
    Replace(cmdstr,'$STATIC',StaticStr);
    Replace(cmdstr,'$STRIP',StripStr);
    Replace(cmdstr,'$MAP',mapstr);
    Replace(cmdstr,'$GCSECTIONS',GCSectionsStr);
    Replace(cmdstr,'$DYNLINK',DynLinkStr);
   end;
  success:=DoExec(FindUtil(utilsprefix+BinStr),cmdstr,true,false);

{ Remove ReponseFile }
  if success and not(cs_link_nolink in current_settings.globalswitches) then
   DeleteFile(outputexedir+Info.ResName);

{ Post process }
  if success and not(cs_link_nolink in current_settings.globalswitches) then
    success:=PostProcessExecutable(FixedExeFileName,false);

  if success and (target_info.system in [system_arm_embedded,system_avr_embedded,system_mipsel_embedded,system_xtensa_embedded]) then
    begin
      success:=DoExec(FindUtil(utilsprefix+'objcopy'),'-O ihex '+
        FixedExeFileName+' '+
        maybequoted(ScriptFixFileName(ChangeFileExt(current_module.exefilename,'.hex'))),true,false);
      if success then
        success:=DoExec(FindUtil(utilsprefix+'objcopy'),'-O binary '+
          FixedExeFileName+' '+
          maybequoted(ScriptFixFileName(ChangeFileExt(current_module.exefilename,'.bin'))),true,false);
        if success and (target_info.system in systems_support_uf2) and (cs_generate_uf2 in current_settings.globalswitches) then
          success := GenerateUF2(maybequoted(ScriptFixFileName(ChangeFileExt(current_module.exefilename,'.bin'))),
                                 maybequoted(ScriptFixFileName(ChangeFileExt(current_module.exefilename,'.uf2'))),
                                 embedded_controllers[current_settings.controllertype].flashbase);
{$ifdef ARM}
      if success and (current_settings.controllertype = ct_raspi2) then
        success:=DoExec(FindUtil(utilsprefix+'objcopy'),'-O binary '+ FixedExeFileName + ' kernel7.img',true,false);
{$endif ARM}
    end;

  MakeExecutable:=success;   { otherwise a recursive call to link method }
end;


function TLinkerEmbedded.postprocessexecutable(const fn : string;isdll:boolean):boolean;
  begin
    Result:=PostProcessELFExecutable(fn,isdll);
  end;

function TlinkerEmbedded.GenerateUF2(binFile,uf2File : string;baseAddress : longWord):boolean;
type 
  TFamilies= record
    k : String;
    v : longWord;
  end;
  tuf2Block = record
    magicStart0,
    magicStart1,
    flags,
    targetAddr,
    payloadSize,
    blockNo,
    numBlocks,
    familyid : longWord;
    data : array[0..255] of byte;
    padding : array[0..511-256-32-4] of byte;
    magicEnd : longWord;
  end;

const
  Families : array of TFamilies = (
    (k:'SAMD21'; v:$68ed2b88),
    (k:'SAML21'; v:$1851780a),
    (k:'SAMD51'; v:$55114460),
    (k:'NRF52';  v:$1b57745f),
    (k:'STM32F0';v:$647824b6),
    (k:'STM32F1';v:$5ee21072),
    (k:'STM32F2';v:$5d1a0a2e),
    (k:'STM32F3';v:$6b846188),
    (k:'STM32F4';v:$57755a57),
    (k:'STM32F7';v:$53b80f00),
    (k:'STM32G0';v:$300f5633),
    (k:'STM32G4';v:$4c71240a),
    (k:'STM32H7';v:$6db66082),
    (k:'STM32L0';v:$202e3a91),
    (k:'STM32L1';v:$1e1f432d),
    (k:'STM32L4';v:$00ff6919),
    (k:'STM32L5';v:$04240bdf),
    (k:'STM32WB';v:$70d16653),
    (k:'STM32WL';v:$21460ff0),
    (k:'RP2040' ;v:$e48bff56)
  );

var
  f,g : file;
  uf2block : Tuf2Block;
  totalRead,numRead : longWord;
  familyId,i : longWord;
  ExtraOptions : String;

begin
  if pos('-Ttext=',Info.ExtraOptions) > 0 then
  begin
    ExtraOptions := copy(Info.ExtraOptions,pos('-Ttext=',Info.ExtraOptions)+7,length(Info.ExtraOptions));
    for i := 1 to length(ExtraOptions) do
      if pos(copy(ExtraOptions,i,1),'0123456789abcdefxABCDEFX') = 0 then
        ExtraOptions := copy(ExtraOptions,1,i);
    baseAddress := StrToIntDef(ExtraOptions,0);
  end;

  familyId := 0;
  for i := 0 to length(Families)-1 do
  begin
    if pos(Families[i].k,embedded_controllers[current_settings.controllertype].controllerunitstr) = 1 then
      familyId := Families[i].v;
  end;

  totalRead := 0;
  numRead := 0;
  assign(f,binfile);
  reset(f,1);
  assign(g,uf2file);
  rewrite(g,1);

  repeat
    fillchar(uf2block,sizeof(uf2block),0);
    uf2block.magicStart0 := $0A324655; // "UF2\n"
    uf2block.magicStart1 := $9E5D5157; // Randomly selected
    if familyId = 0 then
      uf2block.flags := 0
    else
      uf2block.flags := $2000;
    uf2block.targetAddr := baseAddress + totalread;
    uf2block.payloadSize := 256;
    uf2block.blockNo := (totalRead div sizeOf(uf2block.data));
    uf2block.numBlocks := (filesize(f) + 255) div 256;
    uf2block.familyId := familyId;
    uf2block.magicEnd := $0AB16F30; // Randomly selected
    blockRead(f,uf2block.data,sizeof(uf2block.data),numRead);
    blockwrite(g,uf2block,sizeof(uf2block));
    inc(totalRead,numRead);
  until (numRead=0) or (NumRead<>sizeOf(uf2block.data));
  close(f);
  close(g);
  Result := true;
end;

{*****************************************************************************
                              TlinkerEmbedded_SdccSdld
*****************************************************************************}

function TlinkerEmbedded_SdccSdld.WriteResponseFile: Boolean;
  Var
    linkres  : TLinkRes;
    //i        : longint;
    //HPath    : TCmdStrListItem;
    s{,s1,s2}  : TCmdStr;
    prtobj,
    cprtobj  : string[80];
    linklibc : boolean;
    //found1,
    //found2   : boolean;
  begin
    WriteResponseFile:=False;
    linklibc:=(SharedLibFiles.Find('c')<>nil);
    prtobj:='prt0';
    cprtobj:='cprt0';
    if linklibc then
      prtobj:=cprtobj;

    { Open link.res file }
    LinkRes:=TLinkRes.Create(outputexedir+Info.ResName,true);

    { Write path to search libraries }
(*    HPath:=TCmdStrListItem(current_module.locallibrarysearchpath.First);
    while assigned(HPath) do
     begin
      s:=HPath.Str;
      if (cs_link_on_target in current_settings.globalswitches) then
       s:=ScriptFixFileName(s);
      LinkRes.Add('-L'+s);
      HPath:=TCmdStrListItem(HPath.Next);
     end;
    HPath:=TCmdStrListItem(LibrarySearchPath.First);
    while assigned(HPath) do
     begin
      s:=HPath.Str;
      if s<>'' then
       LinkRes.Add('SEARCH_DIR("'+s+'")');
      HPath:=TCmdStrListItem(HPath.Next);
     end;

    LinkRes.Add('INPUT (');
    { add objectfiles, start with prt0 always }*)
    //s:=FindObjectFile('prt0','',false);
    if prtobj<>'' then
      begin
        s:=FindObjectFile(prtobj,'',false);
        LinkRes.AddFileName(s);
      end;

    { try to add crti and crtbegin if linking to C }
    if linklibc then
     begin
       if librarysearchpath.FindFile('crtbegin.o',false,s) then
        LinkRes.AddFileName(s);
       if librarysearchpath.FindFile('crti.o',false,s) then
        LinkRes.AddFileName(s);
     end;

    while not ObjectFiles.Empty do
     begin
      s:=ObjectFiles.GetFirst;
      if s<>'' then
       begin
        { vlink doesn't use SEARCH_DIR for object files }
        if not(cs_link_on_target in current_settings.globalswitches) then
         s:=FindObjectFile(s,'',false);
        LinkRes.AddFileName((maybequoted(s)));
       end;
     end;

    { Write staticlibraries }
    if not StaticLibFiles.Empty then
     begin
      { vlink doesn't need, and doesn't support GROUP }
{      if (cs_link_on_target in current_settings.globalswitches) then
       begin
        LinkRes.Add(')');
        LinkRes.Add('GROUP(');
       end;}
      while not StaticLibFiles.Empty do
       begin
        S:=StaticLibFiles.GetFirst;
        LinkRes.Add('-l'+maybequoted(s));
       end;
     end;

(*    if (cs_link_on_target in current_settings.globalswitches) then
     begin
      LinkRes.Add(')');

      { Write sharedlibraries like -l<lib>, also add the needed dynamic linker
        here to be sure that it gets linked this is needed for glibc2 systems (PFV) }
      linklibc:=false;
      while not SharedLibFiles.Empty do
       begin
        S:=SharedLibFiles.GetFirst;
        if s<>'c' then
         begin
          i:=Pos(target_info.sharedlibext,S);
          if i>0 then
           Delete(S,i,255);
          LinkRes.Add('-l'+s);
         end
        else
         begin
          LinkRes.Add('-l'+s);
          linklibc:=true;
         end;
       end;
      { be sure that libc&libgcc is the last lib }
      if linklibc then
       begin
        LinkRes.Add('-lc');
        LinkRes.Add('-lgcc');
       end;
     end
    else
     begin
      while not SharedLibFiles.Empty do
       begin
        S:=SharedLibFiles.GetFirst;
        LinkRes.Add('lib'+s+target_info.staticlibext);
       end;
      LinkRes.Add(')');
     end;*)

    { objects which must be at the end }
    (*if linklibc then
     begin
       found1:=librarysearchpath.FindFile('crtend.o',false,s1);
       found2:=librarysearchpath.FindFile('crtn.o',false,s2);
       if found1 or found2 then
        begin
          LinkRes.Add('INPUT(');
          if found1 then
           LinkRes.AddFileName(s1);
          if found2 then
           LinkRes.AddFileName(s2);
          LinkRes.Add(')');
        end;
     end;*)

    { Write and Close response }
    linkres.writetodisk;
    linkres.free;

    WriteResponseFile:=True;
  end;

procedure TlinkerEmbedded_SdccSdld.SetDefaultInfo;
  const
{$if defined(Z80)}
    ExeName='sdldz80';
{$else}
    ExeName='sdld';
{$endif}
  begin
    with Info do
     begin
       ExeCmd[1]:=ExeName+' -n $OPT -i $MAP $EXE -f $RES'
       //-g '+platform_select+' $OPT $DYNLINK $STATIC $GCSECTIONS $STRIP $MAP -L. -o $EXE -T $RES';
     end;
  end;

function TlinkerEmbedded_SdccSdld.MakeExecutable: boolean;
  var
    binstr,
    cmdstr,
    mapstr: TCmdStr;
    success : boolean;
    StaticStr,
//    GCSectionsStr,
    DynLinkStr,
    StripStr,
    FixedExeFileName: string;
  begin
    { for future use }
    StaticStr:='';
    StripStr:='';
    mapstr:='';
    DynLinkStr:='';
    FixedExeFileName:=maybequoted(ScriptFixFileName(ChangeFileExt(current_module.exefilename,'.ihx')));

(*    GCSectionsStr:='--gc-sections';
    //if not(cs_link_extern in current_settings.globalswitches) then
    if not(cs_link_nolink in current_settings.globalswitches) then
     Message1(exec_i_linking,current_module.exefilename);*)

    if (cs_link_map in current_settings.globalswitches) then
     mapstr:='-mw';

  { Write used files and libraries }
    WriteResponseFile();

  { Call linker }
    SplitBinCmd(Info.ExeCmd[1],binstr,cmdstr);
    Replace(cmdstr,'$OPT',Info.ExtraOptions);
    if not(cs_link_on_target in current_settings.globalswitches) then
     begin
      Replace(cmdstr,'$EXE',FixedExeFileName);
      Replace(cmdstr,'$RES',(maybequoted(ScriptFixFileName(outputexedir+Info.ResName))));
      Replace(cmdstr,'$STATIC',StaticStr);
      Replace(cmdstr,'$STRIP',StripStr);
      Replace(cmdstr,'$MAP',mapstr);
//      Replace(cmdstr,'$GCSECTIONS',GCSectionsStr);
      Replace(cmdstr,'$DYNLINK',DynLinkStr);
     end
    else
     begin
      Replace(cmdstr,'$EXE',FixedExeFileName);
      Replace(cmdstr,'$RES',maybequoted(ScriptFixFileName(outputexedir+Info.ResName)));
      Replace(cmdstr,'$STATIC',StaticStr);
      Replace(cmdstr,'$STRIP',StripStr);
      Replace(cmdstr,'$MAP',mapstr);
//      Replace(cmdstr,'$GCSECTIONS',GCSectionsStr);
      Replace(cmdstr,'$DYNLINK',DynLinkStr);
     end;
    success:=DoExec(FindUtil(utilsprefix+BinStr),cmdstr,true,false);

  { Remove ReponseFile }
    if success and not(cs_link_nolink in current_settings.globalswitches) then
     DeleteFile(outputexedir+Info.ResName);

(*  { Post process }
    if success and not(cs_link_nolink in current_settings.globalswitches) then
      success:=PostProcessExecutable(FixedExeFileName,false);

    if success and (target_info.system in [system_arm_embedded,system_avr_embedded,system_mipsel_embedded,system_xtensa_embedded]) then
      begin
        success:=DoExec(FindUtil(utilsprefix+'objcopy'),'-O ihex '+
          FixedExeFileName+' '+
          maybequoted(ScriptFixFileName(ChangeFileExt(current_module.exefilename,'.hex'))),true,false);
        if success then
          success:=DoExec(FindUtil(utilsprefix+'objcopy'),'-O binary '+
            FixedExeFileName+' '+
            maybequoted(ScriptFixFileName(ChangeFileExt(current_module.exefilename,'.bin'))),true,false);
      end;*)

    MakeExecutable:=success;   { otherwise a recursive call to link method }
  end;


{*****************************************************************************
                                     Initialize
*****************************************************************************}

initialization
{$ifdef arm}
  RegisterLinker(ld_embedded,TLinkerEmbedded);
  RegisterTarget(system_arm_embedded_info);
{$endif arm}

{$ifdef avr}
  RegisterLinker(ld_embedded,TLinkerEmbedded);
  RegisterTarget(system_avr_embedded_info);
{$endif avr}

{$ifdef i386}
  RegisterLinker(ld_embedded,TLinkerEmbedded);
  RegisterTarget(system_i386_embedded_info);
{$endif i386}

{$ifdef x86_64}
  RegisterLinker(ld_embedded,TLinkerEmbedded);
  RegisterTarget(system_x86_64_embedded_info);
{$endif x86_64}

{$ifdef i8086}
  { no need to register linker ld_embedded, because i8086_embedded uses the
    regular msdos linker. In case a flat binary, relocated for a specific
    segment address is needed (e.g. for a BIOS or a real mode bootloader), it
    can be produced post-compilation with exe2bin or a similar tool. }
  RegisterTarget(system_i8086_embedded_info);
{$endif i8086}

{$ifdef mipsel}
  RegisterLinker(ld_embedded,TLinkerEmbedded);
  RegisterTarget(system_mipsel_embedded_info);
{$endif mipsel}

{$ifdef m68k}
  RegisterLinker(ld_embedded,TLinkerEmbedded);
  RegisterTarget(system_m68k_embedded_info);
{$endif m68k}

{$ifdef riscv32}
  RegisterLinker(ld_embedded,TLinkerEmbedded);
  RegisterTarget(system_riscv32_embedded_info);
{$endif riscv32}

{$ifdef riscv64}
  RegisterLinker(ld_embedded,TLinkerEmbedded);
  RegisterTarget(system_riscv64_embedded_info);
{$endif riscv64}

{$ifdef xtensa}
  RegisterLinker(ld_embedded,TLinkerEmbedded);
  RegisterTarget(system_xtensa_embedded_info);
{$endif xtensa}

{$ifdef z80}
  RegisterLinker(ld_embedded,TlinkerEmbedded_SdccSdld);
  RegisterTarget(system_z80_embedded_info);
{$endif z80}
end.

