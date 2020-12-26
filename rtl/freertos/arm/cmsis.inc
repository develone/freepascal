{$IF NOT DEFINED(INTERFACE) AND NOT DEFINED(IMPLEMENTATION)}
unit cmsis;

interface

{$ENDIF}
{$if defined(INTERFACE)}
  {$if defined(CPUARMV6M)}
    type
      TNVIC_Registers = record
        ISER : array[0..0] of longWord;
        RESERVED0 : array[0..30] of longWord;
        ICER : array[0..0] of longWord;
        RSERVED1 : array[0..30] of longWord;
        ISPR : array[0..0] of longWord;
        RESERVED2 : array[0..30] of longWord;
        ICPR : array[0..0] of longWord;
        RESERVED3 : array[0..30] of longWord;
        RESERVED4 : array[0..63] of longWord;
        IP : array[0..7] of longWord;
      end;

      TSCB_Registers = record
        CPUID : longWord;
        ICSR : longWord;
        RESERVED0 : longWord;
        AIRCR : longWord;
        SCR : longWord;
        CCR : longWord;
        RESERVED1 : longWord;
        SHP : array[0..1] of longWord;
        SHCSR : longWord;
      end;

      TSysTick_Registers = record
        CTRL : longWord;
        LOAD : longWord;
        VAL : longWord;
        CALIB : longWord;
      end;

      TCoreDebug_Registers = record
        DHCSR : longWord;
        DCRSR : longWord;
        DCRDR : longWord;
        DEMCR : longWord;
      end;

    const
      SCS_BASE       = $E000E000;
      SysTick_BASE   = SCS_BASE + $0010;
      NVIC_BASE      = SCS_BASE + $0100;
      SCB_BASE       = SCS_BASE + $0D00;
      CoreDebug_BASE = SCS_BASE+$0DF0;

    var
      NVIC : TNVIC_Registers absolute NVIC_BASE;
      SCB : TSCB_Registers absolute SCB_BASE;
      SysTick : TSysTick_Registers absolute SysTick_BASE;
      CoreDebug : TCoreDebug_Registers absolute CoreDebug_BASE;
  {$else}
    type
      TNVIC_Registers = record
        ISER : array[0..7] of longWord;
        RESERVED0 : array[0..23] of longWord;
        ICER : array[0..7] of longWord;
        RESERVED1 : array[0..23] of longWord;
        ISPR : array[0..7] of longWord;
        RESERVED2 : array[0..23] of longWord;
        ICPR : array[0..7] of longWord;
        RESERVED3 : array[0..23] of longWord;
        IABR : array[0..7] of longWord;
        RESERVED4 : array[0..55] of longWord;
        IP : array[0..239] of byte;
        RESERVED5 : array[0..643] of longWord;
        STIR : longWord;
      end;

      TSCB_Registers = record
        CPUID : longWord;
        ICSR : longWord;
        VTOR : longWord;
        AIRCR : longWord;
        SCR : longWord;
        CCR : longWord;
        SHP : array[0..11] of byte;
        SHCSR : longWord;
        CFSR : longWord;
        HFSR : longWord;
        DFSR : longWord;
        MMFAR : longWord;
        BFAR : longWord;
        AFSR : longWord;
        {$if defined(__CORTEXM3) or defined(__CORTEXM4)}
          PFR : array[0..1] of longWord;
          DFR : longWord;
          ADR : longWord;
          MMFR : array[0..3] of longWord;
          ISAR : array[0..4] of longWord;
          RESERVED0 : array[0..4] of longWord;
          CPACR : longWord;
        {$endif}
        {$if defined(__CORTEXM7)}
          ID_PFR : array[0..1] of longWord;
          ID_DFR : longWord;
          ID_AFR : longWord;
          ID_MFR : array[0..3] of longWord;
          ID_ISAR : array[0..4] of longWord;
          RESERVED0 : array[0..0] of longWord;
          CLIDR : longWord;
          CTR : longWord;
          CCSIDR : longWord;
          CSSELR : longWord;
          CPACR : longWord;
          RESERVED3 : array[0..92] of longWord;
          STIR : longWord;
          RESERVED4 : array[0..14] of longWord;
          MVFR0 : longWord;
          MVFR1 : longWord;
          MVFR2 : longWord;
          RESERVED5 : array[0..0] of longWord;
          ICIALLU : longWord;
          RESERVED6 : array[0..0] of longWord;
          ICIMVAU : longWord;
          DCIMVAC : longWord;
          DCISW : longWord;
          DCCMVAU : longWord;
          DCCMVAC : longWord;
          DCCSW : longWord;
          DCCIMVAC : longWord;
          DCCISW : longWord;
          RESERVED7 : array[0..5] of longWord;
          ITCMCR : longWord;
          DTCMCR : longWord;
          AHBPCR : longWord;
          CACR : longWord;
          AHBSCR : longWord;
          RESERVED8 : array[0..0] of longWord;
          ABFSR : longWord;
        {$endif}
      end;

      TSysTick_Registers = record
        CTRL : longWord;
        LOAD : longWord;
        VAL : longWord;
        CALIB : longWord;
      end;
//  TSCnSCB_Registers = record
//    RESERVED0 : array[0..0] of longWord;
//    ACTLR : longWord;
//    ICTR : longWord;
//  end;
//{if definex m7}
//      SCnSCB_Type = record
//        RESERVED0 : array[0..0] of longWord;
//        ICTR : longWord;
//        ACTLR : longWord;
//      end;
//{endif}

      TITM_Registers = record
        PORT : array[0..31] of record
                  case longint of
                    0 : ( u8 : byte );
                    1 : ( u16 : word );
                    2 : ( u32 : longWord );
                  end;
        RESERVED0 : array[0..863] of longWord;
        TER : longWord;
        RESERVED1 : array[0..14] of longWord;
        TPR : longWord;
        RESERVED2 : array[0..14] of longWord;
        TCR : longWord;
        RESERVED3 : array[0..28] of longWord;
        IWR : longWord;
        IRR : longWord;
        IMCR : longWord;
        RESERVED4 : array[0..42] of longWord;
        LAR : longWord;
        LSR : longWord;
        RESERVED5 : array[0..5] of longWord;
        PID4 : longWord;
        PID5 : longWord;
        PID6 : longWord;
        PID7 : longWord;
        PID0 : longWord;
        PID1 : longWord;
        PID2 : longWord;
        PID3 : longWord;
        CID0 : longWord;
        CID1 : longWord;
        CID2 : longWord;
        CID3 : longWord;
      end;

      TDWT_Registers = record
        CTRL : longWord;
        CYCCNT : longWord;
        CPICNT : longWord;
        EXCCNT : longWord;
        SLEEPCNT : longWord;
        LSUCNT : longWord;
        FOLDCNT : longWord;
        PCSR : longWord;
        COMP0 : longWord;
        MASK0 : longWord;
        FUNCTION0 : longWord;
        RESERVED0 : array[0..0] of longWord;
        COMP1 : longWord;
        MASK1 : longWord;
        FUNCTION1 : longWord;
        RESERVED1 : array[0..0] of longWord;
        COMP2 : longWord;
        MASK2 : longWord;
        FUNCTION2 : longWord;
        RESERVED2 : array[0..0] of longWord;
        COMP3 : longWord;
        MASK3 : longWord;
        FUNCTION3 : longWord;
        {$if defined(__CORTEXM7)}
          RESERVED3 : array[0..980] of longWord;
          LAR : longWord;
          LSR : longWord;
        {$endif}
      end;

      TTPI_Registers = record
        SSPSR : longWord;
        CSPSR : longWord;
        RESERVED0 : array[0..1] of longWord;
        ACPR : longWord;
        RESERVED1 : array[0..54] of longWord;
        SPPR : longWord;
        RESERVED2 : array[0..130] of longWord;
        FFSR : longWord;
        FFCR : longWord;
        FSCR : longWord;
        RESERVED3 : array[0..758] of longWord;
        TRIGGER : longWord;
        FIFO0 : longWord;
        ITATBCTR2 : longWord;
        RESERVED4 : array[0..0] of longWord;
        ITATBCTR0 : longWord;
        FIFO1 : longWord;
        ITCTRL : longWord;
        RESERVED5 : array[0..38] of longWord;
        CLAIMSET : longWord;
        CLAIMCLR : longWord;
        RESERVED7 : array[0..7] of longWord;
        DEVID : longWord;
        DEVTYPE : longWord;
      end;

      TFPU_Registers = record
        RESERVED0 : array[0..0] of longWord;
        FPCCR : longWord;
        FPCAR : longWord;
        FPDSCR : longWord;
        MVFR0 : longWord;
        MVFR1 : longWord;
        {$if defined(__CORTEXM7)}
          MVFR2 : longWord;
        {$endif}
      end;

      TCoreDebug_Registers = record
        DHCSR : longWord;
        DCRSR : longWord;
        DCRDR : longWord;
        DEMCR : longWord;
      end;

    const
      ITM_BASE =       $E0000000;
      DWT_BASE =       $E0001000;
      FP_BASE  =       $E0002000;
      SCS_BASE =       $E000E000;
      SysTick_BASE =   SCS_BASE + $0010;
      NVIC_BASE =      SCS_BASE + $0100;
      SCB_BASE =       SCS_BASE + $0D00;
      CoreDebug_BASE = SCS_BASE + $0DF0;
      TPI_BASE =       $E0040000;
    var
      ITM : TITM_Registers absolute ITM_BASE;
      DWT : TDWT_Registers absolute DWT_BASE;
      TPI : TTPI_Registers absolute TPI_BASE;
      CoreDebug : TCoreDebug_Registers absolute CoreDebug_BASE;
      NVIC : TNVIC_Registers absolute NVIC_BASE;
      SCB : TSCB_Registers absolute SCB_BASE;
      SysTick : TSysTick_Registers absolute SysTick_BASE;
  {$endif}

  {$if not defined(__CORTEXM0)}
  type
    TITM_Port = 0..31;
  procedure ITM_SendData(Port: TITM_Port; Data: longword);
  {$endif}
  procedure NVIC_SetPriority(IRQn: TIRQn_Enum; priority: longword);
  function  NVIC_GetPriority(IRQn: TIRQn_Enum): longword;
  procedure NVIC_EnableIRQ(IRQn: TIRQn_Enum);
  procedure NVIC_DisableIRQ(IRQn: TIRQn_Enum);
  function  NVIC_GetPendingIRQ(IRQn: TIRQn_Enum): longword;
  procedure NVIC_SetPendingIRQ(IRQn: TIRQn_Enum);
  procedure NVIC_ClearPendingIRQ(IRQn: TIRQn_Enum);

{$endif}

{$IF NOT DEFINED(INTERFACE) AND NOT DEFINED(IMPLEMENTATION)}
implementation
{$ENDIF}

{$if defined(IMPLEMENTATION)}
  {$if not defined(__CORTEXM0)}
  procedure ITM_SendData(Port: TITM_Port; Data: longword);
  const
    CoreDebug_DEMCR_TRCENA = $01000000;
    ITM_TCR_ITMENA   = $00000001;
  begin
    if ((CoreDebug.DEMCR and CoreDebug_DEMCR_TRCENA) <> 0) and
       ((ITM.TCR and ITM_TCR_ITMENA) <> 0) and
       ((ITM.TER and (1 shl Port)) <> 0) then
    begin
      while ITM.Port[Port].u8 = 0 do;
      ITM.Port[Port].u32 := Data;
    end;
  end;
  {$endif}

  procedure NVIC_SetPriority(IRQn: TIRQn_Enum; priority: longword);
  begin
    if longInt(IRQn) < 0 then
      SCB.SHP[(longInt(IRQn) and $0F) - 4] := (priority shl (8 - __NVIC_PRIO_BITS)) and $FF
    else
      NVIC.IP[longInt(IRQn)] := (priority shl (8 - __NVIC_PRIO_BITS)) and $FF;
  end;

  function NVIC_GetPriority(IRQn: TIRQn_Enum): longword;
  begin
    if (longInt(IRQn) < 0) then
      exit((SCB.SHP[(longInt(IRQn) and $0F) - 4] shl (8 - __NVIC_PRIO_BITS)))
    else
      exit((NVIC.IP[longInt(IRQn)] shl (8 - __NVIC_PRIO_BITS)));
  end;

  procedure NVIC_EnableIRQ(IRQn: TIRQn_Enum);
  begin
    NVIC.ISER[longInt(IRQn) shr 5] := 1 shl (longInt(IRQn) and $1F);
  end;

  procedure NVIC_DisableIRQ(IRQn: TIRQn_Enum);
  begin
    NVIC.ICER[longInt(IRQn) shr 5] := 1 shl (longInt(IRQn) and $1F);
  end;

  function NVIC_GetPendingIRQ(IRQn: TIRQn_Enum): longword;
  begin
    exit(Ord(((NVIC.ISPR[(longInt(IRQn) shr 5)] and (1 shl (longInt(IRQn) and $1F))) <> 0)));
  end;

  procedure NVIC_SetPendingIRQ(IRQn: TIRQn_Enum);
  begin
    NVIC.ISPR[(longInt(IRQn) shr 5)] := 1 shl (longInt(IRQn) and $1F);
  end;

  procedure NVIC_ClearPendingIRQ(IRQn: TIRQn_Enum);
  begin
    NVIC.ICPR[(longInt(IRQn) shr 5)] := 1 shl (longInt(IRQn) and $1F);
  end;
{$endif}

{$IF NOT DEFINED(INTERFACE) AND NOT DEFINED(IMPLEMENTATION)}
end.
{$ENDIF}

