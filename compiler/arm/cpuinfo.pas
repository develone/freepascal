{
    Copyright (c) 1998-2002 by the Free Pascal development team

    Basic Processor information for the ARM

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
   ts80real = type extended;
   ts128real = type extended;
   ts64comp = comp;

   pbestreal=^bestreal;

   { possible supported processors for this target }
   tcputype =
      (cpu_none,
       cpu_armv3,
       cpu_armv4,
       cpu_armv4t,
       cpu_armv5,
       cpu_armv5t,
       cpu_armv5te,
       cpu_armv5tej,
       cpu_armv6,
       cpu_armv6k,
       cpu_armv6t2,
       cpu_armv6z,
       cpu_armv6m,
       cpu_armv7,
       cpu_armv7a,
       cpu_armv7r,
       cpu_armv7m,
       cpu_armv7em
       { when new elements added afterwards,
         update class procedure tarmnodeutils.InsertObjectInfo; in narmutil.pas
       }
      );

   tinstructionset = (is_thumb,is_arm);

Type
   tfputype =
     (fpu_none,
      fpu_soft,
      fpu_libgcc,
      fpu_fpa,
      fpu_fpa10,
      fpu_fpa11,
      fpu_vfpv2,
      fpu_vfpv3,
      fpu_neon_vfpv3,
      fpu_vfpv3_d16,
      fpu_fpv4_s16,
      fpu_vfpv4,
      fpu_neon_vfpv4
      { when new elements added afterwards, update also fpu_vfp_last below and
        update class procedure tarmnodeutils.InsertObjectInfo; in narmutil.pas }
     );

   tcontrollerdatatype = record
     controllertypestr, controllerunitstr: string;
     linkerscript: string;
     linkerdefines: array of tlinkerdefine;
     cputype : tcputype; fputype: tfputype;
     flashbase, flashsize, srambase, sramsize, eeprombase, eepromsize, bootbase, bootsize: dword; 
   end;

Const
   fpu_vfp_first = fpu_vfpv2;
   fpu_vfp_last  = fpu_neon_vfpv4;

  fputypestrllvm : array[tfputype] of string[14] = ('',
    '',
    '',
    '',
    '',
    '',
    'fpu=vfpv2',
    'fpu=vfpv3',
    'fpu=neon-vfpv3',
    'fpu=vfpv3-d16',
    'fpu=vfpv4-s16',
    'fpu=vfpv4',
    'fpu=neon-vfpv4'
  );

Const
   { Is there support for dealing with multiple microcontrollers available }
   { for this platform? }
   ControllerSupport = true;
   {# Size of native extended floating point type }
   extended_size = 12;
   { target cpu string (used by compiler options) }
   target_cpu_string = 'arm';

   { calling conventions supported by the code generator }
   supported_calling_conventions : tproccalloptions = [
     pocall_internproc,
     pocall_safecall,
     pocall_stdcall,
     { same as stdcall only different name mangling }
     pocall_cdecl,
     { same as stdcall only different name mangling }
     pocall_cppdecl,
     { same as stdcall but floating point numbers are handled like equal sized integers }
     pocall_softfloat,
     { same as stdcall (requires that all const records are passed by
       reference, but that's already done for stdcall) }
     pocall_mwpascal,
     { used for interrupt handling }
     pocall_interrupt,
     { needed sometimes on android }
     pocall_hardfloat
   ];

   cputypestr : array[tcputype] of string[8] = ('',
     'ARMV3',
     'ARMV4',
     'ARMV4T',
     'ARMV5',
     'ARMV5T',
     'ARMV5TE',
     'ARMV5TEJ',
     'ARMV6',
     'ARMV6K',
     'ARMV6T2',
     'ARMV6Z',
     'ARMV6M',
     'ARMV7',
     'ARMV7A',
     'ARMV7R',
     'ARMV7M',
     'ARMV7EM'
   );

   fputypestr : array[tfputype] of string[10] = (
     'NONE',
     'SOFT',
     'LIBGCC',
     'FPA',
     'FPA10',
     'FPA11',
     'VFPV2',
     'VFPV3',
     'NEON_VFPV3',
     'VFPV3_D16',
     'FPV4_S16',
     'VFPV4',
     'NEON_VFPV4'
   );

   embedded_controllers : array of tcontrollerdatatype = nil;   

   { Supported optimizations, only used for information }
   supported_optimizerswitches = genericlevel1optimizerswitches+
                                 genericlevel2optimizerswitches+
                                 genericlevel3optimizerswitches-
                                 { no need to write info about those }
                                 [cs_opt_level1,cs_opt_level2,cs_opt_level3]+
                                 [{$ifndef llvm}cs_opt_regvar,{$endif}cs_opt_loopunroll,cs_opt_tailrecursion,
                                  cs_opt_stackframe,cs_opt_nodecse,cs_opt_reorder_fields,cs_opt_fastmath,cs_opt_forcenostackframe];

   level1optimizerswitches = genericlevel1optimizerswitches;
   level2optimizerswitches = genericlevel2optimizerswitches + level1optimizerswitches +
     [{$ifndef llvm}cs_opt_regvar,{$endif}cs_opt_stackframe,cs_opt_tailrecursion,cs_opt_nodecse];
   level3optimizerswitches = genericlevel3optimizerswitches + level2optimizerswitches + [cs_opt_scheduler{,cs_opt_loopunroll}];
   level4optimizerswitches = genericlevel4optimizerswitches + level3optimizerswitches + [];

 type
   tcpuflags =
      (CPUARM_HAS_ALL_MEM,    { CPU supports LDRSB/LDRSH/LDRH/STRH instructions           }
       CPUARM_HAS_BX,         { CPU supports the BX instruction                           }
       CPUARM_HAS_BLX,        { CPU supports the BLX rX instruction                       }
       CPUARM_HAS_BLX_LABEL,  { CPU supports the BLX <label> instruction                  }
       CPUARM_HAS_CLZ,        { CPU supports the CLZ instruction                          }
       CPUARM_HAS_EDSP,       { CPU supports the PLD,STRD,LDRD,MCRR and MRRC instructions }
       CPUARM_HAS_REV,        { CPU supports the REV instruction                          }
       CPUARM_HAS_RBIT,       { CPU supports the RBIT instruction                         }
       CPUARM_HAS_DMB,        { CPU has memory barrier instructions (DMB, DSB, ISB)       }
       CPUARM_HAS_LDREX,
       CPUARM_HAS_IDIV,
       CPUARM_HAS_THUMB_IDIV,
       CPUARM_HAS_THUMB2,
       CPUARM_HAS_UMULL
      );

   tfpuflags =
      (
        FPUARM_HAS_FPA,                { fpu is an fpa based FPU                                                               }
        FPUARM_HAS_VFP_EXTENSION,      { fpu is a vfp extension                                                                }
        FPUARM_HAS_VFP_DOUBLE,         { vfp has double support                                                                }
        FPUARM_HAS_VFP_SINGLE_ONLY,    { vfp has only single support, disjunct to FPUARM_HAS_VFP_DOUBLE, for error checking    }
        FPUARM_HAS_32REGS,             { vfp has 32 regs, without this flag, 16 are assumed                                    }
        FPUARM_HAS_VMOV_CONST,         { vmov supports (some) real constants                                                   }
        FPUARM_HAS_EXCEPTION_TRAPPING, { vfp does exceptions trapping                                                          }
        FPUARM_HAS_NEON,               { fpu has neon extensions                                                               }
        FPUARM_HAS_FMA                 { fpu has fused multiply/add instructions                                               }
      );

 const
   cpu_capabilities : array[tcputype] of set of tcpuflags =
     ( { cpu_none     } [],
       { cpu_armv3    } [],
       { cpu_armv4    } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_UMULL],
       { cpu_armv4t   } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_UMULL],
       { cpu_armv5    } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_CLZ,CPUARM_HAS_UMULL],
       { cpu_armv5t   } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_UMULL],
       { cpu_armv5te  } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_UMULL],
       { cpu_armv5tej } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_UMULL],
       { cpu_armv6    } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_REV,CPUARM_HAS_LDREX,CPUARM_HAS_UMULL],
       { cpu_armv6k   } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_REV,CPUARM_HAS_LDREX,CPUARM_HAS_UMULL],
       { cpu_armv6t2  } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_REV,CPUARM_HAS_RBIT,CPUARM_HAS_LDREX,CPUARM_HAS_THUMB2,CPUARM_HAS_UMULL],
       { cpu_armv6z   } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_REV,CPUARM_HAS_LDREX,CPUARM_HAS_UMULL],
       { cpu_armv6m   } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_REV],
       { the identifier armv7 is should not be used, it is considered being equal to armv7a }
       { cpu_armv7    } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_REV,CPUARM_HAS_RBIT,CPUARM_HAS_LDREX,CPUARM_HAS_DMB,CPUARM_HAS_THUMB2,CPUARM_HAS_UMULL],
       { cpu_armv7a   } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_REV,CPUARM_HAS_RBIT,CPUARM_HAS_LDREX,CPUARM_HAS_DMB,CPUARM_HAS_THUMB2,CPUARM_HAS_UMULL],
       { cpu_armv7r   } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_BLX_LABEL,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_REV,CPUARM_HAS_RBIT,CPUARM_HAS_LDREX,CPUARM_HAS_THUMB_IDIV,CPUARM_HAS_DMB,CPUARM_HAS_THUMB2,CPUARM_HAS_UMULL],
       { cpu_armv7m   } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_REV,CPUARM_HAS_RBIT,CPUARM_HAS_LDREX,CPUARM_HAS_THUMB_IDIV,CPUARM_HAS_DMB,CPUARM_HAS_THUMB2,CPUARM_HAS_UMULL],
       { cpu_armv7em  } [CPUARM_HAS_ALL_MEM,CPUARM_HAS_BX,CPUARM_HAS_BLX,CPUARM_HAS_CLZ,CPUARM_HAS_EDSP,CPUARM_HAS_REV,CPUARM_HAS_RBIT,CPUARM_HAS_LDREX,CPUARM_HAS_THUMB_IDIV,CPUARM_HAS_DMB,CPUARM_HAS_THUMB2,CPUARM_HAS_UMULL]
     );

     fpu_capabilities : array[tfputype] of set of tfpuflags =
       ( { fpu_none       } [],
         { fpu_soft       } [],
         { fpu_libgcc     } [],
         { fpu_fpa        } [FPUARM_HAS_FPA],
         { fpu_fpa10      } [FPUARM_HAS_FPA],
         { fpu_fpa11      } [FPUARM_HAS_FPA],
         { fpu_vfpv2      } [FPUARM_HAS_VFP_EXTENSION,FPUARM_HAS_VFP_DOUBLE],
         { fpu_vfpv3      } [FPUARM_HAS_VFP_EXTENSION,FPUARM_HAS_VFP_DOUBLE,FPUARM_HAS_32REGS,FPUARM_HAS_VMOV_CONST],
         { fpu_neon_vfpv3 } [FPUARM_HAS_VFP_EXTENSION,FPUARM_HAS_VFP_DOUBLE,FPUARM_HAS_32REGS,FPUARM_HAS_VMOV_CONST,FPUARM_HAS_NEON],
         { fpu_vfpv3_d16  } [FPUARM_HAS_VFP_EXTENSION,FPUARM_HAS_VFP_DOUBLE,FPUARM_HAS_VMOV_CONST],
         { fpu_fpv4_s16   } [FPUARM_HAS_VFP_EXTENSION,FPUARM_HAS_VFP_SINGLE_ONLY,FPUARM_HAS_VMOV_CONST],
         { fpu_vfpv4      } [FPUARM_HAS_VFP_EXTENSION,FPUARM_HAS_VFP_DOUBLE,FPUARM_HAS_32REGS,FPUARM_HAS_VMOV_CONST,FPUARM_HAS_FMA],
         { fpu_neon_vfpv4 } [FPUARM_HAS_VFP_EXTENSION,FPUARM_HAS_VFP_DOUBLE,FPUARM_HAS_32REGS,FPUARM_HAS_VMOV_CONST,FPUARM_HAS_NEON,FPUARM_HAS_FMA]
       );

   { contains all CPU supporting any kind of thumb instruction set }
   cpu_has_thumb = [cpu_armv4t,cpu_armv5t,cpu_armv5te,cpu_armv5tej,cpu_armv6t2,cpu_armv6z,cpu_armv6m,cpu_armv7a,cpu_armv7r,cpu_armv7m,cpu_armv7em];

Implementation

end.

