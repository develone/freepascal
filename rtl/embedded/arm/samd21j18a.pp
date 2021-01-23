unit samd21j18a;
(*
  Copyright (c) 2020 Microchip Technology Inc.
                   
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the Licence at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*)

interface
{$PACKRECORDS C}
{$GOTO ON}
{$SCOPEDENUMS ON}
{$DEFINE INTERFACE}
{$UNDEF IMPLEMENTATION}
{$DEFINE __CORTEXM0PLUS}
{$DEFINE __NVIC_PRIO_BITS2 }

const
  __MPU_PRESENT=0;
  __NVIC_PRIO_BITS=2;

type
  TIRQn_Enum = (
    NonMaskableInt_IRQn       = -14,
    HardFault_IRQn            = -13,
    SVC_IRQn                  = -5,
    PendSV_IRQn               = -2,
    SysTick_IRQn              = -1,
    PM_IRQn                   = 0,
    SYSCTRL_IRQn              = 1,
    WDT_IRQn                  = 2,
    RTC_IRQn                  = 3,
    EIC_IRQn                  = 4,
    NVMCTRL_IRQn              = 5,
    DMAC_IRQn                 = 6,
    USB_IRQn                  = 7,
    EVSYS_IRQn                = 8,
    SERCOM0_IRQn              = 9,
    SERCOM1_IRQn              = 10,
    SERCOM2_IRQn              = 11,
    SERCOM3_IRQn              = 12,
    SERCOM4_IRQn              = 13,
    SERCOM5_IRQn              = 14,
    TCC0_IRQn                 = 15,
    TCC1_IRQn                 = 16,
    TCC2_IRQn                 = 17,
    TC3_IRQn                  = 18,
    TC4_IRQn                  = 19,
    TC5_IRQn                  = 20,
    TC6_IRQn                  = 21,
    TC7_IRQn                  = 22,
    ADC_IRQn                  = 23,
    AC_IRQn                   = 24,
    DAC_IRQn                  = 25,
    PTC_IRQn                  = 26,
    I2S_IRQn                  = 27
  );

  TAC_Registers = record
    CTRLA        : byte;                 //0000 Control A
    CTRLB        : byte;                 //0001 Control B
    EVCTRL       : word;                 //0002 Event Control
    INTENCLR     : byte;                 //0004 Interrupt Enable Clear
    INTENSET     : byte;                 //0005 Interrupt Enable Set
    INTFLAG      : byte;                 //0006 Interrupt Flag Status and Clear
    RESERVED0    : byte;
    STATUSA      : byte;                 //0008 Status A
    STATUSB      : byte;                 //0009 Status B
    STATUSC      : byte;                 //000A Status C
    RESERVED1    : byte;
    WINCTRL      : byte;                 //000C Window Control
    RESERVED2    : array[1..3] of byte;
    COMPCTRL     : array[0..1] of longWord; //0010 Comparator Control n
    RESERVED3    : array[1..8] of byte;
    SCALER       : array[0..1] of byte;  //0020 Scaler n
  end;

  TADC_Registers = record
    CTRLA        : byte;                 //0000 Control A
    REFCTRL      : byte;                 //0001 Reference Control
    AVGCTRL      : byte;                 //0002 Average Control
    SAMPCTRL     : byte;                 //0003 Sampling Time Control
    CTRLB        : word;                 //0004 Control B
    RESERVED0    : word;
    WINCTRL      : byte;                 //0008 Window Monitor Control
    RESERVED1    : array[1..3] of byte;
    SWTRIG       : byte;                 //000C Software Trigger
    RESERVED2    : array[1..3] of byte;
    INPUTCTRL    : longWord;             //0010 Input Control
    EVCTRL       : byte;                 //0014 Event Control
    RESERVED3    : byte;
    INTENCLR     : byte;                 //0016 Interrupt Enable Clear
    INTENSET     : byte;                 //0017 Interrupt Enable Set
    INTFLAG      : byte;                 //0018 Interrupt Flag Status and Clear
    STATUS       : byte;                 //0019 Status
    RESULT       : word;                 //001A Result
    WINLT        : word;                 //001C Window Monitor Lower Threshold
    RESERVED4    : word;
    WINUT        : word;                 //0020 Window Monitor Upper Threshold
    RESERVED5    : word;
    GAINCORR     : word;                 //0024 Gain Correction
    OFFSETCORR   : word;                 //0026 Offset Correction
    CALIB        : word;                 //0028 Calibration
    DBGCTRL      : byte;                 //002A Debug Control
  end;

  TDAC_Registers = record
    CTRLA        : byte;                 //0000 Control A
    CTRLB        : byte;                 //0001 Control B
    EVCTRL       : byte;                 //0002 Event Control
    RESERVED0    : byte;
    INTENCLR     : byte;                 //0004 Interrupt Enable Clear
    INTENSET     : byte;                 //0005 Interrupt Enable Set
    INTFLAG      : byte;                 //0006 Interrupt Flag Status and Clear
    STATUS       : byte;                 //0007 Status
    DATA         : word;                 //0008 Data
    RESERVED1    : word;
    DATABUF      : word;                 //000C Data Buffer
  end;

  TDMAC_Registers = record
    CTRL         : word;                 //0000 Control
    CRCCTRL      : word;                 //0002 CRC Control
    CRCDATAIN    : longWord;             //0004 CRC Data Input
    CRCCHKSUM    : longWord;             //0008 CRC Checksum
    CRCSTATUS    : byte;                 //000C CRC Status
    DBGCTRL      : byte;                 //000D Debug Control
    QOSCTRL      : byte;                 //000E QOS Control
    RESERVED0    : byte;
    SWTRIGCTRL   : longWord;             //0010 Software Trigger Control
    PRICTRL0     : longWord;             //0014 Priority Control 0
    RESERVED1    : array[1..8] of byte;
    INTPEND      : word;                 //0020 Interrupt Pending
    RESERVED2    : word;
    INTSTATUS    : longWord;             //0024 Interrupt Status
    BUSYCH       : longWord;             //0028 Busy Channels
    PENDCH       : longWord;             //002C Pending Channels
    ACTIVE       : longWord;             //0030 Active Channel and Levels
    BASEADDR     : longWord;             //0034 Descriptor Memory Section Base Address
    WRBADDR      : longWord;             //0038 Write-Back Memory Section Base Address
    RESERVED3    : array[1..3] of byte;
    CHID         : byte;                 //003F Channel ID
    CHCTRLA      : byte;                 //0040 Channel Control A
    RESERVED4    : array[1..3] of byte;
    CHCTRLB      : longWord;             //0044 Channel Control B
    RESERVED5    : longWord;
    CHINTENCLR   : byte;                 //004C Channel Interrupt Enable Clear
    CHINTENSET   : byte;                 //004D Channel Interrupt Enable Set
    CHINTFLAG    : byte;                 //004E Channel Interrupt Flag Status and Clear
    CHSTATUS     : byte;                 //004F Channel Status
  end;

  TDMAC_DESCRIPTOR_Registers = record
    BTCTRL       : word;                 //0000 Block Transfer Control
    BTCNT        : word;                 //0002 Block Transfer Count
    SRCADDR      : longWord;             //0004 Block Transfer Source Address
    DSTADDR      : longWord;             //0008 Block Transfer Destination Address
    DESCADDR     : longWord;             //000C Next Descriptor Address
  end;

  TDSU_Registers = record
    CTRL         : byte;                 //0000 Control
    STATUSA      : byte;                 //0001 Status A
    STATUSB      : byte;                 //0002 Status B
    RESERVED0    : byte;
    ADDR         : longWord;             //0004 Address
    LENGTH       : longWord;             //0008 Length
    DATA         : longWord;             //000C Data
    DCC          : array[0..1] of longWord; //0010 Debug Communication Channel n
    DID          : longWord;             //0018 Device Identification
    RESERVED1    : array[1..4068] of byte;
    ENTRY0       : longWord;             //1000 CoreSight ROM Table Entry 0
    ENTRY1       : longWord;             //1004 CoreSight ROM Table Entry 1
    &END         : longWord;             //1008 CoreSight ROM Table End
    RESERVED2    : array[1..4032] of byte;
    MEMTYPE      : longWord;             //1FCC CoreSight ROM Table Memory Type
    PID4         : longWord;             //1FD0 Peripheral Identification 4
    RESERVED3    : array[1..12] of byte;
    PID0         : longWord;             //1FE0 Peripheral Identification 0
    PID1         : longWord;             //1FE4 Peripheral Identification 1
    PID2         : longWord;             //1FE8 Peripheral Identification 2
    PID3         : longWord;             //1FEC Peripheral Identification 3
    CID0         : longWord;             //1FF0 Component Identification 0
    CID1         : longWord;             //1FF4 Component Identification 1
    CID2         : longWord;             //1FF8 Component Identification 2
    CID3         : longWord;             //1FFC Component Identification 3
  end;

  TEIC_Registers = record
    CTRL         : byte;                 //0000 Control
    STATUS       : byte;                 //0001 Status
    NMICTRL      : byte;                 //0002 Non-Maskable Interrupt Control
    NMIFLAG      : byte;                 //0003 Non-Maskable Interrupt Flag Status and Clear
    EVCTRL       : longWord;             //0004 Event Control
    INTENCLR     : longWord;             //0008 Interrupt Enable Clear
    INTENSET     : longWord;             //000C Interrupt Enable Set
    INTFLAG      : longWord;             //0010 Interrupt Flag Status and Clear
    WAKEUP       : longWord;             //0014 Wake-Up Enable
    CONFIG       : array[0..1] of longWord; //0018 Configuration n
  end;

  TEVSYS_Registers = record
    CTRL         : byte;                 //0000 Control
    RESERVED0    : array[1..3] of byte;
    CHANNEL      : longWord;             //0004 Channel
    USER         : word;                 //0008 User Multiplexer
    RESERVED1    : word;
    CHSTATUS     : longWord;             //000C Channel Status
    INTENCLR     : longWord;             //0010 Interrupt Enable Clear
    INTENSET     : longWord;             //0014 Interrupt Enable Set
    INTFLAG      : longWord;             //0018 Interrupt Flag Status and Clear
  end;

  TGCLK_Registers = record
    CTRL         : byte;                 //0000 Control
    STATUS       : byte;                 //0001 Status
    CLKCTRL      : word;                 //0002 Generic Clock Control
    GENCTRL      : longWord;             //0004 Generic Clock Generator Control
    GENDIV       : longWord;             //0008 Generic Clock Generator Division
  end;

  THMATRIXB_PRS_Registers = record
    PRAS         : longWord;             //0000 Priority A for Slave
    PRBS         : longWord;             //0004 Priority B for Slave
  end;

  THMATRIXB_Registers = record
    PRS          : array[0..15] of THMATRIXB_PRS_Registers;  //0080 
    RESERVED0    : array[1..16] of byte;
    SFR          : array[0..15] of longWord; //0110 Special Function
  end;

  TI2S_Registers = record
    CTRLA        : byte;                 //0000 Control A
    RESERVED0    : array[1..3] of byte;
    CLKCTRL      : array[0..1] of longWord; //0004 Clock Unit n Control
    INTENCLR     : word;                 //000C Interrupt Enable Clear
    RESERVED1    : word;
    INTENSET     : word;                 //0010 Interrupt Enable Set
    RESERVED2    : word;
    INTFLAG      : word;                 //0014 Interrupt Flag Status and Clear
    RESERVED3    : word;
    SYNCBUSY     : word;                 //0018 Synchronization Status
    RESERVED4    : array[1..6] of byte;
    SERCTRL      : array[0..1] of longWord; //0020 Serializer n Control
    RESERVED5    : array[1..8] of byte;
    DATA         : array[0..1] of longWord; //0030 Data n
  end;

  TMTB_Registers = record
    POSITION     : longWord;             //0000 MTB Position
    MASTER       : longWord;             //0004 MTB Master
    FLOW         : longWord;             //0008 MTB Flow
    BASE         : longWord;             //000C MTB Base
    RESERVED0    : array[1..3824] of byte;
    ITCTRL       : longWord;             //0F00 MTB Integration Mode Control
    RESERVED1    : array[1..156] of byte;
    CLAIMSET     : longWord;             //0FA0 MTB Claim Set
    CLAIMCLR     : longWord;             //0FA4 MTB Claim Clear
    RESERVED2    : array[1..8] of byte;
    LOCKACCESS   : longWord;             //0FB0 MTB Lock Access
    LOCKSTATUS   : longWord;             //0FB4 MTB Lock Status
    AUTHSTATUS   : longWord;             //0FB8 MTB Authentication Status
    DEVARCH      : longWord;             //0FBC MTB Device Architecture
    RESERVED3    : array[1..8] of byte;
    DEVID        : longWord;             //0FC8 MTB Device Configuration
    DEVTYPE      : longWord;             //0FCC MTB Device Type
    PID4         : longWord;             //0FD0 CoreSight
    PID5         : longWord;             //0FD4 CoreSight
    PID6         : longWord;             //0FD8 CoreSight
    PID7         : longWord;             //0FDC CoreSight
    PID0         : longWord;             //0FE0 CoreSight
    PID1         : longWord;             //0FE4 CoreSight
    PID2         : longWord;             //0FE8 CoreSight
    PID3         : longWord;             //0FEC CoreSight
    CID0         : longWord;             //0FF0 CoreSight
    CID1         : longWord;             //0FF4 CoreSight
    CID2         : longWord;             //0FF8 CoreSight
    CID3         : longWord;             //0FFC CoreSight
  end;

  TNVMCTRL_Registers = record
    CTRLA        : word;                 //0000 Control A
    RESERVED0    : word;
    CTRLB        : longWord;             //0004 Control B
    PARAM        : longWord;             //0008 NVM Parameter
    INTENCLR     : byte;                 //000C Interrupt Enable Clear
    RESERVED1    : array[1..3] of byte;
    INTENSET     : byte;                 //0010 Interrupt Enable Set
    RESERVED2    : array[1..3] of byte;
    INTFLAG      : byte;                 //0014 Interrupt Flag Status and Clear
    RESERVED3    : array[1..3] of byte;
    STATUS       : word;                 //0018 Status
    RESERVED4    : word;
    ADDR         : longWord;             //001C Address
    LOCK         : word;                 //0020 Lock Section
  end;

  TOTP4_FUSES_Registers = record
    OTP4_WORD_0  : longWord;             //0000 OTP4 Page Word 0
    OTP4_WORD_1  : longWord;             //0004 OTP4 Page Word 1
    OTP4_WORD_2  : longWord;             //0008 OTP4 Page Word 2
  end;

  TTEMP_LOG_FUSES_Registers = record
    TEMP_LOG_WORD_0 : longWord;             //0000 TEMP_LOG Page Word 0
    TEMP_LOG_WORD_1 : longWord;             //0004 TEMP_LOG Page Word 1
  end;

  TUSER_FUSES_Registers = record
    USER_WORD_0  : longWord;             //0000 USER Page Word 0
    USER_WORD_1  : longWord;             //0004 USER Page Word 1
  end;

  TPAC_Registers = record
    WPCLR        : longWord;             //0000 Write Protection Clear
    WPSET        : longWord;             //0004 Write Protection Set
  end;

  TPM_Registers = record
    CTRL         : byte;                 //0000 Control
    SLEEP        : byte;                 //0001 Sleep Mode
    RESERVED0    : array[1..6] of byte;
    CPUSEL       : byte;                 //0008 CPU Clock Select
    APBASEL      : byte;                 //0009 APBA Clock Select
    APBBSEL      : byte;                 //000A APBB Clock Select
    APBCSEL      : byte;                 //000B APBC Clock Select
    RESERVED1    : array[1..8] of byte;
    AHBMASK      : longWord;             //0014 AHB Mask
    APBAMASK     : longWord;             //0018 APBA Mask
    APBBMASK     : longWord;             //001C APBB Mask
    APBCMASK     : longWord;             //0020 APBC Mask
    RESERVED2    : array[1..16] of byte;
    INTENCLR     : byte;                 //0034 Interrupt Enable Clear
    INTENSET     : byte;                 //0035 Interrupt Enable Set
    INTFLAG      : byte;                 //0036 Interrupt Flag Status and Clear
    RESERVED3    : byte;
    RCAUSE       : byte;                 //0038 Reset Cause
  end;

  TPORT_GROUP_Registers = record
    DIR          : longWord;             //0000 Data Direction
    DIRCLR       : longWord;             //0004 Data Direction Clear
    DIRSET       : longWord;             //0008 Data Direction Set
    DIRTGL       : longWord;             //000C Data Direction Toggle
    &OUT         : longWord;             //0010 Data Output Value
    OUTCLR       : longWord;             //0014 Data Output Value Clear
    OUTSET       : longWord;             //0018 Data Output Value Set
    OUTTGL       : longWord;             //001C Data Output Value Toggle
    &IN          : longWord;             //0020 Data Input Value
    CTRL         : longWord;             //0024 Control
    WRCONFIG     : longWord;             //0028 Write Configuration
    RESERVED0    : longWord;
    PMUX         : array[0..15] of byte;  //0030 Peripheral Multiplexing n
    PINCFG       : array[0..31] of byte;  //0040 Pin Configuration n
  end;

  TPORT_Registers = record
    GROUP        : array[0..1] of TPORT_GROUP_Registers;  //0000 
  end;

  TPTC_Registers = record
  end;

  TRTCMODE0_Registers = record
    CTRL         : word;                 //0000 MODE0 Control
    READREQ      : word;                 //0002 Read Request
    EVCTRL       : word;                 //0004 MODE0 Event Control
    INTENCLR     : byte;                 //0006 MODE0 Interrupt Enable Clear
    INTENSET     : byte;                 //0007 MODE0 Interrupt Enable Set
    INTFLAG      : byte;                 //0008 MODE0 Interrupt Flag Status and Clear
    RESERVED0    : byte;
    STATUS       : byte;                 //000A Status
    DBGCTRL      : byte;                 //000B Debug Control
    FREQCORR     : byte;                 //000C Frequency Correction
    RESERVED1    : array[1..3] of byte;
    COUNT        : longWord;             //0010 MODE0 Counter Value
    RESERVED2    : longWord;
    COMP         : longWord;             //0018 MODE0 Compare n Value
  end;

  TRTCMODE1_Registers = record
    CTRL         : word;                 //0000 MODE1 Control
    READREQ      : word;                 //0002 Read Request
    EVCTRL       : word;                 //0004 MODE1 Event Control
    INTENCLR     : byte;                 //0006 MODE1 Interrupt Enable Clear
    INTENSET     : byte;                 //0007 MODE1 Interrupt Enable Set
    INTFLAG      : byte;                 //0008 MODE1 Interrupt Flag Status and Clear
    RESERVED0    : byte;
    STATUS       : byte;                 //000A Status
    DBGCTRL      : byte;                 //000B Debug Control
    FREQCORR     : byte;                 //000C Frequency Correction
    RESERVED1    : array[1..3] of byte;
    COUNT        : word;                 //0010 MODE1 Counter Value
    RESERVED2    : word;
    PER          : word;                 //0014 MODE1 Counter Period
    RESERVED3    : word;
    COMP         : array[0..1] of word;  //0018 MODE1 Compare n Value
  end;

  TRTCMODE2_Registers = record
    CTRL         : word;                 //0000 MODE2 Control
    READREQ      : word;                 //0002 Read Request
    EVCTRL       : word;                 //0004 MODE2 Event Control
    INTENCLR     : byte;                 //0006 MODE2 Interrupt Enable Clear
    INTENSET     : byte;                 //0007 MODE2 Interrupt Enable Set
    INTFLAG      : byte;                 //0008 MODE2 Interrupt Flag Status and Clear
    RESERVED0    : byte;
    STATUS       : byte;                 //000A Status
    DBGCTRL      : byte;                 //000B Debug Control
    FREQCORR     : byte;                 //000C Frequency Correction
    RESERVED1    : array[1..3] of byte;
    CLOCK        : longWord;             //0010 MODE2 Clock Value
    RESERVED2    : longWord;
    ALARM        : longWord;             //0018 MODE2_ALARM Alarm n Value
    MASK         : byte;                 //001C MODE2_ALARM Alarm n Mask
  end;

  TSERCOMI2CM_Registers = record
    CTRLA        : longWord;             //0000 I2CM Control A
    CTRLB        : longWord;             //0004 I2CM Control B
    RESERVED0    : longWord;
    BAUD         : longWord;             //000C I2CM Baud Rate
    RESERVED1    : longWord;
    INTENCLR     : byte;                 //0014 I2CM Interrupt Enable Clear
    RESERVED2    : byte;
    INTENSET     : byte;                 //0016 I2CM Interrupt Enable Set
    RESERVED3    : byte;
    INTFLAG      : byte;                 //0018 I2CM Interrupt Flag Status and Clear
    RESERVED4    : byte;
    STATUS       : word;                 //001A I2CM Status
    SYNCBUSY     : longWord;             //001C I2CM Synchronization Busy
    RESERVED5    : longWord;
    ADDR         : longWord;             //0024 I2CM Address
    DATA         : byte;                 //0028 I2CM Data
    RESERVED6    : array[1..7] of byte;
    DBGCTRL      : byte;                 //0030 I2CM Debug Control
  end;

  TSERCOMI2CS_Registers = record
    CTRLA        : longWord;             //0000 I2CS Control A
    CTRLB        : longWord;             //0004 I2CS Control B
    RESERVED0    : array[1..12] of byte;
    INTENCLR     : byte;                 //0014 I2CS Interrupt Enable Clear
    RESERVED1    : byte;
    INTENSET     : byte;                 //0016 I2CS Interrupt Enable Set
    RESERVED2    : byte;
    INTFLAG      : byte;                 //0018 I2CS Interrupt Flag Status and Clear
    RESERVED3    : byte;
    STATUS       : word;                 //001A I2CS Status
    SYNCBUSY     : longWord;             //001C I2CS Synchronization Busy
    RESERVED4    : longWord;
    ADDR         : longWord;             //0024 I2CS Address
    DATA         : byte;                 //0028 I2CS Data
  end;

  TSERCOMSPIS_Registers = record
    CTRLA        : longWord;             //0000 SPIS Control A
    CTRLB        : longWord;             //0004 SPIS Control B
    RESERVED0    : longWord;
    BAUD         : byte;                 //000C SPIS Baud Rate
    RESERVED1    : array[1..7] of byte;
    INTENCLR     : byte;                 //0014 SPIS Interrupt Enable Clear
    RESERVED2    : byte;
    INTENSET     : byte;                 //0016 SPIS Interrupt Enable Set
    RESERVED3    : byte;
    INTFLAG      : byte;                 //0018 SPIS Interrupt Flag Status and Clear
    RESERVED4    : byte;
    STATUS       : word;                 //001A SPIS Status
    SYNCBUSY     : longWord;             //001C SPIS Synchronization Busy
    RESERVED5    : longWord;
    ADDR         : longWord;             //0024 SPIS Address
    DATA         : longWord;             //0028 SPIS Data
    RESERVED6    : longWord;
    DBGCTRL      : byte;                 //0030 SPIS Debug Control
  end;

  TSERCOMSPIM_Registers = record
    CTRLA        : longWord;             //0000 SPIM Control A
    CTRLB        : longWord;             //0004 SPIM Control B
    RESERVED0    : longWord;
    BAUD         : byte;                 //000C SPIM Baud Rate
    RESERVED1    : array[1..7] of byte;
    INTENCLR     : byte;                 //0014 SPIM Interrupt Enable Clear
    RESERVED2    : byte;
    INTENSET     : byte;                 //0016 SPIM Interrupt Enable Set
    RESERVED3    : byte;
    INTFLAG      : byte;                 //0018 SPIM Interrupt Flag Status and Clear
    RESERVED4    : byte;
    STATUS       : word;                 //001A SPIM Status
    SYNCBUSY     : longWord;             //001C SPIM Synchronization Busy
    RESERVED5    : longWord;
    ADDR         : longWord;             //0024 SPIM Address
    DATA         : longWord;             //0028 SPIM Data
    RESERVED6    : longWord;
    DBGCTRL      : byte;                 //0030 SPIM Debug Control
  end;

  TSERCOMUSART_EXT_Registers = record
    CTRLA        : longWord;             //0000 USART_EXT Control A
    CTRLB        : longWord;             //0004 USART_EXT Control B
    RESERVED0    : longWord;
    BAUD         : word;                 //000C USART_EXT Baud Rate
    RXPL         : byte;                 //000E USART_EXT Receive Pulse Length
    RESERVED1    : array[1..5] of byte;
    INTENCLR     : byte;                 //0014 USART_EXT Interrupt Enable Clear
    RESERVED2    : byte;
    INTENSET     : byte;                 //0016 USART_EXT Interrupt Enable Set
    RESERVED3    : byte;
    INTFLAG      : byte;                 //0018 USART_EXT Interrupt Flag Status and Clear
    RESERVED4    : byte;
    STATUS       : word;                 //001A USART_EXT Status
    SYNCBUSY     : longWord;             //001C USART_EXT Synchronization Busy
    RESERVED5    : array[1..8] of byte;
    DATA         : word;                 //0028 USART_EXT Data
    RESERVED6    : array[1..6] of byte;
    DBGCTRL      : byte;                 //0030 USART_EXT Debug Control
  end;

  TSERCOMUSART_INT_Registers = record
    CTRLA        : longWord;             //0000 USART_INT Control A
    CTRLB        : longWord;             //0004 USART_INT Control B
    RESERVED0    : longWord;
    BAUD         : word;                 //000C USART_INT Baud Rate
    RXPL         : byte;                 //000E USART_INT Receive Pulse Length
    RESERVED1    : array[1..5] of byte;
    INTENCLR     : byte;                 //0014 USART_INT Interrupt Enable Clear
    RESERVED2    : byte;
    INTENSET     : byte;                 //0016 USART_INT Interrupt Enable Set
    RESERVED3    : byte;
    INTFLAG      : byte;                 //0018 USART_INT Interrupt Flag Status and Clear
    RESERVED4    : byte;
    STATUS       : word;                 //001A USART_INT Status
    SYNCBUSY     : longWord;             //001C USART_INT Synchronization Busy
    RESERVED5    : array[1..8] of byte;
    DATA         : word;                 //0028 USART_INT Data
    RESERVED6    : array[1..6] of byte;
    DBGCTRL      : byte;                 //0030 USART_INT Debug Control
  end;

  TSYSCTRL_Registers = record
    INTENCLR     : longWord;             //0000 Interrupt Enable Clear
    INTENSET     : longWord;             //0004 Interrupt Enable Set
    INTFLAG      : longWord;             //0008 Interrupt Flag Status and Clear
    PCLKSR       : longWord;             //000C Power and Clocks Status
    XOSC         : word;                 //0010 External Multipurpose Crystal Oscillator (XOSC) Control
    RESERVED0    : word;
    XOSC32K      : word;                 //0014 32kHz External Crystal Oscillator (XOSC32K) Control
    RESERVED1    : word;
    OSC32K       : longWord;             //0018 32kHz Internal Oscillator (OSC32K) Control
    OSCULP32K    : byte;                 //001C 32kHz Ultra Low Power Internal Oscillator (OSCULP32K) Control
    RESERVED2    : array[1..3] of byte;
    OSC8M        : longWord;             //0020 8MHz Internal Oscillator (OSC8M) Control
    DFLLCTRL     : word;                 //0024 DFLL48M Control
    RESERVED3    : word;
    DFLLVAL      : longWord;             //0028 DFLL48M Value
    DFLLMUL      : longWord;             //002C DFLL48M Multiplier
    DFLLSYNC     : byte;                 //0030 DFLL48M Synchronization
    RESERVED4    : array[1..3] of byte;
    BOD33        : longWord;             //0034 3.3V Brown-Out Detector (BOD33) Control
    RESERVED5    : longWord;
    VREG         : word;                 //003C Voltage Regulator System (VREG) Control
    RESERVED6    : word;
    VREF         : longWord;             //0040 Voltage References System (VREF) Control
    DPLLCTRLA    : byte;                 //0044 DPLL Control A
    RESERVED7    : array[1..3] of byte;
    DPLLRATIO    : longWord;             //0048 DPLL Ratio Control
    DPLLCTRLB    : longWord;             //004C DPLL Control B
    DPLLSTATUS   : byte;                 //0050 DPLL Status
  end;

  TTCCOUNT8_Registers = record
    CTRLA        : word;                 //0000 Control A
    READREQ      : word;                 //0002 Read Request
    CTRLBCLR     : byte;                 //0004 Control B Clear
    CTRLBSET     : byte;                 //0005 Control B Set
    CTRLC        : byte;                 //0006 Control C
    RESERVED0    : byte;
    DBGCTRL      : byte;                 //0008 Debug Control
    RESERVED1    : byte;
    EVCTRL       : word;                 //000A Event Control
    INTENCLR     : byte;                 //000C Interrupt Enable Clear
    INTENSET     : byte;                 //000D Interrupt Enable Set
    INTFLAG      : byte;                 //000E Interrupt Flag Status and Clear
    STATUS       : byte;                 //000F Status
    COUNT        : byte;                 //0010 COUNT8 Counter Value
    RESERVED2    : array[1..3] of byte;
    PER          : byte;                 //0014 COUNT8 Period Value
    RESERVED3    : array[1..3] of byte;
    CC           : array[0..1] of byte;  //0018 COUNT8 Compare/Capture
  end;

  TTCCOUNT16_Registers = record
    CTRLA        : word;                 //0000 Control A
    READREQ      : word;                 //0002 Read Request
    CTRLBCLR     : byte;                 //0004 Control B Clear
    CTRLBSET     : byte;                 //0005 Control B Set
    CTRLC        : byte;                 //0006 Control C
    RESERVED0    : byte;
    DBGCTRL      : byte;                 //0008 Debug Control
    RESERVED1    : byte;
    EVCTRL       : word;                 //000A Event Control
    INTENCLR     : byte;                 //000C Interrupt Enable Clear
    INTENSET     : byte;                 //000D Interrupt Enable Set
    INTFLAG      : byte;                 //000E Interrupt Flag Status and Clear
    STATUS       : byte;                 //000F Status
    COUNT        : word;                 //0010 COUNT16 Counter Value
    RESERVED2    : array[1..6] of byte;
    CC           : array[0..1] of word;  //0018 COUNT16 Compare/Capture
  end;

  TTCCOUNT32_Registers = record
    CTRLA        : word;                 //0000 Control A
    READREQ      : word;                 //0002 Read Request
    CTRLBCLR     : byte;                 //0004 Control B Clear
    CTRLBSET     : byte;                 //0005 Control B Set
    CTRLC        : byte;                 //0006 Control C
    RESERVED0    : byte;
    DBGCTRL      : byte;                 //0008 Debug Control
    RESERVED1    : byte;
    EVCTRL       : word;                 //000A Event Control
    INTENCLR     : byte;                 //000C Interrupt Enable Clear
    INTENSET     : byte;                 //000D Interrupt Enable Set
    INTFLAG      : byte;                 //000E Interrupt Flag Status and Clear
    STATUS       : byte;                 //000F Status
    COUNT        : longWord;             //0010 COUNT32 Counter Value
    RESERVED2    : longWord;
    CC           : array[0..1] of longWord; //0018 COUNT32 Compare/Capture
  end;

  TTCC_Registers = record
    CTRLA        : longWord;             //0000 Control A
    CTRLBCLR     : byte;                 //0004 Control B Clear
    CTRLBSET     : byte;                 //0005 Control B Set
    RESERVED0    : word;
    SYNCBUSY     : longWord;             //0008 Synchronization Busy
    FCTRLA       : longWord;             //000C Recoverable Fault A Configuration
    FCTRLB       : longWord;             //0010 Recoverable Fault B Configuration
    WEXCTRL      : longWord;             //0014 Waveform Extension Configuration
    DRVCTRL      : longWord;             //0018 Driver Control
    RESERVED1    : word;
    DBGCTRL      : byte;                 //001E Debug Control
    RESERVED2    : byte;
    EVCTRL       : longWord;             //0020 Event Control
    INTENCLR     : longWord;             //0024 Interrupt Enable Clear
    INTENSET     : longWord;             //0028 Interrupt Enable Set
    INTFLAG      : longWord;             //002C Interrupt Flag Status and Clear
    STATUS       : longWord;             //0030 Status
    COUNT        : longWord;             //0034 Count
    PATT         : word;                 //0038 Pattern
    RESERVED3    : word;
    WAVE         : longWord;             //003C Waveform Control
    PER          : longWord;             //0040 Period
    CC           : array[0..3] of longWord; //0044 Compare and Capture
    RESERVED4    : array[1..16] of byte;
    PATTB        : word;                 //0064 Pattern Buffer
    RESERVED5    : word;
    WAVEB        : longWord;             //0068 Waveform Control Buffer
    PERB         : longWord;             //006C Period Buffer
    CCB          : array[0..3] of longWord; //0070 Compare and Capture Buffer
  end;

  TUSB_DEVICE_DESC_BANK_Registers = record
    ADDR         : longWord;             //0000 DEVICE_DESC_BANK Endpoint Bank, Adress of Data Buffer
    PCKSIZE      : longWord;             //0004 DEVICE_DESC_BANK Endpoint Bank, Packet Size
    EXTREG       : word;                 //0008 DEVICE_DESC_BANK Endpoint Bank, Extended
    STATUS_BK    : byte;                 //000A DEVICE_DESC_BANK Enpoint Bank, Status of Bank
  end;

  TUSB_HOST_DESC_BANK_Registers = record
    ADDR         : longWord;             //0000 HOST_DESC_BANK Host Bank, Adress of Data Buffer
    PCKSIZE      : longWord;             //0004 HOST_DESC_BANK Host Bank, Packet Size
    EXTREG       : word;                 //0008 HOST_DESC_BANK Host Bank, Extended
    STATUS_BK    : byte;                 //000A HOST_DESC_BANK Host Bank, Status of Bank
    RESERVED0    : byte;
    CTRL_PIPE    : word;                 //000C HOST_DESC_BANK Host Bank, Host Control Pipe
    STATUS_PIPE  : word;                 //000E HOST_DESC_BANK Host Bank, Host Status Pipe
  end;

  TUSB_DEVICE_ENDPOINT_Registers = record
    EPCFG        : byte;                 //0000 DEVICE_ENDPOINT End Point Configuration
    RESERVED0    : array[1..3] of byte;
    EPSTATUSCLR  : byte;                 //0004 DEVICE_ENDPOINT End Point Pipe Status Clear
    EPSTATUSSET  : byte;                 //0005 DEVICE_ENDPOINT End Point Pipe Status Set
    EPSTATUS     : byte;                 //0006 DEVICE_ENDPOINT End Point Pipe Status
    EPINTFLAG    : byte;                 //0007 DEVICE_ENDPOINT End Point Interrupt Flag
    EPINTENCLR   : byte;                 //0008 DEVICE_ENDPOINT End Point Interrupt Clear Flag
    EPINTENSET   : byte;                 //0009 DEVICE_ENDPOINT End Point Interrupt Set Flag
  end;

  TUSB_HOST_PIPE_Registers = record
    PCFG         : byte;                 //0000 HOST_PIPE End Point Configuration
    RESERVED0    : word;
    BINTERVAL    : byte;                 //0003 HOST_PIPE Bus Access Period of Pipe
    PSTATUSCLR   : byte;                 //0004 HOST_PIPE End Point Pipe Status Clear
    PSTATUSSET   : byte;                 //0005 HOST_PIPE End Point Pipe Status Set
    PSTATUS      : byte;                 //0006 HOST_PIPE End Point Pipe Status
    PINTFLAG     : byte;                 //0007 HOST_PIPE Pipe Interrupt Flag
    PINTENCLR    : byte;                 //0008 HOST_PIPE Pipe Interrupt Flag Clear
    PINTENSET    : byte;                 //0009 HOST_PIPE Pipe Interrupt Flag Set
  end;

  TUSBDEVICE_Registers = record
    CTRLA        : byte;                 //0000 Control A
    RESERVED0    : byte;
    SYNCBUSY     : byte;                 //0002 Synchronization Busy
    QOSCTRL      : byte;                 //0003 USB Quality Of Service
    RESERVED1    : longWord;
    CTRLB        : word;                 //0008 DEVICE Control B
    DADD         : byte;                 //000A DEVICE Device Address
    RESERVED2    : byte;
    STATUS       : byte;                 //000C DEVICE Status
    FSMSTATUS    : byte;                 //000D Finite State Machine Status
    RESERVED3    : word;
    FNUM         : word;                 //0010 DEVICE Device Frame Number
    RESERVED4    : word;
    INTENCLR     : word;                 //0014 DEVICE Device Interrupt Enable Clear
    RESERVED5    : word;
    INTENSET     : word;                 //0018 DEVICE Device Interrupt Enable Set
    RESERVED6    : word;
    INTFLAG      : word;                 //001C DEVICE Device Interrupt Flag
    RESERVED7    : word;
    EPINTSMRY    : word;                 //0020 DEVICE End Point Interrupt Summary
    RESERVED8    : word;
    DESCADD      : longWord;             //0024 Descriptor Address
    PADCAL       : word;                 //0028 USB PAD Calibration
    RESERVED9    : array[1..214] of byte;
    HOST_PIPE    : array[0..7] of TUSB_HOST_PIPE_Registers;  //0100 
  end;

  TUSBHOST_Registers = record
    CTRLA        : byte;                 //0000 Control A
    RESERVED0    : byte;
    SYNCBUSY     : byte;                 //0002 Synchronization Busy
    QOSCTRL      : byte;                 //0003 USB Quality Of Service
    RESERVED1    : longWord;
    CTRLB        : word;                 //0008 HOST Control B
    HSOFC        : byte;                 //000A HOST Host Start Of Frame Control
    RESERVED2    : byte;
    STATUS       : byte;                 //000C HOST Status
    FSMSTATUS    : byte;                 //000D Finite State Machine Status
    RESERVED3    : word;
    FNUM         : word;                 //0010 HOST Host Frame Number
    FLENHIGH     : byte;                 //0012 HOST Host Frame Length
    RESERVED4    : byte;
    INTENCLR     : word;                 //0014 HOST Host Interrupt Enable Clear
    RESERVED5    : word;
    INTENSET     : word;                 //0018 HOST Host Interrupt Enable Set
    RESERVED6    : word;
    INTFLAG      : word;                 //001C HOST Host Interrupt Flag
    RESERVED7    : word;
    PINTSMRY     : word;                 //0020 HOST Pipe Interrupt Summary
    RESERVED8    : word;
    DESCADD      : longWord;             //0024 Descriptor Address
    PADCAL       : word;                 //0028 USB PAD Calibration
    RESERVED9    : array[1..214] of byte;
    HOST_PIPE    : array[0..7] of TUSB_HOST_PIPE_Registers;  //0100 
  end;

  TUSB_DESCRIPTORDEVICE_Registers = record
    HOST_DESC_BANK : array[0..1] of TUSB_HOST_DESC_BANK_Registers;  //0000 
  end;

  TUSB_DESCRIPTORHOST_Registers = record
    HOST_DESC_BANK : array[0..1] of TUSB_HOST_DESC_BANK_Registers;  //0000 
  end;

  TWDT_Registers = record
    CTRL         : byte;                 //0000 Control
    CONFIG       : byte;                 //0001 Configuration
    EWCTRL       : byte;                 //0002 Early Warning Interrupt Control
    RESERVED0    : byte;
    INTENCLR     : byte;                 //0004 Interrupt Enable Clear
    INTENSET     : byte;                 //0005 Interrupt Enable Set
    INTFLAG      : byte;                 //0006 Interrupt Flag Status and Clear
    STATUS       : byte;                 //0007 Status
    CLEAR        : byte;                 //0008 Clear
  end;

  TSystemControl_Registers = record
    CPUID        : longWord;             //0D00 CPUID Base Register
    ICSR         : longWord;             //0D04 Interrupt Control and State Register
    VTOR         : longWord;             //0D08 Vector Table Offset Register
    AIRCR        : longWord;             //0D0C Application Interrupt and Reset Control Register
    SCR          : longWord;             //0D10 System Control Register
    CCR          : longWord;             //0D14 Configuration and Control Register
    RESERVED0    : longWord;
    SHPR2        : longWord;             //0D1C System Handler Priority Register 2
    SHPR3        : longWord;             //0D20 System Handler Priority Register 3
    SHCSR        : longWord;             //0D24 System Handler Control and State Register
    RESERVED1    : array[1..8] of byte;
    DFSR         : longWord;             //0D30 Debug Fault Status Register
  end;

  TRTC_Registers = record
  case byte of
    0: ( MODE0 : TRTCMODE0_Registers );
    1: ( MODE1 : TRTCMODE1_Registers );
    2: ( MODE2 : TRTCMODE2_Registers );
    end;

  TSERCOM_Registers = record
  case byte of
    0: ( I2CM : TSERCOMI2CM_Registers );
    1: ( I2CS : TSERCOMI2CS_Registers );
    2: ( SPIS : TSERCOMSPIS_Registers );
    3: ( SPIM : TSERCOMSPIM_Registers );
    4: ( USART_EXT : TSERCOMUSART_EXT_Registers );
    5: ( USART_INT : TSERCOMUSART_INT_Registers );
    end;

  TTC_Registers = record
  case byte of
    0: ( COUNT8 : TTCCOUNT8_Registers );
    1: ( COUNT16 : TTCCOUNT16_Registers );
    2: ( COUNT32 : TTCCOUNT32_Registers );
    end;

  TUSB_Registers = record
  case byte of
    0: ( DEVICE : TUSBDEVICE_Registers );
    1: ( HOST : TUSBHOST_Registers );
    end;

  TUSB_DESCRIPTOR_Registers = record
  case byte of
    0: ( DEVICE : TUSB_DESCRIPTORDEVICE_Registers );
    1: ( HOST : TUSB_DESCRIPTORHOST_Registers );
    end;

const
  AC_BASE             = $42004400;
  ADC_BASE            = $42004000;
  DAC_BASE            = $42004800;
  DMAC_BASE           = $41004800;
  DSU_BASE            = $41002000;
  EIC_BASE            = $40001800;
  EVSYS_BASE          = $42000400;
  GCLK_BASE           = $40000c00;
  I2S_BASE            = $42005000;
  MTB_BASE            = $41006000;
  NVMCTRL_BASE        = $41004000;
  OTP4_FUSES_BASE     = $00806020;
  PAC0_BASE           = $40000000;
  PAC1_BASE           = $41000000;
  PAC2_BASE           = $42000000;
  PM_BASE             = $40000400;
  PORT_BASE           = $41004400;
  PORT_IOBUS_BASE     = $60000000;
  PTC_BASE            = $42004c00;
  RTC_BASE            = $40001400;
  SBMATRIX_BASE       = $41007000;
  SERCOM0_BASE        = $42000800;
  SERCOM1_BASE        = $42000c00;
  SERCOM2_BASE        = $42001000;
  SERCOM3_BASE        = $42001400;
  SERCOM4_BASE        = $42001800;
  SERCOM5_BASE        = $42001c00;
  SYSCTRL_BASE        = $40000800;
  SystemControl_BASE  = $e000e000;
  TC3_BASE            = $42002c00;
  TC4_BASE            = $42003000;
  TC5_BASE            = $42003400;
  TC6_BASE            = $42003800;
  TC7_BASE            = $42003c00;
  TCC0_BASE           = $42002000;
  TCC1_BASE           = $42002400;
  TCC2_BASE           = $42002800;
  TEMP_LOG_FUSES_BASE = $00806030;
  USB_BASE            = $41005000;
  USER_FUSES_BASE     = $00804000;
  WDT_BASE            = $40001000;

var
  AC                  : TAC_Registers        absolute AC_BASE;
  ADC                 : TADC_Registers       absolute ADC_BASE;
  DAC                 : TDAC_Registers       absolute DAC_BASE;
  DMAC                : TDMAC_Registers      absolute DMAC_BASE;
  DSU                 : TDSU_Registers       absolute DSU_BASE;
  EIC                 : TEIC_Registers       absolute EIC_BASE;
  EVSYS               : TEVSYS_Registers     absolute EVSYS_BASE;
  GCLK                : TGCLK_Registers      absolute GCLK_BASE;
  I2S                 : TI2S_Registers       absolute I2S_BASE;
  MTB                 : TMTB_Registers       absolute MTB_BASE;
  NVMCTRL             : TNVMCTRL_Registers   absolute NVMCTRL_BASE;
  OTP4_FUSES          : TOTP4_FUSES_Registers absolute OTP4_FUSES_BASE;
  PAC0                : TPAC_Registers       absolute PAC0_BASE;
  PAC1                : TPAC_Registers       absolute PAC1_BASE;
  PAC2                : TPAC_Registers       absolute PAC2_BASE;
  PM                  : TPM_Registers        absolute PM_BASE;
  PORT                : TPORT_Registers      absolute PORT_BASE;
  PORT_IOBUS          : TPORT_Registers      absolute PORT_IOBUS_BASE;
  PTC                 : TPTC_Registers       absolute PTC_BASE;
  RTC                 : TRTC_Registers       absolute RTC_BASE;
  SBMATRIX            : THMATRIXB_Registers  absolute SBMATRIX_BASE;
  SERCOM0             : TSERCOM_Registers    absolute SERCOM0_BASE;
  SERCOM1             : TSERCOM_Registers    absolute SERCOM1_BASE;
  SERCOM2             : TSERCOM_Registers    absolute SERCOM2_BASE;
  SERCOM3             : TSERCOM_Registers    absolute SERCOM3_BASE;
  SERCOM4             : TSERCOM_Registers    absolute SERCOM4_BASE;
  SERCOM5             : TSERCOM_Registers    absolute SERCOM5_BASE;
  SYSCTRL             : TSYSCTRL_Registers   absolute SYSCTRL_BASE;
  SystemControl       : TSystemControl_Registers absolute SystemControl_BASE;
  TC3                 : TTC_Registers        absolute TC3_BASE;
  TC4                 : TTC_Registers        absolute TC4_BASE;
  TC5                 : TTC_Registers        absolute TC5_BASE;
  TC6                 : TTC_Registers        absolute TC6_BASE;
  TC7                 : TTC_Registers        absolute TC7_BASE;
  TCC0                : TTCC_Registers       absolute TCC0_BASE;
  TCC1                : TTCC_Registers       absolute TCC1_BASE;
  TCC2                : TTCC_Registers       absolute TCC2_BASE;
  TEMP_LOG_FUSES      : TTEMP_LOG_FUSES_Registers absolute TEMP_LOG_FUSES_BASE;
  USB                 : TUSB_Registers       absolute USB_BASE;
  USER_FUSES          : TUSER_FUSES_Registers absolute USER_FUSES_BASE;
  WDT                 : TWDT_Registers       absolute WDT_BASE;

implementation

{$DEFINE IMPLEMENTATION}
{$UNDEF INTERFACE}

procedure NonMaskableInt_Handler;   external name 'NonMaskableInt_Handler';
procedure HardFault_Handler;        external name 'HardFault_Handler';
procedure SVC_Handler;              external name 'SVC_Handler';
procedure PendSV_Handler;           external name 'PendSV_Handler';
procedure SysTick_Handler;          external name 'SysTick_Handler';
procedure PM_Handler;               external name 'PM_Handler';
procedure SYSCTRL_Handler;          external name 'SYSCTRL_Handler';
procedure WDT_Handler;              external name 'WDT_Handler';
procedure RTC_Handler;              external name 'RTC_Handler';
procedure EIC_Handler;              external name 'EIC_Handler';
procedure NVMCTRL_Handler;          external name 'NVMCTRL_Handler';
procedure DMAC_Handler;             external name 'DMAC_Handler';
procedure USB_Handler;              external name 'USB_Handler';
procedure EVSYS_Handler;            external name 'EVSYS_Handler';
procedure SERCOM0_Handler;          external name 'SERCOM0_Handler';
procedure SERCOM1_Handler;          external name 'SERCOM1_Handler';
procedure SERCOM2_Handler;          external name 'SERCOM2_Handler';
procedure SERCOM3_Handler;          external name 'SERCOM3_Handler';
procedure SERCOM4_Handler;          external name 'SERCOM4_Handler';
procedure SERCOM5_Handler;          external name 'SERCOM5_Handler';
procedure TCC0_Handler;             external name 'TCC0_Handler';
procedure TCC1_Handler;             external name 'TCC1_Handler';
procedure TCC2_Handler;             external name 'TCC2_Handler';
procedure TC3_Handler;              external name 'TC3_Handler';
procedure TC4_Handler;              external name 'TC4_Handler';
procedure TC5_Handler;              external name 'TC5_Handler';
procedure TC6_Handler;              external name 'TC6_Handler';
procedure TC7_Handler;              external name 'TC7_Handler';
procedure ADC_Handler;              external name 'ADC_Handler';
procedure AC_Handler;               external name 'AC_Handler';
procedure DAC_Handler;              external name 'DAC_Handler';
procedure PTC_Handler;              external name 'PTC_Handler';
procedure I2S_Handler;              external name 'I2S_Handler';

{$i    cortexm0p_start.inc}

procedure Vectors; assembler; nostackframe;
label interrupt_vectors;
asm
  .section ".init.interrupt_vectors"
  interrupt_vectors:
  .long _stack_top
  .long Startup
  .long NonMaskableInt_Handler;
  .long HardFault_Handler;
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long SVC_Handler;
  .long 0
  .long 0
  .long PendSV_Handler;
  .long SysTick_Handler;
  .long PM_Handler;
  .long SYSCTRL_Handler;
  .long WDT_Handler;
  .long RTC_Handler;
  .long EIC_Handler;
  .long NVMCTRL_Handler;
  .long DMAC_Handler;
  .long USB_Handler;
  .long EVSYS_Handler;
  .long SERCOM0_Handler;
  .long SERCOM1_Handler;
  .long SERCOM2_Handler;
  .long SERCOM3_Handler;
  .long SERCOM4_Handler;
  .long SERCOM5_Handler;
  .long TCC0_Handler;
  .long TCC1_Handler;
  .long TCC2_Handler;
  .long TC3_Handler;
  .long TC4_Handler;
  .long TC5_Handler;
  .long TC6_Handler;
  .long TC7_Handler;
  .long ADC_Handler;
  .long AC_Handler;
  .long DAC_Handler;
  .long PTC_Handler;
  .long I2S_Handler;

  .weak NonMaskableInt_Handler;
  .weak HardFault_Handler;
  .weak SVC_Handler;
  .weak PendSV_Handler;
  .weak SysTick_Handler;
  .weak PM_Handler;
  .weak SYSCTRL_Handler;
  .weak WDT_Handler;
  .weak RTC_Handler;
  .weak EIC_Handler;
  .weak NVMCTRL_Handler;
  .weak DMAC_Handler;
  .weak USB_Handler;
  .weak EVSYS_Handler;
  .weak SERCOM0_Handler;
  .weak SERCOM1_Handler;
  .weak SERCOM2_Handler;
  .weak SERCOM3_Handler;
  .weak SERCOM4_Handler;
  .weak SERCOM5_Handler;
  .weak TCC0_Handler;
  .weak TCC1_Handler;
  .weak TCC2_Handler;
  .weak TC3_Handler;
  .weak TC4_Handler;
  .weak TC5_Handler;
  .weak TC6_Handler;
  .weak TC7_Handler;
  .weak ADC_Handler;
  .weak AC_Handler;
  .weak DAC_Handler;
  .weak PTC_Handler;
  .weak I2S_Handler;

  .set NonMaskableInt_Handler,  _NonMaskableInt_Handler
  .set HardFault_Handler,       _HardFault_Handler
  .set SVC_Handler,             _SVC_Handler
  .set PendSV_Handler,          _PendSV_Handler
  .set SysTick_Handler,         _SysTick_Handler
  .set PM_Handler,              Haltproc
  .set SYSCTRL_Handler,         Haltproc
  .set WDT_Handler,             Haltproc
  .set RTC_Handler,             Haltproc
  .set EIC_Handler,             Haltproc
  .set NVMCTRL_Handler,         Haltproc
  .set DMAC_Handler,            Haltproc
  .set USB_Handler,             Haltproc
  .set EVSYS_Handler,           Haltproc
  .set SERCOM0_Handler,         Haltproc
  .set SERCOM1_Handler,         Haltproc
  .set SERCOM2_Handler,         Haltproc
  .set SERCOM3_Handler,         Haltproc
  .set SERCOM4_Handler,         Haltproc
  .set SERCOM5_Handler,         Haltproc
  .set TCC0_Handler,            Haltproc
  .set TCC1_Handler,            Haltproc
  .set TCC2_Handler,            Haltproc
  .set TC3_Handler,             Haltproc
  .set TC4_Handler,             Haltproc
  .set TC5_Handler,             Haltproc
  .set TC6_Handler,             Haltproc
  .set TC7_Handler,             Haltproc
  .set ADC_Handler,             Haltproc
  .set AC_Handler,              Haltproc
  .set DAC_Handler,             Haltproc
  .set PTC_Handler,             Haltproc
  .set I2S_Handler,             Haltproc
  .text
  end;
end.
