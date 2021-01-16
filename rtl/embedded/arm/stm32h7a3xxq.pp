unit stm32h7a3xxq;
interface
{$PACKRECORDS C}
{$GOTO ON}
{$SCOPEDENUMS ON}

type
  TIRQn_Enum = (
    NonMaskableInt_IRQn = -14,        
    HardFault_IRQn = -13,             
    MemoryManagement_IRQn = -12,      
    BusFault_IRQn = -11,              
    UsageFault_IRQn = -10,            
    SVCall_IRQn = -5,                 
    DebugMonitor_IRQn = -4,           
    PendSV_IRQn = -2,                 
    SysTick_IRQn = -1,                
    WWDG_IRQn   = 0,                  
    PVD_PVM_IRQn = 1,                 
    RTC_TAMP_STAMP_CSS_LSE_IRQn = 2,  
    RTC_WKUP_IRQn = 3,                
    FLASH_IRQn  = 4,                  
    RCC_IRQn    = 5,                  
    EXTI0_IRQn  = 6,                  
    EXTI1_IRQn  = 7,                  
    EXTI2_IRQn  = 8,                  
    EXTI3_IRQn  = 9,                  
    EXTI4_IRQn  = 10,                 
    DMA1_Stream0_IRQn = 11,           
    DMA1_Stream1_IRQn = 12,           
    DMA1_Stream2_IRQn = 13,           
    DMA1_Stream3_IRQn = 14,           
    DMA1_Stream4_IRQn = 15,           
    DMA1_Stream5_IRQn = 16,           
    DMA1_Stream6_IRQn = 17,           
    ADC_IRQn    = 18,                 
    FDCAN1_IT0_IRQn = 19,             
    FDCAN2_IT0_IRQn = 20,             
    FDCAN1_IT1_IRQn = 21,             
    FDCAN2_IT1_IRQn = 22,             
    EXTI9_5_IRQn = 23,                
    TIM1_BRK_IRQn = 24,               
    TIM1_UP_IRQn = 25,                
    TIM1_TRG_COM_IRQn = 26,           
    TIM1_CC_IRQn = 27,                
    TIM2_IRQn   = 28,                 
    TIM3_IRQn   = 29,                 
    TIM4_IRQn   = 30,                 
    I2C1_EV_IRQn = 31,                
    I2C1_ER_IRQn = 32,                
    I2C2_EV_IRQn = 33,                
    I2C2_ER_IRQn = 34,                
    SPI1_IRQn   = 35,                 
    SPI2_IRQn   = 36,                 
    USART1_IRQn = 37,                 
    USART2_IRQn = 38,                 
    USART3_IRQn = 39,                 
    EXTI15_10_IRQn = 40,              
    RTC_Alarm_IRQn = 41,              
    DFSDM2_IRQn = 42,                 
    TIM8_BRK_TIM12_IRQn = 43,         
    TIM8_UP_TIM13_IRQn = 44,          
    TIM8_TRG_COM_TIM14_IRQn = 45,     
    TIM8_CC_IRQn = 46,                
    DMA1_Stream7_IRQn = 47,           
    FMC_IRQn    = 48,                 
    SDMMC1_IRQn = 49,                 
    TIM5_IRQn   = 50,                 
    SPI3_IRQn   = 51,                 
    UART4_IRQn  = 52,                 
    UART5_IRQn  = 53,                 
    TIM6_DAC_IRQn = 54,               
    TIM7_IRQn   = 55,                 
    DMA2_Stream0_IRQn = 56,           
    DMA2_Stream1_IRQn = 57,           
    DMA2_Stream2_IRQn = 58,           
    DMA2_Stream3_IRQn = 59,           
    DMA2_Stream4_IRQn = 60,           
    FDCAN_CAL_IRQn = 63,              
    DFSDM1_FLT4_IRQn = 64,            
    DFSDM1_FLT5_IRQn = 65,            
    DFSDM1_FLT6_IRQn = 66,            
    DFSDM1_FLT7_IRQn = 67,            
    DMA2_Stream5_IRQn = 68,           
    DMA2_Stream6_IRQn = 69,           
    DMA2_Stream7_IRQn = 70,           
    USART6_IRQn = 71,                 
    I2C3_EV_IRQn = 72,                
    I2C3_ER_IRQn = 73,                
    OTG_HS_EP1_OUT_IRQn = 74,         
    OTG_HS_EP1_IN_IRQn = 75,          
    OTG_HS_WKUP_IRQn = 76,            
    OTG_HS_IRQn = 77,                 
    DCMI_PSSI_IRQn = 78,              
    RNG_IRQn    = 80,                 
    FPU_IRQn    = 81,                 
    UART7_IRQn  = 82,                 
    UART8_IRQn  = 83,                 
    SPI4_IRQn   = 84,                 
    SPI5_IRQn   = 85,                 
    SPI6_IRQn   = 86,                 
    SAI1_IRQn   = 87,                 
    LTDC_IRQn   = 88,                 
    LTDC_ER_IRQn = 89,                
    DMA2D_IRQn  = 90,                 
    SAI2_IRQn   = 91,                 
    OCTOSPI1_IRQn = 92,               
    LPTIM1_IRQn = 93,                 
    CEC_IRQn    = 94,                 
    I2C4_EV_IRQn = 95,                
    I2C4_ER_IRQn = 96,                
    SPDIF_RX_IRQn = 97,               
    DMAMUX1_OVR_IRQn = 102,           
    DFSDM1_FLT0_IRQn = 110,           
    DFSDM1_FLT1_IRQn = 111,           
    DFSDM1_FLT2_IRQn = 112,           
    DFSDM1_FLT3_IRQn = 113,           
    SWPMI1_IRQn = 115,                
    TIM15_IRQn  = 116,                
    TIM16_IRQn  = 117,                
    TIM17_IRQn  = 118,                
    MDIOS_WKUP_IRQn = 119,            
    MDIOS_IRQn  = 120,                
    JPEG_IRQn   = 121,                
    MDMA_IRQn   = 122,                
    SDMMC2_IRQn = 124,                
    HSEM1_IRQn  = 125,                
    DAC2_IRQn   = 127,                
    DMAMUX2_OVR_IRQn = 128,           
    BDMA2_Channel0_IRQn = 129,        
    BDMA2_Channel1_IRQn = 130,        
    BDMA2_Channel2_IRQn = 131,        
    BDMA2_Channel3_IRQn = 132,        
    BDMA2_Channel4_IRQn = 133,        
    BDMA2_Channel5_IRQn = 134,        
    BDMA2_Channel6_IRQn = 135,        
    BDMA2_Channel7_IRQn = 136,        
    COMP_IRQn   = 137,                
    LPTIM2_IRQn = 138,                
    LPTIM3_IRQn = 139,                
    UART9_IRQn  = 140,                
    USART10_IRQn = 141,               
    LPUART1_IRQn = 142,               
    WWDG_RST_IRQn = 143,              
    CRS_IRQn    = 144,                
    ECC_IRQn    = 145,                
    DTS_IRQn    = 147,                
    WAKEUP_PIN_IRQn = 149,            
    OCTOSPI2_IRQn = 150,              
    GFXMMU_IRQn = 153,                
    BDMA1_IRQn  = 154                 
  );

  TADC_Registers = record
    ISR         : longword;
    IER         : longword;
    CR          : longword;
    CFGR        : longword;
    CFGR2       : longword;
    SMPR1       : longword;
    SMPR2       : longword;
    PCSEL       : longword;
    LTR1        : longword;
    HTR1        : longword;
    RESERVED1   : longword;
    RESERVED2   : longword;
    SQR1        : longword;
    SQR2        : longword;
    SQR3        : longword;
    SQR4        : longword;
    DR          : longword;
    RESERVED3   : longword;
    RESERVED4   : longword;
    JSQR        : longword;
    RESERVED5   : array[0..3] of longword;
    OFR1        : longword;
    OFR2        : longword;
    OFR3        : longword;
    OFR4        : longword;
    RESERVED6   : array[0..3] of longword;
    JDR1        : longword;
    JDR2        : longword;
    JDR3        : longword;
    JDR4        : longword;
    RESERVED7   : array[0..3] of longword;
    AWD2CR      : longword;
    AWD3CR      : longword;
    RESERVED8   : longword;
    RESERVED9   : longword;
    LTR2        : longword;
    HTR2        : longword;
    LTR3        : longword;
    HTR3        : longword;
    DIFSEL      : longword;
    CALFACT     : longword;
    CALFACT2    : longword;
  end;

  TADC_Common_Registers = record
    CSR         : longword;
    RESERVED    : longword;
    CCR         : longword;
    CDR         : longword;
    CDR2        : longword;
  end;

  TVREFBUF_Registers = record
    CSR         : longword;
    CCR         : longword;
  end;

  TFDCAN_Global_Registers = record
    CREL        : longword;
    ENDN        : longword;
    RESERVED1   : longword;
    DBTP        : longword;
    TEST        : longword;
    RWD         : longword;
    CCCR        : longword;
    NBTP        : longword;
    TSCC        : longword;
    TSCV        : longword;
    TOCC        : longword;
    TOCV        : longword;
    RESERVED2   : array[0..3] of longword;
    ECR         : longword;
    PSR         : longword;
    TDCR        : longword;
    RESERVED3   : longword;
    IR          : longword;
    IE          : longword;
    ILS         : longword;
    ILE         : longword;
    RESERVED4   : array[0..7] of longword;
    GFC         : longword;
    SIDFC       : longword;
    XIDFC       : longword;
    RESERVED5   : longword;
    XIDAM       : longword;
    HPMS        : longword;
    NDAT1       : longword;
    NDAT2       : longword;
    RXF0C       : longword;
    RXF0S       : longword;
    RXF0A       : longword;
    RXBC        : longword;
    RXF1C       : longword;
    RXF1S       : longword;
    RXF1A       : longword;
    RXESC       : longword;
    TXBC        : longword;
    TXFQS       : longword;
    TXESC       : longword;
    TXBRP       : longword;
    TXBAR       : longword;
    TXBCR       : longword;
    TXBTO       : longword;
    TXBCF       : longword;
    TXBTIE      : longword;
    TXBCIE      : longword;
    RESERVED6   : array[0..1] of longword;
    TXEFC       : longword;
    TXEFS       : longword;
    TXEFA       : longword;
    RESERVED7   : longword;
  end;

  TTTCAN_Registers = record
    TTTMC       : longword;
    TTRMC       : longword;
    TTOCF       : longword;
    TTMLM       : longword;
    TURCF       : longword;
    TTOCN       : longword;
    TTGTP       : longword;
    TTTMK       : longword;
    TTIR        : longword;
    TTIE        : longword;
    TTILS       : longword;
    TTOST       : longword;
    TURNA       : longword;
    TTLGT       : longword;
    TTCTC       : longword;
    TTCPT       : longword;
    TTCSM       : longword;
    RESERVED1   : array[0..110] of longword;
    TTTS        : longword;
  end;

  TFDCAN_ClockCalibrationUnit_Registers = record
    CREL        : longword;
    CCFG        : longword;
    CSTAT       : longword;
    CWD         : longword;
    IR          : longword;
    IE          : longword;
  end;

  TCEC_Registers = record
    CR          : longword;
    CFGR        : longword;
    TXDR        : longword;
    RXDR        : longword;
    ISR         : longword;
    IER         : longword;
  end;

  TCRC_Registers = record
    DR          : longword;
    IDR         : longword;
    CR          : longword;
    RESERVED2   : longword;
    INIT        : longword;
    POL         : longword;
  end;

  TCRS_Registers = record
    CR          : longword;
    CFGR        : longword;
    ISR         : longword;
    ICR         : longword;
  end;

  TDAC_Registers = record
    CR          : longword;
    SWTRIGR     : longword;
    DHR12R1     : longword;
    DHR12L1     : longword;
    DHR8R1      : longword;
    DHR12R2     : longword;
    DHR12L2     : longword;
    DHR8R2      : longword;
    DHR12RD     : longword;
    DHR12LD     : longword;
    DHR8RD      : longword;
    DOR1        : longword;
    DOR2        : longword;
    SR          : longword;
    CCR         : longword;
    MCR         : longword;
    SHSR1       : longword;
    SHSR2       : longword;
    SHHR        : longword;
    SHRR        : longword;
  end;

  TDFSDM_Filter_Registers = record
    FLTCR1      : longword;
    FLTCR2      : longword;
    FLTISR      : longword;
    FLTICR      : longword;
    FLTJCHGR    : longword;
    FLTFCR      : longword;
    FLTJDATAR   : longword;
    FLTRDATAR   : longword;
    FLTAWHTR    : longword;
    FLTAWLTR    : longword;
    FLTAWSR     : longword;
    FLTAWCFR    : longword;
    FLTEXMAX    : longword;
    FLTEXMIN    : longword;
    FLTCNVTIMR  : longword;
  end;

  TDFSDM_Channel_Registers = record
    CHCFGR1     : longword;
    CHCFGR2     : longword;
    CHAWSCDR    : longword;
    CHWDATAR    : longword;
    CHDATINR    : longword;
    CHDLYR      : longword;
  end;

  TDBGMCU_Registers = record
    IDCODE      : longword;
    CR          : longword;
    RESERVED4   : array[0..10] of longword;
    APB3FZ1     : longword;
    RESERVED5   : longword;
    APB1LFZ1    : longword;
    RESERVED6   : longword;
    APB1HFZ1    : longword;
    RESERVED7   : longword;
    APB2FZ1     : longword;
    RESERVED8   : longword;
    APB4FZ1     : longword;
  end;

  TDCMI_Registers = record
    CR          : longword;
    SR          : longword;
    RISR        : longword;
    IER         : longword;
    MISR        : longword;
    ICR         : longword;
    ESCR        : longword;
    ESUR        : longword;
    CWSTRTR     : longword;
    CWSIZER     : longword;
    DR          : longword;
  end;

  TPSSI_Registers = record
    CR          : longword;
    SR          : longword;
    RIS         : longword;
    IER         : longword;
    MIS         : longword;
    ICR         : longword;
    RESERVED1   : array[0..3] of longword;
    DR          : longword;
    RESERVED2   : array[0..240] of longword;
    HWCFGR      : longword;
    VERR        : longword;
    IPIDR       : longword;
    SIDR        : longword;
  end;

  TDMA_Stream_Registers = record
    CR          : longword;
    NDTR        : longword;
    PAR         : longword;
    M0AR        : longword;
    M1AR        : longword;
    FCR         : longword;
  end;

  TDMA_Registers = record
    LISR        : longword;
    HISR        : longword;
    LIFCR       : longword;
    HIFCR       : longword;
  end;

  TBDMA_Channel_Registers = record
    CCR         : longword;
    CNDTR       : longword;
    CPAR        : longword;
    CM0AR       : longword;
    CM1AR       : longword;
  end;

  TBDMA_Registers = record
    ISR         : longword;
    IFCR        : longword;
  end;

  TDMAMUX_Channel_Registers = record
    CCR         : longword;
  end;

  TDMAMUX_ChannelStatus_Registers = record
    CSR         : longword;
    CFR         : longword;
  end;

  TDMAMUX_RequestGen_Registers = record
    RGCR        : longword;
  end;

  TDMAMUX_RequestGenStatus_Registers = record
    RGSR        : longword;
    RGCFR       : longword;
  end;

  TMDMA_Registers = record
    GISR0       : longword;
  end;

  TMDMA_Channel_Registers = record
    CISR        : longword;
    CIFCR       : longword;
    CESR        : longword;
    CCR         : longword;
    CTCR        : longword;
    CBNDTR      : longword;
    CSAR        : longword;
    CDAR        : longword;
    CBRUR       : longword;
    CLAR        : longword;
    CTBR        : longword;
    RESERVED0   : longword;
    CMAR        : longword;
    CMDR        : longword;
  end;

  TDMA2D_Registers = record
    CR          : longword;
    ISR         : longword;
    IFCR        : longword;
    FGMAR       : longword;
    FGOR        : longword;
    BGMAR       : longword;
    BGOR        : longword;
    FGPFCCR     : longword;
    FGCOLR      : longword;
    BGPFCCR     : longword;
    BGCOLR      : longword;
    FGCMAR      : longword;
    BGCMAR      : longword;
    OPFCCR      : longword;
    OCOLR       : longword;
    OMAR        : longword;
    OOR         : longword;
    NLR         : longword;
    LWR         : longword;
    AMTCR       : longword;
    RESERVED    : array[0..235] of longword;
    FGCLUT      : array[0..255] of longword;
    BGCLUT      : array[0..255] of longword;
  end;

  TEXTI_Registers = record
    RTSR1       : longword;
    FTSR1       : longword;
    SWIER1      : longword;
    D3PMR1      : longword;
    D3PCR1L     : longword;
    D3PCR1H     : longword;
    RESERVED1   : array[0..1] of longword;
    RTSR2       : longword;
    FTSR2       : longword;
    SWIER2      : longword;
    D3PMR2      : longword;
    D3PCR2L     : longword;
    D3PCR2H     : longword;
    RESERVED2   : array[0..1] of longword;
    RTSR3       : longword;
    FTSR3       : longword;
    SWIER3      : longword;
    D3PMR3      : longword;
    D3PCR3L     : longword;
    D3PCR3H     : longword;
    RESERVED3   : array[0..9] of longword;
    IMR1        : longword;
    EMR1        : longword;
    PR1         : longword;
    RESERVED4   : longword;
    IMR2        : longword;
    EMR2        : longword;
    PR2         : longword;
    RESERVED5   : longword;
    IMR3        : longword;
    EMR3        : longword;
    PR3         : longword;
  end;

  TEXTI_Core_Registers = record
    IMR1        : longword;
    EMR1        : longword;
    PR1         : longword;
    RESERVED1   : longword;
    IMR2        : longword;
    EMR2        : longword;
    PR2         : longword;
    RESERVED2   : longword;
    IMR3        : longword;
    EMR3        : longword;
    PR3         : longword;
  end;

  TFLASH_Registers = record
    ACR         : longword;
    KEYR1       : longword;
    OPTKEYR     : longword;
    CR1         : longword;
    SR1         : longword;
    CCR1        : longword;
    OPTCR       : longword;
    OPTSR_CUR   : longword;
    OPTSR_PRG   : longword;
    OPTCCR      : longword;
    PRAR_CUR1   : longword;
    PRAR_PRG1   : longword;
    SCAR_CUR1   : longword;
    SCAR_PRG1   : longword;
    WPSN_CUR1   : longword;
    WPSN_PRG1   : longword;
    BOOT_CUR    : longword;
    BOOT_PRG    : longword;
    RESERVED0   : array[0..1] of longword;
    CRCCR1      : longword;
    CRCSADD1    : longword;
    CRCEADD1    : longword;
    CRCDATA     : longword;
    ECC_FA1     : longword;
    RESERVED    : longword;
    OTPBL_CUR   : longword;
    OTPBL_PRG   : longword;
    RESERVED1   : array[0..36] of longword;
    KEYR2       : longword;
    RESERVED2   : longword;
    CR2         : longword;
    SR2         : longword;
    CCR2        : longword;
    RESERVED3   : array[0..3] of longword;
    PRAR_CUR2   : longword;
    PRAR_PRG2   : longword;
    SCAR_CUR2   : longword;
    SCAR_PRG2   : longword;
    WPSN_CUR2   : longword;
    WPSN_PRG2   : longword;
    RESERVED4   : array[0..3] of longword;
    CRCCR2      : longword;
    CRCSADD2    : longword;
    CRCEADD2    : longword;
    CRCDATA2    : longword;
    ECC_FA2     : longword;
  end;

  TFMC_Bank1_Registers = record
    BTCR        : array[0..7] of longword;
  end;

  TFMC_Bank1E_Registers = record
    BWTR        : array[0..6] of longword;
  end;

  TFMC_Bank2_Registers = record
    PCR2        : longword;
    SR2         : longword;
    PMEM2       : longword;
    PATT2       : longword;
    RESERVED0   : longword;
    ECCR2       : longword;
  end;

  TFMC_Bank3_Registers = record
    PCR         : longword;
    SR          : longword;
    PMEM        : longword;
    PATT        : longword;
    RESERVED    : longword;
    ECCR        : longword;
  end;

  TFMC_Bank5_6_Registers = record
    SDCR        : array[0..1] of longword;
    SDTR        : array[0..1] of longword;
    SDCMR       : longword;
    SDRTR       : longword;
    SDSR        : longword;
  end;

  TGFXMMU_Registers = record
    CR          : longword;
    SR          : longword;
    FCR         : longword;
    CCR         : longword;
    DVR         : longword;
    RESERVED1   : array[0..2] of longword;
    B0CR        : longword;
    B1CR        : longword;
    B2CR        : longword;
    B3CR        : longword;
    RESERVED2   : array[0..1011] of longword;
    LUT         : array[0..2047] of longword;
  end;

  TGPIO_Registers = record
    MODER       : longword;
    OTYPER      : longword;
    OSPEEDR     : longword;
    PUPDR       : longword;
    IDR         : longword;
    ODR         : longword;
    BSRR        : longword;
    LCKR        : longword;
    AFR         : array[0..1] of longword;
  end;

  TOPAMP_Registers = record
    CSR         : longword;
    OTR         : longword;
    HSOTR       : longword;
  end;

  TSYSCFG_Registers = record
    RESERVED1   : longword;
    PMCR        : longword;
    EXTICR      : array[0..3] of longword;
    CFGR        : longword;
    RESERVED2   : longword;
    CCCSR       : longword;
    CCVR        : longword;
    CCCR        : longword;
  end;

  TI2C_Registers = record
    CR1         : longword;
    CR2         : longword;
    OAR1        : longword;
    OAR2        : longword;
    TIMINGR     : longword;
    TIMEOUTR    : longword;
    ISR         : longword;
    ICR         : longword;
    PECR        : longword;
    RXDR        : longword;
    TXDR        : longword;
  end;

  TIWDG_Registers = record
    KR          : longword;
    PR          : longword;
    RLR         : longword;
    SR          : longword;
    WINR        : longword;
  end;

  TJPEG_Registers = record
    CONFR0      : longword;
    CONFR1      : longword;
    CONFR2      : longword;
    CONFR3      : longword;
    CONFR4      : longword;
    CONFR5      : longword;
    CONFR6      : longword;
    CONFR7      : longword;
    Reserved20  : array[0..3] of longword;
    CR          : longword;
    SR          : longword;
    CFR         : longword;
    Reserved3c  : longword;
    DIR         : longword;
    DOR         : longword;
    Reserved48  : array[0..1] of longword;
    QMEM0       : array[0..15] of longword;
    QMEM1       : array[0..15] of longword;
    QMEM2       : array[0..15] of longword;
    QMEM3       : array[0..15] of longword;
    HUFFMIN     : array[0..15] of longword;
    HUFFBASE    : array[0..31] of longword;
    HUFFSYMB    : array[0..83] of longword;
    DHTMEM      : array[0..102] of longword;
    Reserved4FC : longword;
    HUFFENC_AC0 : array[0..87] of longword;
    HUFFENC_AC1 : array[0..87] of longword;
    HUFFENC_DC0 : array[0..7] of longword;
    HUFFENC_DC1 : array[0..7] of longword;
  end;

  TLTDC_Registers = record
    RESERVED0   : array[0..1] of longword;
    SSCR        : longword;
    BPCR        : longword;
    AWCR        : longword;
    TWCR        : longword;
    GCR         : longword;
    RESERVED1   : array[0..1] of longword;
    SRCR        : longword;
    RESERVED2   : longword;
    BCCR        : longword;
    RESERVED3   : longword;
    IER         : longword;
    ISR         : longword;
    ICR         : longword;
    LIPCR       : longword;
    CPSR        : longword;
    CDSR        : longword;
  end;

  TLTDC_Layer_Registers = record
    CR          : longword;
    WHPCR       : longword;
    WVPCR       : longword;
    CKCR        : longword;
    PFCR        : longword;
    CACR        : longword;
    DCCR        : longword;
    BFCR        : longword;
    RESERVED0   : array[0..1] of longword;
    CFBAR       : longword;
    CFBLR       : longword;
    CFBLNR      : longword;
    RESERVED1   : array[0..2] of longword;
    CLUTWR      : longword;
  end;

  TPWR_Registers = record
    CR1         : longword;
    CSR1        : longword;
    CR2         : longword;
    CR3         : longword;
    CPUCR       : longword;
    RESERVED0   : longword;
    SRDCR       : longword;
    RESERVED1   : longword;
    WKUPCR      : longword;
    WKUPFR      : longword;
    WKUPEPR     : longword;
  end;

  TRCC_Registers = record
    CR          : longword;
    HSICFGR     : longword;
    CRRCR       : longword;
    CSICFGR     : longword;
    CFGR        : longword;
    RESERVED1   : longword;
    CDCFGR1     : longword;
    CDCFGR2     : longword;
    SRDCFGR     : longword;
    RESERVED2   : longword;
    PLLCKSELR   : longword;
    PLLCFGR     : longword;
    PLL1DIVR    : longword;
    PLL1FRACR   : longword;
    PLL2DIVR    : longword;
    PLL2FRACR   : longword;
    PLL3DIVR    : longword;
    PLL3FRACR   : longword;
    RESERVED3   : longword;
    CDCCIPR     : longword;
    CDCCIP1R    : longword;
    CDCCIP2R    : longword;
    SRDCCIPR    : longword;
    RESERVED4   : longword;
    CIER        : longword;
    CIFR        : longword;
    CICR        : longword;
    RESERVED5   : longword;
    BDCR        : longword;
    CSR         : longword;
    RESERVED6   : longword;
    AHB3RSTR    : longword;
    AHB1RSTR    : longword;
    AHB2RSTR    : longword;
    AHB4RSTR    : longword;
    APB3RSTR    : longword;
    APB1LRSTR   : longword;
    APB1HRSTR   : longword;
    APB2RSTR    : longword;
    APB4RSTR    : longword;
    RESERVED7   : longword;
    RESERVED8   : longword;
    SRDAMR      : longword;
    RESERVED9   : longword;
    CKGAENR     : longword;
    RESERVED10  : array[0..30] of longword;
    RSR         : longword;
    AHB3ENR     : longword;
    AHB1ENR     : longword;
    AHB2ENR     : longword;
    AHB4ENR     : longword;
    APB3ENR     : longword;
    APB1LENR    : longword;
    APB1HENR    : longword;
    APB2ENR     : longword;
    APB4ENR     : longword;
    RESERVED12  : longword;
    AHB3LPENR   : longword;
    AHB1LPENR   : longword;
    AHB2LPENR   : longword;
    AHB4LPENR   : longword;
    APB3LPENR   : longword;
    APB1LLPENR  : longword;
    APB1HLPENR  : longword;
    APB2LPENR   : longword;
    APB4LPENR   : longword;
    RESERVED13  : array[0..3] of longword;
  end;

  TRTC_Registers = record
    TR          : longword;
    DR          : longword;
    SSR         : longword;
    ICSR        : longword;
    PRER        : longword;
    WUTR        : longword;
    CR          : longword;
    RESERVED0   : longword;
    RESERVED1   : longword;
    WPR         : longword;
    CALR        : longword;
    SHIFTR      : longword;
    TSTR        : longword;
    TSDR        : longword;
    TSSSR       : longword;
    RESERVED2   : longword;
    ALRMAR      : longword;
    ALRMASSR    : longword;
    ALRMBR      : longword;
    ALRMBSSR    : longword;
    SR          : longword;
    MISR        : longword;
    RESERVED3   : longword;
    SCR         : longword;
    CFGR        : longword;
  end;

  TTAMP_Registers = record
    CR1         : longword;
    CR2         : longword;
    RESERVED0   : longword;
    FLTCR       : longword;
    ATCR1       : longword;
    ATSEEDR     : longword;
    ATOR        : longword;
    RESERVED1   : array[0..3] of longword;
    IER         : longword;
    SR          : longword;
    MISR        : longword;
    RESERVED2   : longword;
    SCR         : longword;
    COUNTR      : longword;
    RESERVED3   : array[0..2] of longword;
    CFGR        : longword;
    RESERVED4   : array[0..42] of longword;
    BKP0R       : longword;
    BKP1R       : longword;
    BKP2R       : longword;
    BKP3R       : longword;
    BKP4R       : longword;
    BKP5R       : longword;
    BKP6R       : longword;
    BKP7R       : longword;
    BKP8R       : longword;
    BKP9R       : longword;
    BKP10R      : longword;
    BKP11R      : longword;
    BKP12R      : longword;
    BKP13R      : longword;
    BKP14R      : longword;
    BKP15R      : longword;
    BKP16R      : longword;
    BKP17R      : longword;
    BKP18R      : longword;
    BKP19R      : longword;
    BKP20R      : longword;
    BKP21R      : longword;
    BKP22R      : longword;
    BKP23R      : longword;
    BKP24R      : longword;
    BKP25R      : longword;
    BKP26R      : longword;
    BKP27R      : longword;
    BKP28R      : longword;
    BKP29R      : longword;
    BKP30R      : longword;
    BKP31R      : longword;
  end;

  TSAI_Registers = record
    GCR         : longword;
    RESERVED0   : array[0..15] of longword;
    PDMCR       : longword;
    PDMDLY      : longword;
  end;

  TSAI_Block_Registers = record
    CR1         : longword;
    CR2         : longword;
    FRCR        : longword;
    SLOTR       : longword;
    IMR         : longword;
    SR          : longword;
    CLRFR       : longword;
    DR          : longword;
  end;

  TSPDIFRX_Registers = record
    CR          : longword;
    IMR         : longword;
    SR          : longword;
    IFCR        : longword;
    DR          : longword;
    CSR         : longword;
    DIR         : longword;
    RESERVED2   : longword;
  end;

  TSDMMC_Registers = record
    POWER       : longword;
    CLKCR       : longword;
    ARG         : longword;
    CMD         : longword;
    RESPCMD     : longword;
    RESP1       : longword;
    RESP2       : longword;
    RESP3       : longword;
    RESP4       : longword;
    DTIMER      : longword;
    DLEN        : longword;
    DCTRL       : longword;
    DCOUNT      : longword;
    STA         : longword;
    ICR         : longword;
    MASK        : longword;
    ACKTIME     : longword;
    RESERVED0   : array[0..2] of longword;
    IDMACTRL    : longword;
    IDMABSIZE   : longword;
    IDMABASE0   : longword;
    IDMABASE1   : longword;
    RESERVED1   : array[0..7] of longword;
    FIFO        : longword;
    RESERVED2   : array[0..221] of longword;
    IPVR        : longword;
  end;

  TDLYB_Registers = record
    CR          : longword;
    CFGR        : longword;
  end;

  THSEM_Registers = record
    R           : array[0..31] of longword;
    RLR         : array[0..31] of longword;
    C1IER       : longword;
    C1ICR       : longword;
    C1ISR       : longword;
    C1MISR      : longword;
    Reserved    : array[0..11] of longword;
    CR          : longword;
    KEYR        : longword;
  end;

  THSEM_Common_Registers = record
    IER         : longword;
    ICR         : longword;
    ISR         : longword;
    MISR        : longword;
  end;

  TSPI_Registers = record
    CR1         : longword;
    CR2         : longword;
    CFG1        : longword;
    CFG2        : longword;
    IER         : longword;
    SR          : longword;
    IFCR        : longword;
    RESERVED0   : longword;
    TXDR        : longword;
    RESERVED1   : array[0..2] of longword;
    RXDR        : longword;
    RESERVED2   : array[0..2] of longword;
    CRCPOLY     : longword;
    TXCRC       : longword;
    RXCRC       : longword;
    UDRDR       : longword;
    I2SCFGR     : longword;
  end;

  TDTS_Registers = record
    CFGR1       : longword;
    RESERVED0   : longword;
    T0VALR1     : longword;
    RESERVED1   : longword;
    RAMPVALR    : longword;
    ITR1        : longword;
    RESERVED2   : longword;
    DR          : longword;
    SR          : longword;
    ITENR       : longword;
    ICIFR       : longword;
    &OR         : longword;
  end;

  TTIM_Registers = record
    CR1         : longword;
    CR2         : longword;
    SMCR        : longword;
    DIER        : longword;
    SR          : longword;
    EGR         : longword;
    CCMR1       : longword;
    CCMR2       : longword;
    CCER        : longword;
    CNT         : longword;
    PSC         : longword;
    ARR         : longword;
    RCR         : longword;
    CCR1        : longword;
    CCR2        : longword;
    CCR3        : longword;
    CCR4        : longword;
    BDTR        : longword;
    DCR         : longword;
    DMAR        : longword;
    RESERVED1   : longword;
    CCMR3       : longword;
    CCR5        : longword;
    CCR6        : longword;
    AF1         : longword;
    AF2         : longword;
    TISEL       : longword;
  end;

  TLPTIM_Registers = record
    ISR         : longword;
    ICR         : longword;
    IER         : longword;
    CFGR        : longword;
    CR          : longword;
    CMP         : longword;
    ARR         : longword;
    CNT         : longword;
    RESERVED1   : longword;
    CFGR2       : longword;
  end;

  TCOMPOPT_Registers = record
    SR          : longword;
    ICFR        : longword;
    &OR         : longword;
  end;

  TCOMP_Registers = record
    CFGR        : longword;
  end;

  TCOMP_Common_Registers = record
    CFGR        : longword;
  end;

  TUSART_Registers = record
    CR1         : longword;
    CR2         : longword;
    CR3         : longword;
    BRR         : longword;
    GTPR        : longword;
    RTOR        : longword;
    RQR         : longword;
    ISR         : longword;
    ICR         : longword;
    RDR         : longword;
    TDR         : longword;
    PRESC       : longword;
  end;

  TSWPMI_Registers = record
    CR          : longword;
    BRR         : longword;
    RESERVED1   : longword;
    ISR         : longword;
    ICR         : longword;
    IER         : longword;
    RFL         : longword;
    TDR         : longword;
    RDR         : longword;
    &OR         : longword;
  end;

  TWWDG_Registers = record
    CR          : longword;
    CFR         : longword;
    SR          : longword;
  end;

  TRAMECC_Monitor_Registers = record
    CR          : longword;
    SR          : longword;
    FAR         : longword;
    FDRL        : longword;
    FDRH        : longword;
    FECR        : longword;
  end;

  TRAMECC_Registers = record
    IER         : longword;
  end;

  TRNG_Registers = record
    CR          : longword;
    SR          : longword;
    DR          : longword;
    RESERVED    : longword;
    HTCR        : longword;
  end;

  TMDIOS_Registers = record
    CR          : longword;
    WRFR        : longword;
    CWRFR       : longword;
    RDFR        : longword;
    CRDFR       : longword;
    SR          : longword;
    CLRFR       : longword;
    RESERVED    : array[0..56] of longword;
    DINR0       : longword;
    DINR1       : longword;
    DINR2       : longword;
    DINR3       : longword;
    DINR4       : longword;
    DINR5       : longword;
    DINR6       : longword;
    DINR7       : longword;
    DINR8       : longword;
    DINR9       : longword;
    DINR10      : longword;
    DINR11      : longword;
    DINR12      : longword;
    DINR13      : longword;
    DINR14      : longword;
    DINR15      : longword;
    DINR16      : longword;
    DINR17      : longword;
    DINR18      : longword;
    DINR19      : longword;
    DINR20      : longword;
    DINR21      : longword;
    DINR22      : longword;
    DINR23      : longword;
    DINR24      : longword;
    DINR25      : longword;
    DINR26      : longword;
    DINR27      : longword;
    DINR28      : longword;
    DINR29      : longword;
    DINR30      : longword;
    DINR31      : longword;
    DOUTR0      : longword;
    DOUTR1      : longword;
    DOUTR2      : longword;
    DOUTR3      : longword;
    DOUTR4      : longword;
    DOUTR5      : longword;
    DOUTR6      : longword;
    DOUTR7      : longword;
    DOUTR8      : longword;
    DOUTR9      : longword;
    DOUTR10     : longword;
    DOUTR11     : longword;
    DOUTR12     : longword;
    DOUTR13     : longword;
    DOUTR14     : longword;
    DOUTR15     : longword;
    DOUTR16     : longword;
    DOUTR17     : longword;
    DOUTR18     : longword;
    DOUTR19     : longword;
    DOUTR20     : longword;
    DOUTR21     : longword;
    DOUTR22     : longword;
    DOUTR23     : longword;
    DOUTR24     : longword;
    DOUTR25     : longword;
    DOUTR26     : longword;
    DOUTR27     : longword;
    DOUTR28     : longword;
    DOUTR29     : longword;
    DOUTR30     : longword;
    DOUTR31     : longword;
  end;

  TUSB_OTG_Global_Registers = record
    GOTGCTL     : longword;
    GOTGINT     : longword;
    GAHBCFG     : longword;
    GUSBCFG     : longword;
    GRSTCTL     : longword;
    GINTSTS     : longword;
    GINTMSK     : longword;
    GRXSTSR     : longword;
    GRXSTSP     : longword;
    GRXFSIZ     : longword;
    DIEPTXF0_HNPTXFSIZ : longword;
    HNPTXSTS    : longword;
    Reserved30  : array[0..1] of longword;
    GCCFG       : longword;
    CID         : longword;
    GSNPSID     : longword;
    GHWCFG1     : longword;
    GHWCFG2     : longword;
    GHWCFG3     : longword;
    Reserved6   : longword;
    GLPMCFG     : longword;
    GPWRDN      : longword;
    GDFIFOCFG   : longword;
    GADPCTL     : longword;
    Reserved43  : array[0..38] of longword;
    HPTXFSIZ    : longword;
    DIEPTXF     : array[0..14] of longword;
  end;

  TUSB_OTG_Device_Registers = record
    DCFG        : longword;
    DCTL        : longword;
    DSTS        : longword;
    Reserved0C  : longword;
    DIEPMSK     : longword;
    DOEPMSK     : longword;
    DAINT       : longword;
    DAINTMSK    : longword;
    Reserved20  : longword;
    Reserved9   : longword;
    DVBUSDIS    : longword;
    DVBUSPULSE  : longword;
    DTHRCTL     : longword;
    DIEPEMPMSK  : longword;
    DEACHINT    : longword;
    DEACHMSK    : longword;
    Reserved40  : longword;
    DINEP1MSK   : longword;
    Reserved44  : array[0..14] of longword;
    DOUTEP1MSK  : longword;
  end;

  TUSB_OTG_INEndpoint_Registers = record
    DIEPCTL     : longword;
    Reserved04  : longword;
    DIEPINT     : longword;
    Reserved0C  : longword;
    DIEPTSIZ    : longword;
    DIEPDMA     : longword;
    DTXFSTS     : longword;
    Reserved18  : longword;
  end;

  TUSB_OTG_OUTEndpoint_Registers = record
    DOEPCTL     : longword;
    Reserved04  : longword;
    DOEPINT     : longword;
    Reserved0C  : longword;
    DOEPTSIZ    : longword;
    DOEPDMA     : longword;
    Reserved18  : array[0..1] of longword;
  end;

  TUSB_OTG_Host_Registers = record
    HCFG        : longword;
    HFIR        : longword;
    HFNUM       : longword;
    Reserved40C : longword;
    HPTXSTS     : longword;
    HAINT       : longword;
    HAINTMSK    : longword;
  end;

  TUSB_OTG_HostChannel_Registers = record
    HCCHAR      : longword;
    HCSPLT      : longword;
    HCINT       : longword;
    HCINTMSK    : longword;
    HCTSIZ      : longword;
    HCDMA       : longword;
    Reserved    : array[0..1] of longword;
  end;

  TOCTOSPI_Registers = record
    CR          : longword;
    RESERVED    : longword;
    DCR1        : longword;
    DCR2        : longword;
    DCR3        : longword;
    DCR4        : longword;
    RESERVED1   : array[0..1] of longword;
    SR          : longword;
    FCR         : longword;
    RESERVED2   : array[0..5] of longword;
    DLR         : longword;
    RESERVED3   : longword;
    AR          : longword;
    RESERVED4   : longword;
    DR          : longword;
    RESERVED5   : array[0..10] of longword;
    PSMKR       : longword;
    RESERVED6   : longword;
    PSMAR       : longword;
    RESERVED7   : longword;
    PIR         : longword;
    RESERVED8   : array[0..26] of longword;
    CCR         : longword;
    RESERVED9   : longword;
    TCR         : longword;
    RESERVED10  : longword;
    IR          : longword;
    RESERVED11  : array[0..2] of longword;
    ABR         : longword;
    RESERVED12  : array[0..2] of longword;
    LPTR        : longword;
    RESERVED13  : array[0..2] of longword;
    WPCCR       : longword;
    RESERVED14  : longword;
    WPTCR       : longword;
    RESERVED15  : longword;
    WPIR        : longword;
    RESERVED16  : array[0..2] of longword;
    WPABR       : longword;
    RESERVED17  : array[0..6] of longword;
    WCCR        : longword;
    RESERVED18  : longword;
    WTCR        : longword;
    RESERVED19  : longword;
    WIR         : longword;
    RESERVED20  : array[0..2] of longword;
    WABR        : longword;
    RESERVED21  : array[0..22] of longword;
    HLCR        : longword;
    RESERVED22  : array[0..121] of longword;
    HWCFGR      : longword;
    VER         : longword;
    ID          : longword;
    MID         : longword;
  end;

  TOCTOSPIM_Registers = record
    CR          : longword;
    PCR         : array[0..2] of longword;
  end;

const
  __NVIC_PRIO_BITS= 4;
  CD_ITCMRAM_BASE= $00000000;
  CD_DTCMRAM_BASE= $20000000;
  CD_AXIFLASH_BASE= $08000000;
  CD_AXISRAM1_BASE= $24000000;
  CD_AXISRAM2_BASE= $24040000;
  CD_AXISRAM3_BASE= $240A0000;
  CD_AHBSRAM1_BASE= $30000000;
  CD_AHBSRAM2_BASE= $30010000;
  SRD_BKPSRAM_BASE= $38800000;
  SRD_SRAM_BASE = $38000000;
  OCTOSPI1_BASE = $90000000;
  OCTOSPI2_BASE = $70000000;
  FLASH_BANK1_BASE= $08000000;
  FLASH_BANK2_BASE= $08100000;
  FLASH_BASE    = FLASH_BANK1_BASE;
  D1_AXISRAM_BASE= CD_AXISRAM1_BASE;
  FLASH_OTP_BASE= $08FFF000;
  UID_BASE      = $08FFF800;
  FLASHSIZE_BASE= $08FFF80C;
  PACKAGE_BASE  = $08FFF80E;
  PERIPH_BASE   = $40000000;
  CD_APB1PERIPH_BASE= PERIPH_BASE;
  CD_APB2PERIPH_BASE= PERIPH_BASE + $00010000;
  CD_AHB1PERIPH_BASE= PERIPH_BASE + $00020000;
  CD_AHB2PERIPH_BASE= PERIPH_BASE + $08020000;
  CD_APB3PERIPH_BASE= PERIPH_BASE + $10000000;
  CD_AHB3PERIPH_BASE= PERIPH_BASE + $12000000;
  SRD_APB4PERIPH_BASE= PERIPH_BASE + $18000000;
  SRD_AHB4PERIPH_BASE= PERIPH_BASE + $18020000;
  APB1PERIPH_BASE= PERIPH_BASE;
  APB2PERIPH_BASE= PERIPH_BASE + $00010000;
  AHB1PERIPH_BASE= PERIPH_BASE + $00020000;
  AHB2PERIPH_BASE= PERIPH_BASE + $08020000;
  MDMA_BASE     = CD_AHB3PERIPH_BASE + $0000;
  DMA2D_BASE    = CD_AHB3PERIPH_BASE + $1000;
  FLASH_R_BASE  = CD_AHB3PERIPH_BASE + $2000;
  JPGDEC_BASE   = CD_AHB3PERIPH_BASE + $3000;
  FMC_R_BASE    = CD_AHB3PERIPH_BASE + $4000;
  OCTOSPI1_R_BASE= CD_AHB3PERIPH_BASE + $5000;
  DLYB_OCTOSPI1_BASE= CD_AHB3PERIPH_BASE + $6000;
  SDMMC1_BASE   = CD_AHB3PERIPH_BASE + $7000;
  DLYB_SDMMC1_BASE= CD_AHB3PERIPH_BASE + $8000;
  RAMECC_BASE   = CD_AHB3PERIPH_BASE + $9000;
  OCTOSPI2_R_BASE= CD_AHB3PERIPH_BASE + $A000;
  DLYB_OCTOSPI2_BASE= CD_AHB3PERIPH_BASE + $B000;
  OCTOSPIM_BASE = CD_AHB3PERIPH_BASE + $B400;
  DMA1_BASE     = CD_AHB1PERIPH_BASE + $0000;
  DMA2_BASE     = CD_AHB1PERIPH_BASE + $0400;
  DMAMUX1_BASE  = CD_AHB1PERIPH_BASE + $0800;
  ADC1_BASE     = CD_AHB1PERIPH_BASE + $2000;
  ADC2_BASE     = CD_AHB1PERIPH_BASE + $2100;
  ADC12_COMMON_BASE= CD_AHB1PERIPH_BASE + $2300;
  CRC_BASE      = CD_AHB1PERIPH_BASE + $3000;
  USB1_OTG_HS_PERIPH_BASE= $40040000;
  USB_OTG_GLOBAL_BASE= $000;
  USB_OTG_DEVICE_BASE= $800;
  USB_OTG_IN_ENDPOINT_BASE= $900;
  USB_OTG_OUT_ENDPOINT_BASE= $B00;
  USB_OTG_HOST_BASE= $400;
  USB_OTG_HOST_PORT_BASE= $440;
  USB_OTG_HOST_CHANNEL_BASE= $500;
  USB_OTG_PCGCCTL_BASE= $E00;
  USB_OTG_FIFO_BASE= $1000;
  DCMI_BASE     = CD_AHB2PERIPH_BASE + $0000;
  PSSI_BASE     = CD_AHB2PERIPH_BASE + $0400;
  HSEM_BASE     = CD_AHB2PERIPH_BASE + $0800;
  RNG_BASE      = CD_AHB2PERIPH_BASE + $1800;
  SDMMC2_BASE   = CD_AHB2PERIPH_BASE + $2400;
  DLYB_SDMMC2_BASE= CD_AHB2PERIPH_BASE + $2800;
  BDMA1_BASE    = CD_AHB2PERIPH_BASE + $2C00;
  GPIOA_BASE    = SRD_AHB4PERIPH_BASE + $0000;
  GPIOB_BASE    = SRD_AHB4PERIPH_BASE + $0400;
  GPIOC_BASE    = SRD_AHB4PERIPH_BASE + $0800;
  GPIOD_BASE    = SRD_AHB4PERIPH_BASE + $0C00;
  GPIOE_BASE    = SRD_AHB4PERIPH_BASE + $1000;
  GPIOF_BASE    = SRD_AHB4PERIPH_BASE + $1400;
  GPIOG_BASE    = SRD_AHB4PERIPH_BASE + $1800;
  GPIOH_BASE    = SRD_AHB4PERIPH_BASE + $1C00;
  GPIOI_BASE    = SRD_AHB4PERIPH_BASE + $2000;
  GPIOJ_BASE    = SRD_AHB4PERIPH_BASE + $2400;
  GPIOK_BASE    = SRD_AHB4PERIPH_BASE + $2800;
  RCC_BASE      = SRD_AHB4PERIPH_BASE + $4400;
  PWR_BASE      = SRD_AHB4PERIPH_BASE + $4800;
  BDMA2_BASE    = SRD_AHB4PERIPH_BASE + $5400;
  DMAMUX2_BASE  = SRD_AHB4PERIPH_BASE + $5800;
  LTDC_BASE     = CD_APB3PERIPH_BASE + $1000;
  LTDC_Layer1_BASE= LTDC_BASE + $84;
  LTDC_Layer2_BASE= LTDC_BASE + $104;
  WWDG1_BASE    = CD_APB3PERIPH_BASE + $3000;
  TIM2_BASE     = CD_APB1PERIPH_BASE + $0000;
  TIM3_BASE     = CD_APB1PERIPH_BASE + $0400;
  TIM4_BASE     = CD_APB1PERIPH_BASE + $0800;
  TIM5_BASE     = CD_APB1PERIPH_BASE + $0C00;
  TIM6_BASE     = CD_APB1PERIPH_BASE + $1000;
  TIM7_BASE     = CD_APB1PERIPH_BASE + $1400;
  TIM12_BASE    = CD_APB1PERIPH_BASE + $1800;
  TIM13_BASE    = CD_APB1PERIPH_BASE + $1C00;
  TIM14_BASE    = CD_APB1PERIPH_BASE + $2000;
  LPTIM1_BASE   = CD_APB1PERIPH_BASE + $2400;
  SPI2_BASE     = CD_APB1PERIPH_BASE + $3800;
  SPI3_BASE     = CD_APB1PERIPH_BASE + $3C00;
  SPDIFRX_BASE  = CD_APB1PERIPH_BASE + $4000;
  USART2_BASE   = CD_APB1PERIPH_BASE + $4400;
  USART3_BASE   = CD_APB1PERIPH_BASE + $4800;
  UART4_BASE    = CD_APB1PERIPH_BASE + $4C00;
  UART5_BASE    = CD_APB1PERIPH_BASE + $5000;
  I2C1_BASE     = CD_APB1PERIPH_BASE + $5400;
  I2C2_BASE     = CD_APB1PERIPH_BASE + $5800;
  I2C3_BASE     = CD_APB1PERIPH_BASE + $5C00;
  CEC_BASE      = CD_APB1PERIPH_BASE + $6C00;
  DAC1_BASE     = CD_APB1PERIPH_BASE + $7400;
  UART7_BASE    = CD_APB1PERIPH_BASE + $7800;
  UART8_BASE    = CD_APB1PERIPH_BASE + $7C00;
  CRS_BASE      = CD_APB1PERIPH_BASE + $8400;
  SWPMI1_BASE   = CD_APB1PERIPH_BASE + $8800;
  OPAMP_BASE    = CD_APB1PERIPH_BASE + $9000;
  OPAMP1_BASE   = CD_APB1PERIPH_BASE + $9000;
  OPAMP2_BASE   = CD_APB1PERIPH_BASE + $9010;
  MDIOS_BASE    = CD_APB1PERIPH_BASE + $9400;
  FDCAN1_BASE   = CD_APB1PERIPH_BASE + $A000;
  FDCAN2_BASE   = CD_APB1PERIPH_BASE + $A400;
  FDCAN_CCU_BASE= CD_APB1PERIPH_BASE + $A800;
  SRAMCAN_BASE  = CD_APB1PERIPH_BASE + $AC00;
  TIM1_BASE     = CD_APB2PERIPH_BASE + $0000;
  TIM8_BASE     = CD_APB2PERIPH_BASE + $0400;
  USART1_BASE   = CD_APB2PERIPH_BASE + $1000;
  USART6_BASE   = CD_APB2PERIPH_BASE + $1400;
  UART9_BASE    = CD_APB2PERIPH_BASE + $1800;
  USART10_BASE  = CD_APB2PERIPH_BASE + $1C00;
  SPI1_BASE     = CD_APB2PERIPH_BASE + $3000;
  SPI4_BASE     = CD_APB2PERIPH_BASE + $3400;
  TIM15_BASE    = CD_APB2PERIPH_BASE + $4000;
  TIM16_BASE    = CD_APB2PERIPH_BASE + $4400;
  TIM17_BASE    = CD_APB2PERIPH_BASE + $4800;
  SPI5_BASE     = CD_APB2PERIPH_BASE + $5000;
  SAI1_BASE     = CD_APB2PERIPH_BASE + $5800;
  SAI1_Block_A_BASE= SAI1_BASE + $004;
  SAI1_Block_B_BASE= SAI1_BASE + $024;
  SAI2_BASE     = CD_APB2PERIPH_BASE + $5C00;
  SAI2_Block_A_BASE= SAI2_BASE + $004;
  SAI2_Block_B_BASE= SAI2_BASE + $024;
  DFSDM1_BASE   = CD_APB2PERIPH_BASE + $7800;
  DFSDM1_Channel0_BASE= DFSDM1_BASE + $00;
  DFSDM1_Channel1_BASE= DFSDM1_BASE + $20;
  DFSDM1_Channel2_BASE= DFSDM1_BASE + $40;
  DFSDM1_Channel3_BASE= DFSDM1_BASE + $60;
  DFSDM1_Channel4_BASE= DFSDM1_BASE + $80;
  DFSDM1_Channel5_BASE= DFSDM1_BASE + $A0;
  DFSDM1_Channel6_BASE= DFSDM1_BASE + $C0;
  DFSDM1_Channel7_BASE= DFSDM1_BASE + $E0;
  DFSDM1_Filter0_BASE= DFSDM1_BASE + $100;
  DFSDM1_Filter1_BASE= DFSDM1_BASE + $180;
  DFSDM1_Filter2_BASE= DFSDM1_BASE + $200;
  DFSDM1_Filter3_BASE= DFSDM1_BASE + $280;
  DFSDM1_Filter4_BASE= DFSDM1_BASE + $300;
  DFSDM1_Filter5_BASE= DFSDM1_BASE + $380;
  DFSDM1_Filter6_BASE= DFSDM1_BASE + $400;
  DFSDM1_Filter7_BASE= DFSDM1_BASE + $480;
  EXTI_BASE     = SRD_APB4PERIPH_BASE + $0000;
  EXTI_D1_BASE  = EXTI_BASE + $0080;
  SYSCFG_BASE   = SRD_APB4PERIPH_BASE + $0400;
  LPUART1_BASE  = SRD_APB4PERIPH_BASE + $0C00;
  SPI6_BASE     = SRD_APB4PERIPH_BASE + $1400;
  I2C4_BASE     = SRD_APB4PERIPH_BASE + $1C00;
  LPTIM2_BASE   = SRD_APB4PERIPH_BASE + $2400;
  LPTIM3_BASE   = SRD_APB4PERIPH_BASE + $2800;
  DAC2_BASE     = SRD_APB4PERIPH_BASE + $3400;
  COMP12_BASE   = SRD_APB4PERIPH_BASE + $3800;
  COMP1_BASE    = COMP12_BASE + $0C;
  COMP2_BASE    = COMP12_BASE + $10;
  VREFBUF_BASE  = SRD_APB4PERIPH_BASE + $3C00;
  RTC_BASE      = SRD_APB4PERIPH_BASE + $4000;
  TAMP_BASE     = SRD_APB4PERIPH_BASE + $4400;
  IWDG1_BASE    = SRD_APB4PERIPH_BASE + $4800;
  DTS_BASE      = SRD_APB4PERIPH_BASE + $6800;
  DFSDM2_BASE   = SRD_APB4PERIPH_BASE + $6C00;
  DFSDM2_Channel0_BASE= DFSDM2_BASE + $00;
  DFSDM2_Channel1_BASE= DFSDM2_BASE + $20;
  DFSDM2_FLT0_BASE= DFSDM2_BASE + $100;
  GFXMMU_BASE   = CD_AHB3PERIPH_BASE + $C000;
  BDMA1_Channel0_BASE= BDMA1_BASE + $0008;
  BDMA1_Channel1_BASE= BDMA1_BASE + $001C;
  BDMA1_Channel2_BASE= BDMA1_BASE + $0030;
  BDMA1_Channel3_BASE= BDMA1_BASE + $0044;
  BDMA1_Channel4_BASE= BDMA1_BASE + $0058;
  BDMA1_Channel5_BASE= BDMA1_BASE + $006C;
  BDMA1_Channel6_BASE= BDMA1_BASE + $0080;
  BDMA1_Channel7_BASE= BDMA1_BASE + $0094;
  BDMA2_Channel0_BASE= BDMA2_BASE + $0008;
  BDMA2_Channel1_BASE= BDMA2_BASE + $001C;
  BDMA2_Channel2_BASE= BDMA2_BASE + $0030;
  BDMA2_Channel3_BASE= BDMA2_BASE + $0044;
  BDMA2_Channel4_BASE= BDMA2_BASE + $0058;
  BDMA2_Channel5_BASE= BDMA2_BASE + $006C;
  BDMA2_Channel6_BASE= BDMA2_BASE + $0080;
  BDMA2_Channel7_BASE= BDMA2_BASE + $0094;
  DMAMUX2_Channel0_BASE= DMAMUX2_BASE;
  DMAMUX2_Channel1_BASE= DMAMUX2_BASE + $0004;
  DMAMUX2_Channel2_BASE= DMAMUX2_BASE + $0008;
  DMAMUX2_Channel3_BASE= DMAMUX2_BASE + $000C;
  DMAMUX2_Channel4_BASE= DMAMUX2_BASE + $0010;
  DMAMUX2_Channel5_BASE= DMAMUX2_BASE + $0014;
  DMAMUX2_Channel6_BASE= DMAMUX2_BASE + $0018;
  DMAMUX2_Channel7_BASE= DMAMUX2_BASE + $001C;
  DMAMUX2_RequestGenerator0_BASE= DMAMUX2_BASE + $0100;
  DMAMUX2_RequestGenerator1_BASE= DMAMUX2_BASE + $0104;
  DMAMUX2_RequestGenerator2_BASE= DMAMUX2_BASE + $0108;
  DMAMUX2_RequestGenerator3_BASE= DMAMUX2_BASE + $010C;
  DMAMUX2_RequestGenerator4_BASE= DMAMUX2_BASE + $0110;
  DMAMUX2_RequestGenerator5_BASE= DMAMUX2_BASE + $0114;
  DMAMUX2_RequestGenerator6_BASE= DMAMUX2_BASE + $0118;
  DMAMUX2_RequestGenerator7_BASE= DMAMUX2_BASE + $011C;
  DMAMUX2_ChannelStatus_BASE= DMAMUX2_BASE + $0080;
  DMAMUX2_RequestGenStatus_BASE= DMAMUX2_BASE + $0140;
  DMA1_Stream0_BASE= DMA1_BASE + $010;
  DMA1_Stream1_BASE= DMA1_BASE + $028;
  DMA1_Stream2_BASE= DMA1_BASE + $040;
  DMA1_Stream3_BASE= DMA1_BASE + $058;
  DMA1_Stream4_BASE= DMA1_BASE + $070;
  DMA1_Stream5_BASE= DMA1_BASE + $088;
  DMA1_Stream6_BASE= DMA1_BASE + $0A0;
  DMA1_Stream7_BASE= DMA1_BASE + $0B8;
  DMA2_Stream0_BASE= DMA2_BASE + $010;
  DMA2_Stream1_BASE= DMA2_BASE + $028;
  DMA2_Stream2_BASE= DMA2_BASE + $040;
  DMA2_Stream3_BASE= DMA2_BASE + $058;
  DMA2_Stream4_BASE= DMA2_BASE + $070;
  DMA2_Stream5_BASE= DMA2_BASE + $088;
  DMA2_Stream6_BASE= DMA2_BASE + $0A0;
  DMA2_Stream7_BASE= DMA2_BASE + $0B8;
  DMAMUX1_Channel0_BASE= DMAMUX1_BASE;
  DMAMUX1_Channel1_BASE= DMAMUX1_BASE + $0004;
  DMAMUX1_Channel2_BASE= DMAMUX1_BASE + $0008;
  DMAMUX1_Channel3_BASE= DMAMUX1_BASE + $000C;
  DMAMUX1_Channel4_BASE= DMAMUX1_BASE + $0010;
  DMAMUX1_Channel5_BASE= DMAMUX1_BASE + $0014;
  DMAMUX1_Channel6_BASE= DMAMUX1_BASE + $0018;
  DMAMUX1_Channel7_BASE= DMAMUX1_BASE + $001C;
  DMAMUX1_Channel8_BASE= DMAMUX1_BASE + $0020;
  DMAMUX1_Channel9_BASE= DMAMUX1_BASE + $0024;
  DMAMUX1_Channel10_BASE= DMAMUX1_BASE + $0028;
  DMAMUX1_Channel11_BASE= DMAMUX1_BASE + $002C;
  DMAMUX1_Channel12_BASE= DMAMUX1_BASE + $0030;
  DMAMUX1_Channel13_BASE= DMAMUX1_BASE + $0034;
  DMAMUX1_Channel14_BASE= DMAMUX1_BASE + $0038;
  DMAMUX1_Channel15_BASE= DMAMUX1_BASE + $003C;
  DMAMUX1_RequestGenerator0_BASE= DMAMUX1_BASE + $0100;
  DMAMUX1_RequestGenerator1_BASE= DMAMUX1_BASE + $0104;
  DMAMUX1_RequestGenerator2_BASE= DMAMUX1_BASE + $0108;
  DMAMUX1_RequestGenerator3_BASE= DMAMUX1_BASE + $010C;
  DMAMUX1_RequestGenerator4_BASE= DMAMUX1_BASE + $0110;
  DMAMUX1_RequestGenerator5_BASE= DMAMUX1_BASE + $0114;
  DMAMUX1_RequestGenerator6_BASE= DMAMUX1_BASE + $0118;
  DMAMUX1_RequestGenerator7_BASE= DMAMUX1_BASE + $011C;
  DMAMUX1_ChannelStatus_BASE= DMAMUX1_BASE + $0080;
  DMAMUX1_RequestGenStatus_BASE= DMAMUX1_BASE + $0140;
  FMC_Bank1_R_BASE= FMC_R_BASE + $0000;
  FMC_Bank1E_R_BASE= FMC_R_BASE + $0104;
  FMC_Bank2_R_BASE= FMC_R_BASE + $0060;
  FMC_Bank3_R_BASE= FMC_R_BASE + $0080;
  FMC_Bank5_6_R_BASE= FMC_R_BASE + $0140;
  DBGMCU_BASE   = $5C001000;
  MDMA_Channel0_BASE= MDMA_BASE + $00000040;
  MDMA_Channel1_BASE= MDMA_BASE + $00000080;
  MDMA_Channel2_BASE= MDMA_BASE + $000000C0;
  MDMA_Channel3_BASE= MDMA_BASE + $00000100;
  MDMA_Channel4_BASE= MDMA_BASE + $00000140;
  MDMA_Channel5_BASE= MDMA_BASE + $00000180;
  MDMA_Channel6_BASE= MDMA_BASE + $000001C0;
  MDMA_Channel7_BASE= MDMA_BASE + $00000200;
  MDMA_Channel8_BASE= MDMA_BASE + $00000240;
  MDMA_Channel9_BASE= MDMA_BASE + $00000280;
  MDMA_Channel10_BASE= MDMA_BASE + $000002C0;
  MDMA_Channel11_BASE= MDMA_BASE + $00000300;
  MDMA_Channel12_BASE= MDMA_BASE + $00000340;
  MDMA_Channel13_BASE= MDMA_BASE + $00000380;
  MDMA_Channel14_BASE= MDMA_BASE + $000003C0;
  MDMA_Channel15_BASE= MDMA_BASE + $00000400;
  MDMA_Channel16_BASE= MDMA_BASE + $00000440;
  GFXMMU_VIRTUAL_BUFFERS_BASE= $25000000;
  GFXMMU_VIRTUAL_BUFFER0_BASE= GFXMMU_VIRTUAL_BUFFERS_BASE;
  GFXMMU_VIRTUAL_BUFFER1_BASE= GFXMMU_VIRTUAL_BUFFERS_BASE + $400000;
  GFXMMU_VIRTUAL_BUFFER2_BASE= GFXMMU_VIRTUAL_BUFFERS_BASE + $800000;
  GFXMMU_VIRTUAL_BUFFER3_BASE= GFXMMU_VIRTUAL_BUFFERS_BASE + $C00000;
  RAMECC_Monitor1_BASE= RAMECC_BASE + $20;
  RAMECC_Monitor2_BASE= RAMECC_BASE + $40;
  RAMECC_Monitor3_BASE= RAMECC_BASE + $60;
  USB_OTG_HS_PERIPH_BASE= USB1_OTG_HS_PERIPH_BASE;
  BDMA_BASE     = BDMA2_BASE;
  BDMA_Channel0_BASE= BDMA2_Channel0_BASE;
  BDMA_Channel1_BASE= BDMA2_Channel1_BASE;
  BDMA_Channel2_BASE= BDMA2_Channel2_BASE;
  BDMA_Channel3_BASE= BDMA2_Channel3_BASE;
  BDMA_Channel4_BASE= BDMA2_Channel4_BASE;
  BDMA_Channel5_BASE= BDMA2_Channel5_BASE;
  BDMA_Channel6_BASE= BDMA2_Channel6_BASE;
  BDMA_Channel7_BASE= BDMA2_Channel7_BASE;

var
  TIM2          : TTIM_Registers absolute TIM2_BASE;
  TIM3          : TTIM_Registers absolute TIM3_BASE;
  TIM4          : TTIM_Registers absolute TIM4_BASE;
  TIM5          : TTIM_Registers absolute TIM5_BASE;
  TIM6          : TTIM_Registers absolute TIM6_BASE;
  TIM7          : TTIM_Registers absolute TIM7_BASE;
  TIM13         : TTIM_Registers absolute TIM13_BASE;
  TIM14         : TTIM_Registers absolute TIM14_BASE;
  VREFBUF       : TVREFBUF_Registers absolute VREFBUF_BASE;
  RTC           : TRTC_Registers absolute RTC_BASE;
  TAMP          : TTAMP_Registers absolute TAMP_BASE;
  WWDG1         : TWWDG_Registers absolute WWDG1_BASE;
  IWDG1         : TIWDG_Registers absolute IWDG1_BASE;
  SPI2          : TSPI_Registers absolute SPI2_BASE;
  SPI3          : TSPI_Registers absolute SPI3_BASE;
  SPI4          : TSPI_Registers absolute SPI4_BASE;
  SPI5          : TSPI_Registers absolute SPI5_BASE;
  SPI6          : TSPI_Registers absolute SPI6_BASE;
  USART2        : TUSART_Registers absolute USART2_BASE;
  USART3        : TUSART_Registers absolute USART3_BASE;
  USART6        : TUSART_Registers absolute USART6_BASE;
  USART10       : TUSART_Registers absolute USART10_BASE;
  UART7         : TUSART_Registers absolute UART7_BASE;
  UART8         : TUSART_Registers absolute UART8_BASE;
  UART9         : TUSART_Registers absolute UART9_BASE;
  CRS           : TCRS_Registers absolute CRS_BASE;
  UART4         : TUSART_Registers absolute UART4_BASE;
  UART5         : TUSART_Registers absolute UART5_BASE;
  I2C1          : TI2C_Registers absolute I2C1_BASE;
  I2C2          : TI2C_Registers absolute I2C2_BASE;
  I2C3          : TI2C_Registers absolute I2C3_BASE;
  I2C4          : TI2C_Registers absolute I2C4_BASE;
  FDCAN_CCU     : TFDCAN_ClockCalibrationUnit_Registers absolute FDCAN_CCU_BASE;
  CEC           : TCEC_Registers absolute CEC_BASE;
  LPTIM1        : TLPTIM_Registers absolute LPTIM1_BASE;
  PWR           : TPWR_Registers absolute PWR_BASE;
  DAC1          : TDAC_Registers absolute DAC1_BASE;
  LPUART1       : TUSART_Registers absolute LPUART1_BASE;
  SWPMI1        : TSWPMI_Registers absolute SWPMI1_BASE;
  LPTIM2        : TLPTIM_Registers absolute LPTIM2_BASE;
  LPTIM3        : TLPTIM_Registers absolute LPTIM3_BASE;
  DTS           : TDTS_Registers absolute DTS_BASE;
  SYSCFG        : TSYSCFG_Registers absolute SYSCFG_BASE;
  COMP12        : TCOMPOPT_Registers absolute COMP12_BASE;
  COMP1         : TCOMP_Registers absolute COMP1_BASE;
  COMP2         : TCOMP_Registers absolute COMP2_BASE;
  COMP12_COMMON : TCOMP_Common_Registers absolute COMP2_BASE;
  OPAMP         : TOPAMP_Registers absolute OPAMP_BASE;
  OPAMP1        : TOPAMP_Registers absolute OPAMP1_BASE;
  OPAMP2        : TOPAMP_Registers absolute OPAMP2_BASE;
  EXTI          : TEXTI_Registers absolute EXTI_BASE;
  EXTI_D1       : TEXTI_Core_Registers absolute EXTI_D1_BASE;
  TIM1          : TTIM_Registers absolute TIM1_BASE;
  SPI1          : TSPI_Registers absolute SPI1_BASE;
  TIM8          : TTIM_Registers absolute TIM8_BASE;
  USART1        : TUSART_Registers absolute USART1_BASE;
  TIM12         : TTIM_Registers absolute TIM12_BASE;
  TIM15         : TTIM_Registers absolute TIM15_BASE;
  TIM16         : TTIM_Registers absolute TIM16_BASE;
  TIM17         : TTIM_Registers absolute TIM17_BASE;
  SAI1          : TSAI_Registers absolute SAI1_BASE;
  SAI1_Block_A  : TSAI_Block_Registers absolute SAI1_Block_A_BASE;
  SAI1_Block_B  : TSAI_Block_Registers absolute SAI1_Block_B_BASE;
  SAI2          : TSAI_Registers absolute SAI2_BASE;
  SAI2_Block_A  : TSAI_Block_Registers absolute SAI2_Block_A_BASE;
  SAI2_Block_B  : TSAI_Block_Registers absolute SAI2_Block_B_BASE;
  SPDIFRX       : TSPDIFRX_Registers absolute SPDIFRX_BASE;
  DFSDM1_Channel0: TDFSDM_Channel_Registers absolute DFSDM1_Channel0_BASE;
  DFSDM1_Channel1: TDFSDM_Channel_Registers absolute DFSDM1_Channel1_BASE;
  DFSDM1_Channel2: TDFSDM_Channel_Registers absolute DFSDM1_Channel2_BASE;
  DFSDM1_Channel3: TDFSDM_Channel_Registers absolute DFSDM1_Channel3_BASE;
  DFSDM1_Channel4: TDFSDM_Channel_Registers absolute DFSDM1_Channel4_BASE;
  DFSDM1_Channel5: TDFSDM_Channel_Registers absolute DFSDM1_Channel5_BASE;
  DFSDM1_Channel6: TDFSDM_Channel_Registers absolute DFSDM1_Channel6_BASE;
  DFSDM1_Channel7: TDFSDM_Channel_Registers absolute DFSDM1_Channel7_BASE;
  DFSDM1_Filter0: TDFSDM_Filter_Registers absolute DFSDM1_Filter0_BASE;
  DFSDM1_Filter1: TDFSDM_Filter_Registers absolute DFSDM1_Filter1_BASE;
  DFSDM1_Filter2: TDFSDM_Filter_Registers absolute DFSDM1_Filter2_BASE;
  DFSDM1_Filter3: TDFSDM_Filter_Registers absolute DFSDM1_Filter3_BASE;
  DFSDM1_Filter4: TDFSDM_Filter_Registers absolute DFSDM1_Filter4_BASE;
  DFSDM1_Filter5: TDFSDM_Filter_Registers absolute DFSDM1_Filter5_BASE;
  DFSDM1_Filter6: TDFSDM_Filter_Registers absolute DFSDM1_Filter6_BASE;
  DFSDM1_Filter7: TDFSDM_Filter_Registers absolute DFSDM1_Filter7_BASE;
  DFSDM2_Channel0: TDFSDM_Channel_Registers absolute DFSDM2_Channel0_BASE;
  DFSDM2_Channel1: TDFSDM_Channel_Registers absolute DFSDM2_Channel1_BASE;
  DFSDM2_Filter0: TDFSDM_Filter_Registers absolute DFSDM2_FLT0_BASE;
  DMA2D         : TDMA2D_Registers absolute DMA2D_BASE;
  DCMI          : TDCMI_Registers absolute DCMI_BASE;
  PSSI          : TPSSI_Registers absolute PSSI_BASE;
  RCC           : TRCC_Registers absolute RCC_BASE;
  FLASH         : TFLASH_Registers absolute FLASH_R_BASE;
  CRC           : TCRC_Registers absolute CRC_BASE;
  GPIOA         : TGPIO_Registers absolute GPIOA_BASE;
  GPIOB         : TGPIO_Registers absolute GPIOB_BASE;
  GPIOC         : TGPIO_Registers absolute GPIOC_BASE;
  GPIOD         : TGPIO_Registers absolute GPIOD_BASE;
  GPIOE         : TGPIO_Registers absolute GPIOE_BASE;
  GPIOF         : TGPIO_Registers absolute GPIOF_BASE;
  GPIOG         : TGPIO_Registers absolute GPIOG_BASE;
  GPIOH         : TGPIO_Registers absolute GPIOH_BASE;
  GPIOI         : TGPIO_Registers absolute GPIOI_BASE;
  GPIOJ         : TGPIO_Registers absolute GPIOJ_BASE;
  GPIOK         : TGPIO_Registers absolute GPIOK_BASE;
  ADC1          : TADC_Registers absolute ADC1_BASE;
  ADC2          : TADC_Registers absolute ADC2_BASE;
  ADC12_COMMON  : TADC_Common_Registers absolute ADC12_COMMON_BASE;
  RNG           : TRNG_Registers absolute RNG_BASE;
  SDMMC2        : TSDMMC_Registers absolute SDMMC2_BASE;
  DLYB_SDMMC2   : TDLYB_Registers absolute DLYB_SDMMC2_BASE;
  BDMA1         : TBDMA_Registers absolute BDMA1_BASE;
  BDMA1_Channel0: TBDMA_Channel_Registers absolute BDMA1_Channel0_BASE;
  BDMA1_Channel1: TBDMA_Channel_Registers absolute BDMA1_Channel1_BASE;
  BDMA1_Channel2: TBDMA_Channel_Registers absolute BDMA1_Channel2_BASE;
  BDMA1_Channel3: TBDMA_Channel_Registers absolute BDMA1_Channel3_BASE;
  BDMA1_Channel4: TBDMA_Channel_Registers absolute BDMA1_Channel4_BASE;
  BDMA1_Channel5: TBDMA_Channel_Registers absolute BDMA1_Channel5_BASE;
  BDMA1_Channel6: TBDMA_Channel_Registers absolute BDMA1_Channel6_BASE;
  BDMA1_Channel7: TBDMA_Channel_Registers absolute BDMA1_Channel7_BASE;
  BDMA2         : TBDMA_Registers absolute BDMA2_BASE;
  BDMA2_Channel0: TBDMA_Channel_Registers absolute BDMA2_Channel0_BASE;
  BDMA2_Channel1: TBDMA_Channel_Registers absolute BDMA2_Channel1_BASE;
  BDMA2_Channel2: TBDMA_Channel_Registers absolute BDMA2_Channel2_BASE;
  BDMA2_Channel3: TBDMA_Channel_Registers absolute BDMA2_Channel3_BASE;
  BDMA2_Channel4: TBDMA_Channel_Registers absolute BDMA2_Channel4_BASE;
  BDMA2_Channel5: TBDMA_Channel_Registers absolute BDMA2_Channel5_BASE;
  BDMA2_Channel6: TBDMA_Channel_Registers absolute BDMA2_Channel6_BASE;
  BDMA2_Channel7: TBDMA_Channel_Registers absolute BDMA2_Channel7_BASE;
  RAMECC        : TRAMECC_Registers absolute RAMECC_BASE;
  DMAMUX2       : TDMAMUX_Channel_Registers absolute DMAMUX2_BASE;
  DMAMUX2_Channel0: TDMAMUX_Channel_Registers absolute DMAMUX2_Channel0_BASE;
  DMAMUX2_Channel1: TDMAMUX_Channel_Registers absolute DMAMUX2_Channel1_BASE;
  DMAMUX2_Channel2: TDMAMUX_Channel_Registers absolute DMAMUX2_Channel2_BASE;
  DMAMUX2_Channel3: TDMAMUX_Channel_Registers absolute DMAMUX2_Channel3_BASE;
  DMAMUX2_Channel4: TDMAMUX_Channel_Registers absolute DMAMUX2_Channel4_BASE;
  DMAMUX2_Channel5: TDMAMUX_Channel_Registers absolute DMAMUX2_Channel5_BASE;
  DMAMUX2_Channel6: TDMAMUX_Channel_Registers absolute DMAMUX2_Channel6_BASE;
  DMAMUX2_Channel7: TDMAMUX_Channel_Registers absolute DMAMUX2_Channel7_BASE;
  DMAMUX2_RequestGenerator0: TDMAMUX_RequestGen_Registers absolute DMAMUX2_RequestGenerator0_BASE;
  DMAMUX2_RequestGenerator1: TDMAMUX_RequestGen_Registers absolute DMAMUX2_RequestGenerator1_BASE;
  DMAMUX2_RequestGenerator2: TDMAMUX_RequestGen_Registers absolute DMAMUX2_RequestGenerator2_BASE;
  DMAMUX2_RequestGenerator3: TDMAMUX_RequestGen_Registers absolute DMAMUX2_RequestGenerator3_BASE;
  DMAMUX2_RequestGenerator4: TDMAMUX_RequestGen_Registers absolute DMAMUX2_RequestGenerator4_BASE;
  DMAMUX2_RequestGenerator5: TDMAMUX_RequestGen_Registers absolute DMAMUX2_RequestGenerator5_BASE;
  DMAMUX2_RequestGenerator6: TDMAMUX_RequestGen_Registers absolute DMAMUX2_RequestGenerator6_BASE;
  DMAMUX2_RequestGenerator7: TDMAMUX_RequestGen_Registers absolute DMAMUX2_RequestGenerator7_BASE;
  DMAMUX2_ChannelStatus: TDMAMUX_ChannelStatus_Registers absolute DMAMUX2_ChannelStatus_BASE;
  DMAMUX2_RequestGenStatus: TDMAMUX_RequestGenStatus_Registers absolute DMAMUX2_RequestGenStatus_BASE;
  DMA2          : TDMA_Registers absolute DMA2_BASE;
  DMA2_Stream0  : TDMA_Stream_Registers absolute DMA2_Stream0_BASE;
  DMA2_Stream1  : TDMA_Stream_Registers absolute DMA2_Stream1_BASE;
  DMA2_Stream2  : TDMA_Stream_Registers absolute DMA2_Stream2_BASE;
  DMA2_Stream3  : TDMA_Stream_Registers absolute DMA2_Stream3_BASE;
  DMA2_Stream4  : TDMA_Stream_Registers absolute DMA2_Stream4_BASE;
  DMA2_Stream5  : TDMA_Stream_Registers absolute DMA2_Stream5_BASE;
  DMA2_Stream6  : TDMA_Stream_Registers absolute DMA2_Stream6_BASE;
  DMA2_Stream7  : TDMA_Stream_Registers absolute DMA2_Stream7_BASE;
  DMA1          : TDMA_Registers absolute DMA1_BASE;
  DMA1_Stream0  : TDMA_Stream_Registers absolute DMA1_Stream0_BASE;
  DMA1_Stream1  : TDMA_Stream_Registers absolute DMA1_Stream1_BASE;
  DMA1_Stream2  : TDMA_Stream_Registers absolute DMA1_Stream2_BASE;
  DMA1_Stream3  : TDMA_Stream_Registers absolute DMA1_Stream3_BASE;
  DMA1_Stream4  : TDMA_Stream_Registers absolute DMA1_Stream4_BASE;
  DMA1_Stream5  : TDMA_Stream_Registers absolute DMA1_Stream5_BASE;
  DMA1_Stream6  : TDMA_Stream_Registers absolute DMA1_Stream6_BASE;
  DMA1_Stream7  : TDMA_Stream_Registers absolute DMA1_Stream7_BASE;
  DMAMUX1       : TDMAMUX_Channel_Registers absolute DMAMUX1_BASE;
  DMAMUX1_Channel0: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel0_BASE;
  DMAMUX1_Channel1: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel1_BASE;
  DMAMUX1_Channel2: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel2_BASE;
  DMAMUX1_Channel3: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel3_BASE;
  DMAMUX1_Channel4: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel4_BASE;
  DMAMUX1_Channel5: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel5_BASE;
  DMAMUX1_Channel6: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel6_BASE;
  DMAMUX1_Channel7: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel7_BASE;
  DMAMUX1_Channel8: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel8_BASE;
  DMAMUX1_Channel9: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel9_BASE;
  DMAMUX1_Channel10: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel10_BASE;
  DMAMUX1_Channel11: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel11_BASE;
  DMAMUX1_Channel12: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel12_BASE;
  DMAMUX1_Channel13: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel13_BASE;
  DMAMUX1_Channel14: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel14_BASE;
  DMAMUX1_Channel15: TDMAMUX_Channel_Registers absolute DMAMUX1_Channel15_BASE;
  DMAMUX1_RequestGenerator0: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator0_BASE;
  DMAMUX1_RequestGenerator1: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator1_BASE;
  DMAMUX1_RequestGenerator2: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator2_BASE;
  DMAMUX1_RequestGenerator3: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator3_BASE;
  DMAMUX1_RequestGenerator4: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator4_BASE;
  DMAMUX1_RequestGenerator5: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator5_BASE;
  DMAMUX1_RequestGenerator6: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator6_BASE;
  DMAMUX1_RequestGenerator7: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator7_BASE;
  DMAMUX1_ChannelStatus: TDMAMUX_ChannelStatus_Registers absolute DMAMUX1_ChannelStatus_BASE;
  DMAMUX1_RequestGenStatus: TDMAMUX_RequestGenStatus_Registers absolute DMAMUX1_RequestGenStatus_BASE;
  FMC_Bank1_R   : TFMC_Bank1_Registers absolute FMC_Bank1_R_BASE;
  FMC_Bank1E_R  : TFMC_Bank1E_Registers absolute FMC_Bank1E_R_BASE;
  FMC_Bank2_R   : TFMC_Bank2_Registers absolute FMC_Bank2_R_BASE;
  FMC_Bank3_R   : TFMC_Bank3_Registers absolute FMC_Bank3_R_BASE;
  FMC_Bank5_6_R : TFMC_Bank5_6_Registers absolute FMC_Bank5_6_R_BASE;
  DAC2          : TDAC_Registers absolute DAC2_BASE;
  OCTOSPI1      : TOCTOSPI_Registers absolute OCTOSPI1_R_BASE;
  DLYB_OCTOSPI1 : TDLYB_Registers absolute DLYB_OCTOSPI1_BASE;
  OCTOSPI2      : TOCTOSPI_Registers absolute OCTOSPI2_R_BASE;
  DLYB_OCTOSPI2 : TDLYB_Registers absolute DLYB_OCTOSPI2_BASE;
  OCTOSPIM      : TOCTOSPIM_Registers absolute OCTOSPIM_BASE;
  GFXMMU        : TGFXMMU_Registers absolute GFXMMU_BASE;
  SDMMC1        : TSDMMC_Registers absolute SDMMC1_BASE;
  DLYB_SDMMC1   : TDLYB_Registers absolute DLYB_SDMMC1_BASE;
  DBGMCU        : TDBGMCU_Registers absolute DBGMCU_BASE;
  JPEG          : TJPEG_Registers absolute JPGDEC_BASE;
  HSEM          : THSEM_Registers absolute HSEM_BASE;
  HSEM_COMMON   : THSEM_Common_Registers absolute (HSEM_BASE + $100);
  LTDC          : TLTDC_Registers absolute LTDC_BASE;
  LTDC_Layer1   : TLTDC_Layer_Registers absolute LTDC_Layer1_BASE;
  LTDC_Layer2   : TLTDC_Layer_Registers absolute LTDC_Layer2_BASE;
  MDIOS         : TMDIOS_Registers absolute MDIOS_BASE;
  MDMA          : TMDMA_Registers absolute MDMA_BASE;
  MDMA_Channel0 : TMDMA_Channel_Registers absolute MDMA_Channel0_BASE;
  MDMA_Channel1 : TMDMA_Channel_Registers absolute MDMA_Channel1_BASE;
  MDMA_Channel2 : TMDMA_Channel_Registers absolute MDMA_Channel2_BASE;
  MDMA_Channel3 : TMDMA_Channel_Registers absolute MDMA_Channel3_BASE;
  MDMA_Channel4 : TMDMA_Channel_Registers absolute MDMA_Channel4_BASE;
  MDMA_Channel5 : TMDMA_Channel_Registers absolute MDMA_Channel5_BASE;
  MDMA_Channel6 : TMDMA_Channel_Registers absolute MDMA_Channel6_BASE;
  MDMA_Channel7 : TMDMA_Channel_Registers absolute MDMA_Channel7_BASE;
  MDMA_Channel8 : TMDMA_Channel_Registers absolute MDMA_Channel8_BASE;
  MDMA_Channel9 : TMDMA_Channel_Registers absolute MDMA_Channel9_BASE;
  MDMA_Channel10: TMDMA_Channel_Registers absolute MDMA_Channel10_BASE;
  MDMA_Channel11: TMDMA_Channel_Registers absolute MDMA_Channel11_BASE;
  MDMA_Channel12: TMDMA_Channel_Registers absolute MDMA_Channel12_BASE;
  MDMA_Channel13: TMDMA_Channel_Registers absolute MDMA_Channel13_BASE;
  MDMA_Channel14: TMDMA_Channel_Registers absolute MDMA_Channel14_BASE;
  MDMA_Channel15: TMDMA_Channel_Registers absolute MDMA_Channel15_BASE;

implementation

procedure NonMaskableInt_Handler; external name 'NonMaskableInt_Handler';
procedure HardFault_Handler; external name 'HardFault_Handler';
procedure MemoryManagement_Handler; external name 'MemoryManagement_Handler';
procedure BusFault_Handler; external name 'BusFault_Handler';
procedure UsageFault_Handler; external name 'UsageFault_Handler';
procedure SVCall_Handler; external name 'SVCall_Handler';
procedure DebugMonitor_Handler; external name 'DebugMonitor_Handler';
procedure PendSV_Handler; external name 'PendSV_Handler';
procedure SysTick_Handler; external name 'SysTick_Handler';
procedure WWDG_IRQHandler; external name 'WWDG_IRQHandler';
procedure PVD_PVM_IRQHandler; external name 'PVD_PVM_IRQHandler';
procedure RTC_TAMP_STAMP_CSS_LSE_IRQHandler; external name 'RTC_TAMP_STAMP_CSS_LSE_IRQHandler';
procedure RTC_WKUP_IRQHandler; external name 'RTC_WKUP_IRQHandler';
procedure FLASH_IRQHandler; external name 'FLASH_IRQHandler';
procedure RCC_IRQHandler; external name 'RCC_IRQHandler';
procedure EXTI0_IRQHandler; external name 'EXTI0_IRQHandler';
procedure EXTI1_IRQHandler; external name 'EXTI1_IRQHandler';
procedure EXTI2_IRQHandler; external name 'EXTI2_IRQHandler';
procedure EXTI3_IRQHandler; external name 'EXTI3_IRQHandler';
procedure EXTI4_IRQHandler; external name 'EXTI4_IRQHandler';
procedure DMA1_Stream0_IRQHandler; external name 'DMA1_Stream0_IRQHandler';
procedure DMA1_Stream1_IRQHandler; external name 'DMA1_Stream1_IRQHandler';
procedure DMA1_Stream2_IRQHandler; external name 'DMA1_Stream2_IRQHandler';
procedure DMA1_Stream3_IRQHandler; external name 'DMA1_Stream3_IRQHandler';
procedure DMA1_Stream4_IRQHandler; external name 'DMA1_Stream4_IRQHandler';
procedure DMA1_Stream5_IRQHandler; external name 'DMA1_Stream5_IRQHandler';
procedure DMA1_Stream6_IRQHandler; external name 'DMA1_Stream6_IRQHandler';
procedure ADC_IRQHandler; external name 'ADC_IRQHandler';
procedure FDCAN1_IT0_IRQHandler; external name 'FDCAN1_IT0_IRQHandler';
procedure FDCAN2_IT0_IRQHandler; external name 'FDCAN2_IT0_IRQHandler';
procedure FDCAN1_IT1_IRQHandler; external name 'FDCAN1_IT1_IRQHandler';
procedure FDCAN2_IT1_IRQHandler; external name 'FDCAN2_IT1_IRQHandler';
procedure EXTI9_5_IRQHandler; external name 'EXTI9_5_IRQHandler';
procedure TIM1_BRK_IRQHandler; external name 'TIM1_BRK_IRQHandler';
procedure TIM1_UP_IRQHandler; external name 'TIM1_UP_IRQHandler';
procedure TIM1_TRG_COM_IRQHandler; external name 'TIM1_TRG_COM_IRQHandler';
procedure TIM1_CC_IRQHandler; external name 'TIM1_CC_IRQHandler';
procedure TIM2_IRQHandler; external name 'TIM2_IRQHandler';
procedure TIM3_IRQHandler; external name 'TIM3_IRQHandler';
procedure TIM4_IRQHandler; external name 'TIM4_IRQHandler';
procedure I2C1_EV_IRQHandler; external name 'I2C1_EV_IRQHandler';
procedure I2C1_ER_IRQHandler; external name 'I2C1_ER_IRQHandler';
procedure I2C2_EV_IRQHandler; external name 'I2C2_EV_IRQHandler';
procedure I2C2_ER_IRQHandler; external name 'I2C2_ER_IRQHandler';
procedure SPI1_IRQHandler; external name 'SPI1_IRQHandler';
procedure SPI2_IRQHandler; external name 'SPI2_IRQHandler';
procedure USART1_IRQHandler; external name 'USART1_IRQHandler';
procedure USART2_IRQHandler; external name 'USART2_IRQHandler';
procedure USART3_IRQHandler; external name 'USART3_IRQHandler';
procedure EXTI15_10_IRQHandler; external name 'EXTI15_10_IRQHandler';
procedure RTC_Alarm_IRQHandler; external name 'RTC_Alarm_IRQHandler';
procedure DFSDM2_IRQHandler; external name 'DFSDM2_IRQHandler';
procedure TIM8_BRK_TIM12_IRQHandler; external name 'TIM8_BRK_TIM12_IRQHandler';
procedure TIM8_UP_TIM13_IRQHandler; external name 'TIM8_UP_TIM13_IRQHandler';
procedure TIM8_TRG_COM_TIM14_IRQHandler; external name 'TIM8_TRG_COM_TIM14_IRQHandler';
procedure TIM8_CC_IRQHandler; external name 'TIM8_CC_IRQHandler';
procedure DMA1_Stream7_IRQHandler; external name 'DMA1_Stream7_IRQHandler';
procedure FMC_IRQHandler; external name 'FMC_IRQHandler';
procedure SDMMC1_IRQHandler; external name 'SDMMC1_IRQHandler';
procedure TIM5_IRQHandler; external name 'TIM5_IRQHandler';
procedure SPI3_IRQHandler; external name 'SPI3_IRQHandler';
procedure UART4_IRQHandler; external name 'UART4_IRQHandler';
procedure UART5_IRQHandler; external name 'UART5_IRQHandler';
procedure TIM6_DAC_IRQHandler; external name 'TIM6_DAC_IRQHandler';
procedure TIM7_IRQHandler; external name 'TIM7_IRQHandler';
procedure DMA2_Stream0_IRQHandler; external name 'DMA2_Stream0_IRQHandler';
procedure DMA2_Stream1_IRQHandler; external name 'DMA2_Stream1_IRQHandler';
procedure DMA2_Stream2_IRQHandler; external name 'DMA2_Stream2_IRQHandler';
procedure DMA2_Stream3_IRQHandler; external name 'DMA2_Stream3_IRQHandler';
procedure DMA2_Stream4_IRQHandler; external name 'DMA2_Stream4_IRQHandler';
procedure FDCAN_CAL_IRQHandler; external name 'FDCAN_CAL_IRQHandler';
procedure DFSDM1_FLT4_IRQHandler; external name 'DFSDM1_FLT4_IRQHandler';
procedure DFSDM1_FLT5_IRQHandler; external name 'DFSDM1_FLT5_IRQHandler';
procedure DFSDM1_FLT6_IRQHandler; external name 'DFSDM1_FLT6_IRQHandler';
procedure DFSDM1_FLT7_IRQHandler; external name 'DFSDM1_FLT7_IRQHandler';
procedure DMA2_Stream5_IRQHandler; external name 'DMA2_Stream5_IRQHandler';
procedure DMA2_Stream6_IRQHandler; external name 'DMA2_Stream6_IRQHandler';
procedure DMA2_Stream7_IRQHandler; external name 'DMA2_Stream7_IRQHandler';
procedure USART6_IRQHandler; external name 'USART6_IRQHandler';
procedure I2C3_EV_IRQHandler; external name 'I2C3_EV_IRQHandler';
procedure I2C3_ER_IRQHandler; external name 'I2C3_ER_IRQHandler';
procedure OTG_HS_EP1_OUT_IRQHandler; external name 'OTG_HS_EP1_OUT_IRQHandler';
procedure OTG_HS_EP1_IN_IRQHandler; external name 'OTG_HS_EP1_IN_IRQHandler';
procedure OTG_HS_WKUP_IRQHandler; external name 'OTG_HS_WKUP_IRQHandler';
procedure OTG_HS_IRQHandler; external name 'OTG_HS_IRQHandler';
procedure DCMI_PSSI_IRQHandler; external name 'DCMI_PSSI_IRQHandler';
procedure RNG_IRQHandler; external name 'RNG_IRQHandler';
procedure FPU_IRQHandler; external name 'FPU_IRQHandler';
procedure UART7_IRQHandler; external name 'UART7_IRQHandler';
procedure UART8_IRQHandler; external name 'UART8_IRQHandler';
procedure SPI4_IRQHandler; external name 'SPI4_IRQHandler';
procedure SPI5_IRQHandler; external name 'SPI5_IRQHandler';
procedure SPI6_IRQHandler; external name 'SPI6_IRQHandler';
procedure SAI1_IRQHandler; external name 'SAI1_IRQHandler';
procedure LTDC_IRQHandler; external name 'LTDC_IRQHandler';
procedure LTDC_ER_IRQHandler; external name 'LTDC_ER_IRQHandler';
procedure DMA2D_IRQHandler; external name 'DMA2D_IRQHandler';
procedure SAI2_IRQHandler; external name 'SAI2_IRQHandler';
procedure OCTOSPI1_IRQHandler; external name 'OCTOSPI1_IRQHandler';
procedure LPTIM1_IRQHandler; external name 'LPTIM1_IRQHandler';
procedure CEC_IRQHandler; external name 'CEC_IRQHandler';
procedure I2C4_EV_IRQHandler; external name 'I2C4_EV_IRQHandler';
procedure I2C4_ER_IRQHandler; external name 'I2C4_ER_IRQHandler';
procedure SPDIF_RX_IRQHandler; external name 'SPDIF_RX_IRQHandler';
procedure DMAMUX1_OVR_IRQHandler; external name 'DMAMUX1_OVR_IRQHandler';
procedure DFSDM1_FLT0_IRQHandler; external name 'DFSDM1_FLT0_IRQHandler';
procedure DFSDM1_FLT1_IRQHandler; external name 'DFSDM1_FLT1_IRQHandler';
procedure DFSDM1_FLT2_IRQHandler; external name 'DFSDM1_FLT2_IRQHandler';
procedure DFSDM1_FLT3_IRQHandler; external name 'DFSDM1_FLT3_IRQHandler';
procedure SWPMI1_IRQHandler; external name 'SWPMI1_IRQHandler';
procedure TIM15_IRQHandler; external name 'TIM15_IRQHandler';
procedure TIM16_IRQHandler; external name 'TIM16_IRQHandler';
procedure TIM17_IRQHandler; external name 'TIM17_IRQHandler';
procedure MDIOS_WKUP_IRQHandler; external name 'MDIOS_WKUP_IRQHandler';
procedure MDIOS_IRQHandler; external name 'MDIOS_IRQHandler';
procedure JPEG_IRQHandler; external name 'JPEG_IRQHandler';
procedure MDMA_IRQHandler; external name 'MDMA_IRQHandler';
procedure SDMMC2_IRQHandler; external name 'SDMMC2_IRQHandler';
procedure HSEM1_IRQHandler; external name 'HSEM1_IRQHandler';
procedure DAC2_IRQHandler; external name 'DAC2_IRQHandler';
procedure DMAMUX2_OVR_IRQHandler; external name 'DMAMUX2_OVR_IRQHandler';
procedure BDMA2_Channel0_IRQHandler; external name 'BDMA2_Channel0_IRQHandler';
procedure BDMA2_Channel1_IRQHandler; external name 'BDMA2_Channel1_IRQHandler';
procedure BDMA2_Channel2_IRQHandler; external name 'BDMA2_Channel2_IRQHandler';
procedure BDMA2_Channel3_IRQHandler; external name 'BDMA2_Channel3_IRQHandler';
procedure BDMA2_Channel4_IRQHandler; external name 'BDMA2_Channel4_IRQHandler';
procedure BDMA2_Channel5_IRQHandler; external name 'BDMA2_Channel5_IRQHandler';
procedure BDMA2_Channel6_IRQHandler; external name 'BDMA2_Channel6_IRQHandler';
procedure BDMA2_Channel7_IRQHandler; external name 'BDMA2_Channel7_IRQHandler';
procedure COMP_IRQHandler; external name 'COMP_IRQHandler';
procedure LPTIM2_IRQHandler; external name 'LPTIM2_IRQHandler';
procedure LPTIM3_IRQHandler; external name 'LPTIM3_IRQHandler';
procedure UART9_IRQHandler; external name 'UART9_IRQHandler';
procedure USART10_IRQHandler; external name 'USART10_IRQHandler';
procedure LPUART1_IRQHandler; external name 'LPUART1_IRQHandler';
procedure WWDG_RST_IRQHandler; external name 'WWDG_RST_IRQHandler';
procedure CRS_IRQHandler; external name 'CRS_IRQHandler';
procedure ECC_IRQHandler; external name 'ECC_IRQHandler';
procedure DTS_IRQHandler; external name 'DTS_IRQHandler';
procedure WAKEUP_PIN_IRQHandler; external name 'WAKEUP_PIN_IRQHandler';
procedure OCTOSPI2_IRQHandler; external name 'OCTOSPI2_IRQHandler';
procedure GFXMMU_IRQHandler; external name 'GFXMMU_IRQHandler';
procedure BDMA1_IRQHandler; external name 'BDMA1_IRQHandler';


{$i cortexm4f_start.inc}

procedure Vectors; assembler; nostackframe;
label interrupt_vectors;
asm
  .section ".init.interrupt_vectors"
  interrupt_vectors:
  .long _stack_top
  .long Startup
  .long NonMaskableInt_Handler
  .long HardFault_Handler
  .long MemoryManagement_Handler
  .long BusFault_Handler
  .long UsageFault_Handler
  .long 0
  .long 0
  .long 0
  .long 0
  .long SVCall_Handler
  .long DebugMonitor_Handler
  .long 0
  .long PendSV_Handler
  .long SysTick_Handler
  .long WWDG_IRQHandler
  .long PVD_PVM_IRQHandler
  .long RTC_TAMP_STAMP_CSS_LSE_IRQHandler
  .long RTC_WKUP_IRQHandler
  .long FLASH_IRQHandler
  .long RCC_IRQHandler
  .long EXTI0_IRQHandler
  .long EXTI1_IRQHandler
  .long EXTI2_IRQHandler
  .long EXTI3_IRQHandler
  .long EXTI4_IRQHandler
  .long DMA1_Stream0_IRQHandler
  .long DMA1_Stream1_IRQHandler
  .long DMA1_Stream2_IRQHandler
  .long DMA1_Stream3_IRQHandler
  .long DMA1_Stream4_IRQHandler
  .long DMA1_Stream5_IRQHandler
  .long DMA1_Stream6_IRQHandler
  .long ADC_IRQHandler
  .long FDCAN1_IT0_IRQHandler
  .long FDCAN2_IT0_IRQHandler
  .long FDCAN1_IT1_IRQHandler
  .long FDCAN2_IT1_IRQHandler
  .long EXTI9_5_IRQHandler
  .long TIM1_BRK_IRQHandler
  .long TIM1_UP_IRQHandler
  .long TIM1_TRG_COM_IRQHandler
  .long TIM1_CC_IRQHandler
  .long TIM2_IRQHandler
  .long TIM3_IRQHandler
  .long TIM4_IRQHandler
  .long I2C1_EV_IRQHandler
  .long I2C1_ER_IRQHandler
  .long I2C2_EV_IRQHandler
  .long I2C2_ER_IRQHandler
  .long SPI1_IRQHandler
  .long SPI2_IRQHandler
  .long USART1_IRQHandler
  .long USART2_IRQHandler
  .long USART3_IRQHandler
  .long EXTI15_10_IRQHandler
  .long RTC_Alarm_IRQHandler
  .long DFSDM2_IRQHandler
  .long TIM8_BRK_TIM12_IRQHandler
  .long TIM8_UP_TIM13_IRQHandler
  .long TIM8_TRG_COM_TIM14_IRQHandler
  .long TIM8_CC_IRQHandler
  .long DMA1_Stream7_IRQHandler
  .long FMC_IRQHandler
  .long SDMMC1_IRQHandler
  .long TIM5_IRQHandler
  .long SPI3_IRQHandler
  .long UART4_IRQHandler
  .long UART5_IRQHandler
  .long TIM6_DAC_IRQHandler
  .long TIM7_IRQHandler
  .long DMA2_Stream0_IRQHandler
  .long DMA2_Stream1_IRQHandler
  .long DMA2_Stream2_IRQHandler
  .long DMA2_Stream3_IRQHandler
  .long DMA2_Stream4_IRQHandler
  .long 0
  .long 0
  .long FDCAN_CAL_IRQHandler
  .long DFSDM1_FLT4_IRQHandler
  .long DFSDM1_FLT5_IRQHandler
  .long DFSDM1_FLT6_IRQHandler
  .long DFSDM1_FLT7_IRQHandler
  .long DMA2_Stream5_IRQHandler
  .long DMA2_Stream6_IRQHandler
  .long DMA2_Stream7_IRQHandler
  .long USART6_IRQHandler
  .long I2C3_EV_IRQHandler
  .long I2C3_ER_IRQHandler
  .long OTG_HS_EP1_OUT_IRQHandler
  .long OTG_HS_EP1_IN_IRQHandler
  .long OTG_HS_WKUP_IRQHandler
  .long OTG_HS_IRQHandler
  .long DCMI_PSSI_IRQHandler
  .long 0
  .long RNG_IRQHandler
  .long FPU_IRQHandler
  .long UART7_IRQHandler
  .long UART8_IRQHandler
  .long SPI4_IRQHandler
  .long SPI5_IRQHandler
  .long SPI6_IRQHandler
  .long SAI1_IRQHandler
  .long LTDC_IRQHandler
  .long LTDC_ER_IRQHandler
  .long DMA2D_IRQHandler
  .long SAI2_IRQHandler
  .long OCTOSPI1_IRQHandler
  .long LPTIM1_IRQHandler
  .long CEC_IRQHandler
  .long I2C4_EV_IRQHandler
  .long I2C4_ER_IRQHandler
  .long SPDIF_RX_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long DMAMUX1_OVR_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long DFSDM1_FLT0_IRQHandler
  .long DFSDM1_FLT1_IRQHandler
  .long DFSDM1_FLT2_IRQHandler
  .long DFSDM1_FLT3_IRQHandler
  .long 0
  .long SWPMI1_IRQHandler
  .long TIM15_IRQHandler
  .long TIM16_IRQHandler
  .long TIM17_IRQHandler
  .long MDIOS_WKUP_IRQHandler
  .long MDIOS_IRQHandler
  .long JPEG_IRQHandler
  .long MDMA_IRQHandler
  .long 0
  .long SDMMC2_IRQHandler
  .long HSEM1_IRQHandler
  .long 0
  .long DAC2_IRQHandler
  .long DMAMUX2_OVR_IRQHandler
  .long BDMA2_Channel0_IRQHandler
  .long BDMA2_Channel1_IRQHandler
  .long BDMA2_Channel2_IRQHandler
  .long BDMA2_Channel3_IRQHandler
  .long BDMA2_Channel4_IRQHandler
  .long BDMA2_Channel5_IRQHandler
  .long BDMA2_Channel6_IRQHandler
  .long BDMA2_Channel7_IRQHandler
  .long COMP_IRQHandler
  .long LPTIM2_IRQHandler
  .long LPTIM3_IRQHandler
  .long UART9_IRQHandler
  .long USART10_IRQHandler
  .long LPUART1_IRQHandler
  .long WWDG_RST_IRQHandler
  .long CRS_IRQHandler
  .long ECC_IRQHandler
  .long 0
  .long DTS_IRQHandler
  .long 0
  .long WAKEUP_PIN_IRQHandler
  .long OCTOSPI2_IRQHandler
  .long 0
  .long 0
  .long GFXMMU_IRQHandler
  .long BDMA1_IRQHandler

  .weak NonMaskableInt_Handler
  .weak HardFault_Handler
  .weak MemoryManagement_Handler
  .weak BusFault_Handler
  .weak UsageFault_Handler
  .weak SVCall_Handler
  .weak DebugMonitor_Handler
  .weak PendSV_Handler
  .weak SysTick_Handler
  .weak WWDG_IRQHandler
  .weak PVD_PVM_IRQHandler
  .weak RTC_TAMP_STAMP_CSS_LSE_IRQHandler
  .weak RTC_WKUP_IRQHandler
  .weak FLASH_IRQHandler
  .weak RCC_IRQHandler
  .weak EXTI0_IRQHandler
  .weak EXTI1_IRQHandler
  .weak EXTI2_IRQHandler
  .weak EXTI3_IRQHandler
  .weak EXTI4_IRQHandler
  .weak DMA1_Stream0_IRQHandler
  .weak DMA1_Stream1_IRQHandler
  .weak DMA1_Stream2_IRQHandler
  .weak DMA1_Stream3_IRQHandler
  .weak DMA1_Stream4_IRQHandler
  .weak DMA1_Stream5_IRQHandler
  .weak DMA1_Stream6_IRQHandler
  .weak ADC_IRQHandler
  .weak FDCAN1_IT0_IRQHandler
  .weak FDCAN2_IT0_IRQHandler
  .weak FDCAN1_IT1_IRQHandler
  .weak FDCAN2_IT1_IRQHandler
  .weak EXTI9_5_IRQHandler
  .weak TIM1_BRK_IRQHandler
  .weak TIM1_UP_IRQHandler
  .weak TIM1_TRG_COM_IRQHandler
  .weak TIM1_CC_IRQHandler
  .weak TIM2_IRQHandler
  .weak TIM3_IRQHandler
  .weak TIM4_IRQHandler
  .weak I2C1_EV_IRQHandler
  .weak I2C1_ER_IRQHandler
  .weak I2C2_EV_IRQHandler
  .weak I2C2_ER_IRQHandler
  .weak SPI1_IRQHandler
  .weak SPI2_IRQHandler
  .weak USART1_IRQHandler
  .weak USART2_IRQHandler
  .weak USART3_IRQHandler
  .weak EXTI15_10_IRQHandler
  .weak RTC_Alarm_IRQHandler
  .weak DFSDM2_IRQHandler
  .weak TIM8_BRK_TIM12_IRQHandler
  .weak TIM8_UP_TIM13_IRQHandler
  .weak TIM8_TRG_COM_TIM14_IRQHandler
  .weak TIM8_CC_IRQHandler
  .weak DMA1_Stream7_IRQHandler
  .weak FMC_IRQHandler
  .weak SDMMC1_IRQHandler
  .weak TIM5_IRQHandler
  .weak SPI3_IRQHandler
  .weak UART4_IRQHandler
  .weak UART5_IRQHandler
  .weak TIM6_DAC_IRQHandler
  .weak TIM7_IRQHandler
  .weak DMA2_Stream0_IRQHandler
  .weak DMA2_Stream1_IRQHandler
  .weak DMA2_Stream2_IRQHandler
  .weak DMA2_Stream3_IRQHandler
  .weak DMA2_Stream4_IRQHandler
  .weak FDCAN_CAL_IRQHandler
  .weak DFSDM1_FLT4_IRQHandler
  .weak DFSDM1_FLT5_IRQHandler
  .weak DFSDM1_FLT6_IRQHandler
  .weak DFSDM1_FLT7_IRQHandler
  .weak DMA2_Stream5_IRQHandler
  .weak DMA2_Stream6_IRQHandler
  .weak DMA2_Stream7_IRQHandler
  .weak USART6_IRQHandler
  .weak I2C3_EV_IRQHandler
  .weak I2C3_ER_IRQHandler
  .weak OTG_HS_EP1_OUT_IRQHandler
  .weak OTG_HS_EP1_IN_IRQHandler
  .weak OTG_HS_WKUP_IRQHandler
  .weak OTG_HS_IRQHandler
  .weak DCMI_PSSI_IRQHandler
  .weak RNG_IRQHandler
  .weak FPU_IRQHandler
  .weak UART7_IRQHandler
  .weak UART8_IRQHandler
  .weak SPI4_IRQHandler
  .weak SPI5_IRQHandler
  .weak SPI6_IRQHandler
  .weak SAI1_IRQHandler
  .weak LTDC_IRQHandler
  .weak LTDC_ER_IRQHandler
  .weak DMA2D_IRQHandler
  .weak SAI2_IRQHandler
  .weak OCTOSPI1_IRQHandler
  .weak LPTIM1_IRQHandler
  .weak CEC_IRQHandler
  .weak I2C4_EV_IRQHandler
  .weak I2C4_ER_IRQHandler
  .weak SPDIF_RX_IRQHandler
  .weak DMAMUX1_OVR_IRQHandler
  .weak DFSDM1_FLT0_IRQHandler
  .weak DFSDM1_FLT1_IRQHandler
  .weak DFSDM1_FLT2_IRQHandler
  .weak DFSDM1_FLT3_IRQHandler
  .weak SWPMI1_IRQHandler
  .weak TIM15_IRQHandler
  .weak TIM16_IRQHandler
  .weak TIM17_IRQHandler
  .weak MDIOS_WKUP_IRQHandler
  .weak MDIOS_IRQHandler
  .weak JPEG_IRQHandler
  .weak MDMA_IRQHandler
  .weak SDMMC2_IRQHandler
  .weak HSEM1_IRQHandler
  .weak DAC2_IRQHandler
  .weak DMAMUX2_OVR_IRQHandler
  .weak BDMA2_Channel0_IRQHandler
  .weak BDMA2_Channel1_IRQHandler
  .weak BDMA2_Channel2_IRQHandler
  .weak BDMA2_Channel3_IRQHandler
  .weak BDMA2_Channel4_IRQHandler
  .weak BDMA2_Channel5_IRQHandler
  .weak BDMA2_Channel6_IRQHandler
  .weak BDMA2_Channel7_IRQHandler
  .weak COMP_IRQHandler
  .weak LPTIM2_IRQHandler
  .weak LPTIM3_IRQHandler
  .weak UART9_IRQHandler
  .weak USART10_IRQHandler
  .weak LPUART1_IRQHandler
  .weak WWDG_RST_IRQHandler
  .weak CRS_IRQHandler
  .weak ECC_IRQHandler
  .weak DTS_IRQHandler
  .weak WAKEUP_PIN_IRQHandler
  .weak OCTOSPI2_IRQHandler
  .weak GFXMMU_IRQHandler
  .weak BDMA1_IRQHandler

  .set NonMaskableInt_Handler, _NonMaskableInt_Handler
  .set HardFault_Handler, _HardFault_Handler
  .set MemoryManagement_Handler, _MemoryManagement_Handler
  .set BusFault_Handler, _BusFault_Handler
  .set UsageFault_Handler, _UsageFault_Handler
  .set SVCall_Handler, _SVCall_Handler
  .set DebugMonitor_Handler, _DebugMonitor_Handler
  .set PendSV_Handler, _PendSV_Handler
  .set SysTick_Handler, _SysTick_Handler
  .set WWDG_IRQHandler, Haltproc
  .set PVD_PVM_IRQHandler, Haltproc
  .set RTC_TAMP_STAMP_CSS_LSE_IRQHandler, Haltproc
  .set RTC_WKUP_IRQHandler, Haltproc
  .set FLASH_IRQHandler, Haltproc
  .set RCC_IRQHandler, Haltproc
  .set EXTI0_IRQHandler, Haltproc
  .set EXTI1_IRQHandler, Haltproc
  .set EXTI2_IRQHandler, Haltproc
  .set EXTI3_IRQHandler, Haltproc
  .set EXTI4_IRQHandler, Haltproc
  .set DMA1_Stream0_IRQHandler, Haltproc
  .set DMA1_Stream1_IRQHandler, Haltproc
  .set DMA1_Stream2_IRQHandler, Haltproc
  .set DMA1_Stream3_IRQHandler, Haltproc
  .set DMA1_Stream4_IRQHandler, Haltproc
  .set DMA1_Stream5_IRQHandler, Haltproc
  .set DMA1_Stream6_IRQHandler, Haltproc
  .set ADC_IRQHandler, Haltproc
  .set FDCAN1_IT0_IRQHandler, Haltproc
  .set FDCAN2_IT0_IRQHandler, Haltproc
  .set FDCAN1_IT1_IRQHandler, Haltproc
  .set FDCAN2_IT1_IRQHandler, Haltproc
  .set EXTI9_5_IRQHandler, Haltproc
  .set TIM1_BRK_IRQHandler, Haltproc
  .set TIM1_UP_IRQHandler, Haltproc
  .set TIM1_TRG_COM_IRQHandler, Haltproc
  .set TIM1_CC_IRQHandler, Haltproc
  .set TIM2_IRQHandler, Haltproc
  .set TIM3_IRQHandler, Haltproc
  .set TIM4_IRQHandler, Haltproc
  .set I2C1_EV_IRQHandler, Haltproc
  .set I2C1_ER_IRQHandler, Haltproc
  .set I2C2_EV_IRQHandler, Haltproc
  .set I2C2_ER_IRQHandler, Haltproc
  .set SPI1_IRQHandler, Haltproc
  .set SPI2_IRQHandler, Haltproc
  .set USART1_IRQHandler, Haltproc
  .set USART2_IRQHandler, Haltproc
  .set USART3_IRQHandler, Haltproc
  .set EXTI15_10_IRQHandler, Haltproc
  .set RTC_Alarm_IRQHandler, Haltproc
  .set DFSDM2_IRQHandler, Haltproc
  .set TIM8_BRK_TIM12_IRQHandler, Haltproc
  .set TIM8_UP_TIM13_IRQHandler, Haltproc
  .set TIM8_TRG_COM_TIM14_IRQHandler, Haltproc
  .set TIM8_CC_IRQHandler, Haltproc
  .set DMA1_Stream7_IRQHandler, Haltproc
  .set FMC_IRQHandler, Haltproc
  .set SDMMC1_IRQHandler, Haltproc
  .set TIM5_IRQHandler, Haltproc
  .set SPI3_IRQHandler, Haltproc
  .set UART4_IRQHandler, Haltproc
  .set UART5_IRQHandler, Haltproc
  .set TIM6_DAC_IRQHandler, Haltproc
  .set TIM7_IRQHandler, Haltproc
  .set DMA2_Stream0_IRQHandler, Haltproc
  .set DMA2_Stream1_IRQHandler, Haltproc
  .set DMA2_Stream2_IRQHandler, Haltproc
  .set DMA2_Stream3_IRQHandler, Haltproc
  .set DMA2_Stream4_IRQHandler, Haltproc
  .set FDCAN_CAL_IRQHandler, Haltproc
  .set DFSDM1_FLT4_IRQHandler, Haltproc
  .set DFSDM1_FLT5_IRQHandler, Haltproc
  .set DFSDM1_FLT6_IRQHandler, Haltproc
  .set DFSDM1_FLT7_IRQHandler, Haltproc
  .set DMA2_Stream5_IRQHandler, Haltproc
  .set DMA2_Stream6_IRQHandler, Haltproc
  .set DMA2_Stream7_IRQHandler, Haltproc
  .set USART6_IRQHandler, Haltproc
  .set I2C3_EV_IRQHandler, Haltproc
  .set I2C3_ER_IRQHandler, Haltproc
  .set OTG_HS_EP1_OUT_IRQHandler, Haltproc
  .set OTG_HS_EP1_IN_IRQHandler, Haltproc
  .set OTG_HS_WKUP_IRQHandler, Haltproc
  .set OTG_HS_IRQHandler, Haltproc
  .set DCMI_PSSI_IRQHandler, Haltproc
  .set RNG_IRQHandler, Haltproc
  .set FPU_IRQHandler, Haltproc
  .set UART7_IRQHandler, Haltproc
  .set UART8_IRQHandler, Haltproc
  .set SPI4_IRQHandler, Haltproc
  .set SPI5_IRQHandler, Haltproc
  .set SPI6_IRQHandler, Haltproc
  .set SAI1_IRQHandler, Haltproc
  .set LTDC_IRQHandler, Haltproc
  .set LTDC_ER_IRQHandler, Haltproc
  .set DMA2D_IRQHandler, Haltproc
  .set SAI2_IRQHandler, Haltproc
  .set OCTOSPI1_IRQHandler, Haltproc
  .set LPTIM1_IRQHandler, Haltproc
  .set CEC_IRQHandler, Haltproc
  .set I2C4_EV_IRQHandler, Haltproc
  .set I2C4_ER_IRQHandler, Haltproc
  .set SPDIF_RX_IRQHandler, Haltproc
  .set DMAMUX1_OVR_IRQHandler, Haltproc
  .set DFSDM1_FLT0_IRQHandler, Haltproc
  .set DFSDM1_FLT1_IRQHandler, Haltproc
  .set DFSDM1_FLT2_IRQHandler, Haltproc
  .set DFSDM1_FLT3_IRQHandler, Haltproc
  .set SWPMI1_IRQHandler, Haltproc
  .set TIM15_IRQHandler, Haltproc
  .set TIM16_IRQHandler, Haltproc
  .set TIM17_IRQHandler, Haltproc
  .set MDIOS_WKUP_IRQHandler, Haltproc
  .set MDIOS_IRQHandler, Haltproc
  .set JPEG_IRQHandler, Haltproc
  .set MDMA_IRQHandler, Haltproc
  .set SDMMC2_IRQHandler, Haltproc
  .set HSEM1_IRQHandler, Haltproc
  .set DAC2_IRQHandler, Haltproc
  .set DMAMUX2_OVR_IRQHandler, Haltproc
  .set BDMA2_Channel0_IRQHandler, Haltproc
  .set BDMA2_Channel1_IRQHandler, Haltproc
  .set BDMA2_Channel2_IRQHandler, Haltproc
  .set BDMA2_Channel3_IRQHandler, Haltproc
  .set BDMA2_Channel4_IRQHandler, Haltproc
  .set BDMA2_Channel5_IRQHandler, Haltproc
  .set BDMA2_Channel6_IRQHandler, Haltproc
  .set BDMA2_Channel7_IRQHandler, Haltproc
  .set COMP_IRQHandler, Haltproc
  .set LPTIM2_IRQHandler, Haltproc
  .set LPTIM3_IRQHandler, Haltproc
  .set UART9_IRQHandler, Haltproc
  .set USART10_IRQHandler, Haltproc
  .set LPUART1_IRQHandler, Haltproc
  .set WWDG_RST_IRQHandler, Haltproc
  .set CRS_IRQHandler, Haltproc
  .set ECC_IRQHandler, Haltproc
  .set DTS_IRQHandler, Haltproc
  .set WAKEUP_PIN_IRQHandler, Haltproc
  .set OCTOSPI2_IRQHandler, Haltproc
  .set GFXMMU_IRQHandler, Haltproc
  .set BDMA1_IRQHandler, Haltproc

  .text
  end;
end.
