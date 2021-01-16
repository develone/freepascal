unit stm32wb5mxx;
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
    TAMP_STAMP_LSECSS_IRQn = 2,       
    RTC_WKUP_IRQn = 3,                
    FLASH_IRQn  = 4,                  
    RCC_IRQn    = 5,                  
    EXTI0_IRQn  = 6,                  
    EXTI1_IRQn  = 7,                  
    EXTI2_IRQn  = 8,                  
    EXTI3_IRQn  = 9,                  
    EXTI4_IRQn  = 10,                 
    DMA1_Channel1_IRQn = 11,          
    DMA1_Channel2_IRQn = 12,          
    DMA1_Channel3_IRQn = 13,          
    DMA1_Channel4_IRQn = 14,          
    DMA1_Channel5_IRQn = 15,          
    DMA1_Channel6_IRQn = 16,          
    DMA1_Channel7_IRQn = 17,          
    ADC1_IRQn   = 18,                 
    USB_HP_IRQn = 19,                 
    USB_LP_IRQn = 20,                 
    C2SEV_PWR_C2H_IRQn = 21,          
    COMP_IRQn   = 22,                 
    EXTI9_5_IRQn = 23,                
    TIM1_BRK_IRQn = 24,               
    TIM1_UP_TIM16_IRQn = 25,          
    TIM1_TRG_COM_TIM17_IRQn = 26,     
    TIM1_CC_IRQn = 27,                
    TIM2_IRQn   = 28,                 
    PKA_IRQn    = 29,                 
    I2C1_EV_IRQn = 30,                
    I2C1_ER_IRQn = 31,                
    I2C3_EV_IRQn = 32,                
    I2C3_ER_IRQn = 33,                
    SPI1_IRQn   = 34,                 
    SPI2_IRQn   = 35,                 
    USART1_IRQn = 36,                 
    LPUART1_IRQn = 37,                
    SAI1_IRQn   = 38,                 
    TSC_IRQn    = 39,                 
    EXTI15_10_IRQn = 40,              
    RTC_Alarm_IRQn = 41,              
    CRS_IRQn    = 42,                 
    PWR_SOTF_BLEACT_802ACT_RFPHASE_IRQn = 43,
    IPCC_C1_RX_IRQn = 44,             
    IPCC_C1_TX_IRQn = 45,             
    HSEM_IRQn   = 46,                 
    LPTIM1_IRQn = 47,                 
    LPTIM2_IRQn = 48,                 
    LCD_IRQn    = 49,                 
    QUADSPI_IRQn = 50,                
    AES1_IRQn   = 51,                 
    AES2_IRQn   = 52,                 
    RNG_IRQn    = 53,                 
    FPU_IRQn    = 54,                 
    DMA2_Channel1_IRQn = 55,          
    DMA2_Channel2_IRQn = 56,          
    DMA2_Channel3_IRQn = 57,          
    DMA2_Channel4_IRQn = 58,          
    DMA2_Channel5_IRQn = 59,          
    DMA2_Channel6_IRQn = 60,          
    DMA2_Channel7_IRQn = 61,          
    DMAMUX1_OVR_IRQn = 62             
  );

  TADC_Registers = record
    ISR         : longword;
    IER         : longword;
    CR          : longword;
    CFGR        : longword;
    CFGR2       : longword;
    SMPR1       : longword;
    SMPR2       : longword;
    RESERVED1   : longword;
    TR1         : longword;
    TR2         : longword;
    TR3         : longword;
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
    DIFSEL      : longword;
    CALFACT     : longword;
  end;

  TADC_Common_Registers = record
    RESERVED1   : longword;
    RESERVED2   : longword;
    CCR         : longword;
    RESERVED3   : longword;
  end;

  TCOMP_Registers = record
    CSR         : longword;
  end;

  TCOMP_Common_Registers = record
    CSR         : longword;
  end;

  TCRC_Registers = record
    DR          : longword;
    IDR         : longword;
    CR          : longword;
    RESERVED2   : longword;
    INIT        : longword;
    POL         : longword;
  end;

  TDBGMCU_Registers = record
    IDCODE      : longword;
    CR          : longword;
    RESERVED1   : array[0..12] of longword;
    APB1FZR1    : longword;
    C2APB1FZR1  : longword;
    APB1FZR2    : longword;
    C2APB1FZR2  : longword;
    APB2FZR     : longword;
    C2APB2FZR   : longword;
  end;

  TDMA_Channel_Registers = record
    CCR         : longword;
    CNDTR       : longword;
    CPAR        : longword;
    CMAR        : longword;
    RESERVED    : longword;
  end;

  TDMA_Registers = record
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

  TFLASH_Registers = record
    ACR         : longword;
    RESERVED    : longword;
    KEYR        : longword;
    OPTKEYR     : longword;
    SR          : longword;
    CR          : longword;
    ECCR        : longword;
    RESERVED1   : longword;
    OPTR        : longword;
    PCROP1ASR   : longword;
    PCROP1AER   : longword;
    WRP1AR      : longword;
    WRP1BR      : longword;
    PCROP1BSR   : longword;
    PCROP1BER   : longword;
    IPCCBR      : longword;
    RESERVED2   : array[0..6] of longword;
    C2ACR       : longword;
    C2SR        : longword;
    C2CR        : longword;
    RESERVED3   : array[0..5] of longword;
    SFR         : longword;
    SRRVR       : longword;
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
    BRR         : longword;
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

  TLPTIM_Registers = record
    ISR         : longword;
    ICR         : longword;
    IER         : longword;
    CFGR        : longword;
    CR          : longword;
    CMP         : longword;
    ARR         : longword;
    CNT         : longword;
    &OR         : longword;
  end;

  TPWR_Registers = record
    CR1         : longword;
    CR2         : longword;
    CR3         : longword;
    CR4         : longword;
    SR1         : longword;
    SR2         : longword;
    SCR         : longword;
    CR5         : longword;
    PUCRA       : longword;
    PDCRA       : longword;
    PUCRB       : longword;
    PDCRB       : longword;
    PUCRC       : longword;
    PDCRC       : longword;
    PUCRD       : longword;
    PDCRD       : longword;
    PUCRE       : longword;
    PDCRE       : longword;
    RESERVED0   : array[0..3] of longword;
    PUCRH       : longword;
    PDCRH       : longword;
    RESERVED1   : array[0..7] of longword;
    C2CR1       : longword;
    C2CR3       : longword;
    EXTSCR      : longword;
  end;

  TQUADSPI_Registers = record
    CR          : longword;
    DCR         : longword;
    SR          : longword;
    FCR         : longword;
    DLR         : longword;
    CCR         : longword;
    AR          : longword;
    ABR         : longword;
    DR          : longword;
    PSMKR       : longword;
    PSMAR       : longword;
    PIR         : longword;
    LPTR        : longword;
  end;

  TRCC_Registers = record
    CR          : longword;
    ICSCR       : longword;
    CFGR        : longword;
    PLLCFGR     : longword;
    PLLSAI1CFGR : longword;
    RESERVED0   : longword;
    CIER        : longword;
    CIFR        : longword;
    CICR        : longword;
    SMPSCR      : longword;
    AHB1RSTR    : longword;
    AHB2RSTR    : longword;
    AHB3RSTR    : longword;
    RESERVED1   : longword;
    APB1RSTR1   : longword;
    APB1RSTR2   : longword;
    APB2RSTR    : longword;
    APB3RSTR    : longword;
    AHB1ENR     : longword;
    AHB2ENR     : longword;
    AHB3ENR     : longword;
    RESERVED2   : longword;
    APB1ENR1    : longword;
    APB1ENR2    : longword;
    APB2ENR     : longword;
    RESERVED3   : longword;
    AHB1SMENR   : longword;
    AHB2SMENR   : longword;
    AHB3SMENR   : longword;
    RESERVED4   : longword;
    APB1SMENR1  : longword;
    APB1SMENR2  : longword;
    APB2SMENR   : longword;
    RESERVED5   : longword;
    CCIPR       : longword;
    RESERVED6   : longword;
    BDCR        : longword;
    CSR         : longword;
    CRRCR       : longword;
    HSECR       : longword;
    RESERVED7   : array[0..25] of longword;
    EXTCFGR     : longword;
    RESERVED8   : array[0..14] of longword;
    C2AHB1ENR   : longword;
    C2AHB2ENR   : longword;
    C2AHB3ENR   : longword;
    RESERVED9   : longword;
    C2APB1ENR1  : longword;
    C2APB1ENR2  : longword;
    C2APB2ENR   : longword;
    C2APB3ENR   : longword;
    C2AHB1SMENR : longword;
    C2AHB2SMENR : longword;
    C2AHB3SMENR : longword;
    RESERVED10  : longword;
    C2APB1SMENR1 : longword;
    C2APB1SMENR2 : longword;
    C2APB2SMENR : longword;
    C2APB3SMENR : longword;
  end;

  TRTC_Registers = record
    TR          : longword;
    DR          : longword;
    CR          : longword;
    ISR         : longword;
    PRER        : longword;
    WUTR        : longword;
    RESERVED    : longword;
    ALRMAR      : longword;
    ALRMBR      : longword;
    WPR         : longword;
    SSR         : longword;
    SHIFTR      : longword;
    TSTR        : longword;
    TSDR        : longword;
    TSSSR       : longword;
    CALR        : longword;
    TAMPCR      : longword;
    ALRMASSR    : longword;
    ALRMBSSR    : longword;
    &OR         : longword;
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
  end;

  TSPI_Registers = record
    CR1         : longword;
    CR2         : longword;
    SR          : longword;
    DR          : longword;
    CRCPR       : longword;
    RXCRCR      : longword;
    TXCRCR      : longword;
  end;

  TSYSCFG_Registers = record
    MEMRMP      : longword;
    CFGR1       : longword;
    EXTICR      : array[0..3] of longword;
    SCSR        : longword;
    CFGR2       : longword;
    SWPR1       : longword;
    SKR         : longword;
    SWPR2       : longword;
    RESERVED1   : array[0..52] of longword;
    IMR1        : longword;
    IMR2        : longword;
    C2IMR1      : longword;
    C2IMR2      : longword;
    SIPCR       : longword;
  end;

  TVREFBUF_Registers = record
    CSR         : longword;
    CCR         : longword;
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
    &OR         : longword;
    CCMR3       : longword;
    CCR5        : longword;
    CCR6        : longword;
    AF1         : longword;
    AF2         : longword;
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

  TWWDG_Registers = record
    CR          : longword;
    CFR         : longword;
    SR          : longword;
  end;

  TAES_Registers = record
    CR          : longword;
    SR          : longword;
    DINR        : longword;
    DOUTR       : longword;
    KEYR0       : longword;
    KEYR1       : longword;
    KEYR2       : longword;
    KEYR3       : longword;
    IVR0        : longword;
    IVR1        : longword;
    IVR2        : longword;
    IVR3        : longword;
    KEYR4       : longword;
    KEYR5       : longword;
    KEYR6       : longword;
    KEYR7       : longword;
    SUSP0R      : longword;
    SUSP1R      : longword;
    SUSP2R      : longword;
    SUSP3R      : longword;
    SUSP4R      : longword;
    SUSP5R      : longword;
    SUSP6R      : longword;
    SUSP7R      : longword;
  end;

  TRNG_Registers = record
    CR          : longword;
    SR          : longword;
    DR          : longword;
  end;

  TTSC_Registers = record
    CR          : longword;
    IER         : longword;
    ICR         : longword;
    ISR         : longword;
    IOHCR       : longword;
    RESERVED1   : longword;
    IOASCR      : longword;
    RESERVED2   : longword;
    IOSCR       : longword;
    RESERVED3   : longword;
    IOCCR       : longword;
    RESERVED4   : longword;
    IOGCSR      : longword;
    IOGXCR      : array[0..6] of longword;
  end;

  TLCD_Registers = record
    CR          : longword;
    FCR         : longword;
    SR          : longword;
    CLR         : longword;
    RESERVED    : longword;
    RAM         : array[0..15] of longword;
  end;

  TUSB_Registers = record
    EP0R        : word;
    RESERVED0   : word;
    EP1R        : word;
    RESERVED1   : word;
    EP2R        : word;
    RESERVED2   : word;
    EP3R        : word;
    RESERVED3   : word;
    EP4R        : word;
    RESERVED4   : word;
    EP5R        : word;
    RESERVED5   : word;
    EP6R        : word;
    RESERVED6   : word;
    EP7R        : word;
    RESERVED7   : array[0..16] of word;
    CNTR        : word;
    RESERVED8   : word;
    ISTR        : word;
    RESERVED9   : word;
    FNR         : word;
    RESERVEDA   : word;
    DADDR       : word;
    RESERVEDB   : word;
    BTABLE      : word;
    RESERVEDC   : word;
    LPMCSR      : word;
    RESERVEDD   : word;
    BCDR        : word;
    RESERVEDE   : word;
  end;

  TCRS_Registers = record
    CR          : longword;
    CFGR        : longword;
    ISR         : longword;
    ICR         : longword;
  end;

  TIPCC_Registers = record
    C1CR        : longword;
    C1MR        : longword;
    C1SCR       : longword;
    C1TOC2SR    : longword;
    C2CR        : longword;
    C2MR        : longword;
    C2SCR       : longword;
    C2TOC1SR    : longword;
  end;

  TIPCC_Common_Registers = record
    CR          : longword;
    MR          : longword;
    SCR         : longword;
    SR          : longword;
  end;

  TEXTI_Registers = record
    RTSR1       : longword;
    FTSR1       : longword;
    SWIER1      : longword;
    PR1         : longword;
    RESERVED1   : array[0..3] of longword;
    RTSR2       : longword;
    FTSR2       : longword;
    SWIER2      : longword;
    PR2         : longword;
    RESERVED2   : array[0..3] of longword;
    RESERVED3   : array[0..7] of longword;
    RESERVED4   : array[0..7] of longword;
    IMR1        : longword;
    EMR1        : longword;
    RESERVED5   : array[0..1] of longword;
    IMR2        : longword;
    EMR2        : longword;
    RESERVED8   : array[0..9] of longword;
    C2IMR1      : longword;
    C2EMR1      : longword;
    RESERVED9   : array[0..1] of longword;
    C2IMR2      : longword;
    C2EMR2      : longword;
  end;

  TSAI_Registers = record
    GCR         : longword;
    RESERVED    : array[0..15] of longword;
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

  TPKA_Registers = record
    CR          : longword;
    SR          : longword;
    CLRFR       : longword;
    Reserved1   : array[0..252] of longword;
    RAM         : array[0..893] of longword;
  end;

  THSEM_Registers = record
    R           : array[0..31] of longword;
    RLR         : array[0..31] of longword;
    C1IER       : longword;
    C1ICR       : longword;
    C1ISR       : longword;
    C1MISR      : longword;
    C2IER       : longword;
    C2ICR       : longword;
    C2ISR       : longword;
    C2MISR      : longword;
    Reserved    : array[0..7] of longword;
    CR          : longword;
    KEYR        : longword;
  end;

  THSEM_Common_Registers = record
    IER         : longword;
    ICR         : longword;
    ISR         : longword;
    MISR        : longword;
  end;

const
  __NVIC_PRIO_BITS= 4;
  FLASH_BASE    = $08000000;
  SRAM_BASE     = $20000000;
  PERIPH_BASE   = $40000000;
  SYSTEM_MEMORY_BASE= $1FFF0000;
  OTP_AREA_BASE = $1FFF7000;
  OPTION_BYTE_BASE= $1FFF8000;
  ENGI_BYTE_BASE= $1FFF7400;
  SRAM1_BASE    = SRAM_BASE;
  SRAM2A_BASE   = SRAM_BASE + $00030000;
  SRAM2B_BASE   = SRAM_BASE + $00038000;
  APB1PERIPH_BASE= PERIPH_BASE;
  APB2PERIPH_BASE= PERIPH_BASE + $00010000;
  AHB1PERIPH_BASE= PERIPH_BASE + $00020000;
  AHB2PERIPH_BASE= PERIPH_BASE + $08000000;
  AHB4PERIPH_BASE= PERIPH_BASE + $18000000;
  APB3PERIPH_BASE= PERIPH_BASE + $20000000;
  AHB3PERIPH_BASE= PERIPH_BASE + $50000000;
  TIM2_BASE     = APB1PERIPH_BASE + $00000000;
  LCD_BASE      = APB1PERIPH_BASE + $00002400;
  RTC_BASE      = APB1PERIPH_BASE + $00002800;
  WWDG_BASE     = APB1PERIPH_BASE + $00002C00;
  IWDG_BASE     = APB1PERIPH_BASE + $00003000;
  SPI2_BASE     = APB1PERIPH_BASE + $00003800;
  I2C1_BASE     = APB1PERIPH_BASE + $00005400;
  I2C3_BASE     = APB1PERIPH_BASE + $00005C00;
  CRS_BASE      = APB1PERIPH_BASE + $00006000;
  USB1_BASE     = APB1PERIPH_BASE + $00006800;
  LPTIM1_BASE   = APB1PERIPH_BASE + $00007C00;
  LPUART1_BASE  = APB1PERIPH_BASE + $00008000;
  LPTIM2_BASE   = APB1PERIPH_BASE + $00009400;
  SYSCFG_BASE   = APB2PERIPH_BASE + $00000000;
  VREFBUF_BASE  = APB2PERIPH_BASE + $00000030;
  COMP1_BASE    = APB2PERIPH_BASE + $00000200;
  COMP2_BASE    = APB2PERIPH_BASE + $00000204;
  TIM1_BASE     = APB2PERIPH_BASE + $00002C00;
  SPI1_BASE     = APB2PERIPH_BASE + $00003000;
  USART1_BASE   = APB2PERIPH_BASE + $00003800;
  TIM16_BASE    = APB2PERIPH_BASE + $00004400;
  TIM17_BASE    = APB2PERIPH_BASE + $00004800;
  SAI1_BASE     = APB2PERIPH_BASE + $00005400;
  SAI1_Block_A_BASE= SAI1_BASE + $0000004;
  SAI1_Block_B_BASE= SAI1_BASE + $0000024;
  DMA1_BASE     = AHB1PERIPH_BASE + $00000000;
  DMA2_BASE     = AHB1PERIPH_BASE + $00000400;
  DMAMUX1_BASE  = AHB1PERIPH_BASE + $00000800;
  CRC_BASE      = AHB1PERIPH_BASE + $00003000;
  TSC_BASE      = AHB1PERIPH_BASE + $00004000;
  DMA1_Channel1_BASE= DMA1_BASE + $00000008;
  DMA1_Channel2_BASE= DMA1_BASE + $0000001C;
  DMA1_Channel3_BASE= DMA1_BASE + $00000030;
  DMA1_Channel4_BASE= DMA1_BASE + $00000044;
  DMA1_Channel5_BASE= DMA1_BASE + $00000058;
  DMA1_Channel6_BASE= DMA1_BASE + $0000006C;
  DMA1_Channel7_BASE= DMA1_BASE + $00000080;
  DMA2_Channel1_BASE= DMA2_BASE + $00000008;
  DMA2_Channel2_BASE= DMA2_BASE + $0000001C;
  DMA2_Channel3_BASE= DMA2_BASE + $00000030;
  DMA2_Channel4_BASE= DMA2_BASE + $00000044;
  DMA2_Channel5_BASE= DMA2_BASE + $00000058;
  DMA2_Channel6_BASE= DMA2_BASE + $0000006C;
  DMA2_Channel7_BASE= DMA2_BASE + $00000080;
  DMAMUX1_Channel0_BASE= DMAMUX1_BASE;
  DMAMUX1_Channel1_BASE= DMAMUX1_BASE + $00000004;
  DMAMUX1_Channel2_BASE= DMAMUX1_BASE + $00000008;
  DMAMUX1_Channel3_BASE= DMAMUX1_BASE + $0000000C;
  DMAMUX1_Channel4_BASE= DMAMUX1_BASE + $00000010;
  DMAMUX1_Channel5_BASE= DMAMUX1_BASE + $00000014;
  DMAMUX1_Channel6_BASE= DMAMUX1_BASE + $00000018;
  DMAMUX1_Channel7_BASE= DMAMUX1_BASE + $0000001C;
  DMAMUX1_Channel8_BASE= DMAMUX1_BASE + $00000020;
  DMAMUX1_Channel9_BASE= DMAMUX1_BASE + $00000024;
  DMAMUX1_Channel10_BASE= DMAMUX1_BASE + $00000028;
  DMAMUX1_Channel11_BASE= DMAMUX1_BASE + $0000002C;
  DMAMUX1_Channel12_BASE= DMAMUX1_BASE + $00000030;
  DMAMUX1_Channel13_BASE= DMAMUX1_BASE + $00000034;
  DMAMUX1_RequestGenerator0_BASE= DMAMUX1_BASE + $00000100;
  DMAMUX1_RequestGenerator1_BASE= DMAMUX1_BASE + $00000104;
  DMAMUX1_RequestGenerator2_BASE= DMAMUX1_BASE + $00000108;
  DMAMUX1_RequestGenerator3_BASE= DMAMUX1_BASE + $0000010C;
  DMAMUX1_ChannelStatus_BASE= DMAMUX1_BASE + $00000080;
  DMAMUX1_RequestGenStatus_BASE= DMAMUX1_BASE + $00000140;
  IOPORT_BASE   = AHB2PERIPH_BASE + $00000000;
  GPIOA_BASE    = IOPORT_BASE + $00000000;
  GPIOB_BASE    = IOPORT_BASE + $00000400;
  GPIOC_BASE    = IOPORT_BASE + $00000800;
  GPIOD_BASE    = IOPORT_BASE + $00000C00;
  GPIOE_BASE    = IOPORT_BASE + $00001000;
  GPIOH_BASE    = IOPORT_BASE + $00001C00;
  ADC1_BASE     = AHB2PERIPH_BASE + $08040000;
  ADC1_COMMON_BASE= AHB2PERIPH_BASE + $08040300;
  AES1_BASE     = AHB2PERIPH_BASE + $08060000;
  RCC_BASE      = AHB4PERIPH_BASE + $00000000;
  PWR_BASE      = AHB4PERIPH_BASE + $00000400;
  EXTI_BASE     = AHB4PERIPH_BASE + $00000800;
  IPCC_BASE     = AHB4PERIPH_BASE + $00000C00;
  RNG_BASE      = AHB4PERIPH_BASE + $00001000;
  HSEM_BASE     = AHB4PERIPH_BASE + $00001400;
  AES2_BASE     = AHB4PERIPH_BASE + $00001800;
  PKA_BASE      = AHB4PERIPH_BASE + $00002000;
  FLASH_REG_BASE= AHB4PERIPH_BASE + $00004000;
  DBGMCU_BASE   = $E0042000;
  QUADSPI_BASE  = AHB3PERIPH_BASE + $00000000;
  QUADSPI_R_BASE= AHB3PERIPH_BASE + $10001000;
  PACKAGE_BASE  = $1FFF7500;
  UID64_BASE    = $1FFF7580;
  UID_BASE      = $1FFF7590;
  FLASHSIZE_BASE= $1FFF75E0;
  USB_BASE      = $40005C00;

var
  TIM2          : TTIM_Registers absolute TIM2_BASE;
  LCD           : TLCD_Registers absolute LCD_BASE;
  RTC           : TRTC_Registers absolute RTC_BASE;
  WWDG          : TWWDG_Registers absolute WWDG_BASE;
  IWDG          : TIWDG_Registers absolute IWDG_BASE;
  SPI2          : TSPI_Registers absolute SPI2_BASE;
  I2C1          : TI2C_Registers absolute I2C1_BASE;
  I2C3          : TI2C_Registers absolute I2C3_BASE;
  USB           : TUSB_Registers absolute USB1_BASE;
  CRS           : TCRS_Registers absolute CRS_BASE;
  LPTIM1        : TLPTIM_Registers absolute LPTIM1_BASE;
  LPUART1       : TUSART_Registers absolute LPUART1_BASE;
  LPTIM2        : TLPTIM_Registers absolute LPTIM2_BASE;
  SYSCFG        : TSYSCFG_Registers absolute SYSCFG_BASE;
  VREFBUF       : TVREFBUF_Registers absolute VREFBUF_BASE;
  COMP1         : TCOMP_Registers absolute COMP1_BASE;
  COMP2         : TCOMP_Registers absolute COMP2_BASE;
  COMP12_COMMON : TCOMP_Common_Registers absolute COMP2_BASE;
  TIM1          : TTIM_Registers absolute TIM1_BASE;
  SPI1          : TSPI_Registers absolute SPI1_BASE;
  USART1        : TUSART_Registers absolute USART1_BASE;
  TIM16         : TTIM_Registers absolute TIM16_BASE;
  TIM17         : TTIM_Registers absolute TIM17_BASE;
  SAI1          : TSAI_Registers absolute SAI1_BASE;
  SAI1_Block_A  : TSAI_Block_Registers absolute SAI1_Block_A_BASE;
  SAI1_Block_B  : TSAI_Block_Registers absolute SAI1_Block_B_BASE;
  DMA1          : TDMA_Registers absolute DMA1_BASE;
  DMA1_Channel1 : TDMA_Channel_Registers absolute DMA1_Channel1_BASE;
  DMA1_Channel2 : TDMA_Channel_Registers absolute DMA1_Channel2_BASE;
  DMA1_Channel3 : TDMA_Channel_Registers absolute DMA1_Channel3_BASE;
  DMA1_Channel4 : TDMA_Channel_Registers absolute DMA1_Channel4_BASE;
  DMA1_Channel5 : TDMA_Channel_Registers absolute DMA1_Channel5_BASE;
  DMA1_Channel6 : TDMA_Channel_Registers absolute DMA1_Channel6_BASE;
  DMA1_Channel7 : TDMA_Channel_Registers absolute DMA1_Channel7_BASE;
  DMA2          : TDMA_Registers absolute DMA2_BASE;
  DMA2_Channel1 : TDMA_Channel_Registers absolute DMA2_Channel1_BASE;
  DMA2_Channel2 : TDMA_Channel_Registers absolute DMA2_Channel2_BASE;
  DMA2_Channel3 : TDMA_Channel_Registers absolute DMA2_Channel3_BASE;
  DMA2_Channel4 : TDMA_Channel_Registers absolute DMA2_Channel4_BASE;
  DMA2_Channel5 : TDMA_Channel_Registers absolute DMA2_Channel5_BASE;
  DMA2_Channel6 : TDMA_Channel_Registers absolute DMA2_Channel6_BASE;
  DMA2_Channel7 : TDMA_Channel_Registers absolute DMA2_Channel7_BASE;
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
  DMAMUX1_RequestGenerator0: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator0_BASE;
  DMAMUX1_RequestGenerator1: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator1_BASE;
  DMAMUX1_RequestGenerator2: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator2_BASE;
  DMAMUX1_RequestGenerator3: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator3_BASE;
  DMAMUX1_ChannelStatus: TDMAMUX_ChannelStatus_Registers absolute DMAMUX1_ChannelStatus_BASE;
  DMAMUX1_RequestGenStatus: TDMAMUX_RequestGenStatus_Registers absolute DMAMUX1_RequestGenStatus_BASE;
  CRC           : TCRC_Registers absolute CRC_BASE;
  TSC           : TTSC_Registers absolute TSC_BASE;
  GPIOA         : TGPIO_Registers absolute GPIOA_BASE;
  GPIOB         : TGPIO_Registers absolute GPIOB_BASE;
  GPIOC         : TGPIO_Registers absolute GPIOC_BASE;
  GPIOD         : TGPIO_Registers absolute GPIOD_BASE;
  GPIOE         : TGPIO_Registers absolute GPIOE_BASE;
  GPIOH         : TGPIO_Registers absolute GPIOH_BASE;
  ADC1          : TADC_Registers absolute ADC1_BASE;
  ADC1_COMMON   : TADC_Common_Registers absolute ADC1_COMMON_BASE;
  AES1          : TAES_Registers absolute AES1_BASE;
  RCC           : TRCC_Registers absolute RCC_BASE;
  PWR           : TPWR_Registers absolute PWR_BASE;
  EXTI          : TEXTI_Registers absolute EXTI_BASE;
  IPCC          : TIPCC_Registers absolute IPCC_BASE;
  IPCC_C2       : TIPCC_Common_Registers absolute (IPCC_BASE + $10);
  RNG           : TRNG_Registers absolute RNG_BASE;
  HSEM          : THSEM_Registers absolute HSEM_BASE;
  HSEM_COMMON   : THSEM_Common_Registers absolute (HSEM_BASE + $100);
  AES2          : TAES_Registers absolute AES2_BASE;
  PKA           : TPKA_Registers absolute PKA_BASE;
  FLASH         : TFLASH_Registers absolute FLASH_REG_BASE;
  QUADSPI       : TQUADSPI_Registers absolute QUADSPI_R_BASE;
  DBGMCU        : TDBGMCU_Registers absolute DBGMCU_BASE;

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
procedure TAMP_STAMP_LSECSS_IRQHandler; external name 'TAMP_STAMP_LSECSS_IRQHandler';
procedure RTC_WKUP_IRQHandler; external name 'RTC_WKUP_IRQHandler';
procedure FLASH_IRQHandler; external name 'FLASH_IRQHandler';
procedure RCC_IRQHandler; external name 'RCC_IRQHandler';
procedure EXTI0_IRQHandler; external name 'EXTI0_IRQHandler';
procedure EXTI1_IRQHandler; external name 'EXTI1_IRQHandler';
procedure EXTI2_IRQHandler; external name 'EXTI2_IRQHandler';
procedure EXTI3_IRQHandler; external name 'EXTI3_IRQHandler';
procedure EXTI4_IRQHandler; external name 'EXTI4_IRQHandler';
procedure DMA1_Channel1_IRQHandler; external name 'DMA1_Channel1_IRQHandler';
procedure DMA1_Channel2_IRQHandler; external name 'DMA1_Channel2_IRQHandler';
procedure DMA1_Channel3_IRQHandler; external name 'DMA1_Channel3_IRQHandler';
procedure DMA1_Channel4_IRQHandler; external name 'DMA1_Channel4_IRQHandler';
procedure DMA1_Channel5_IRQHandler; external name 'DMA1_Channel5_IRQHandler';
procedure DMA1_Channel6_IRQHandler; external name 'DMA1_Channel6_IRQHandler';
procedure DMA1_Channel7_IRQHandler; external name 'DMA1_Channel7_IRQHandler';
procedure ADC1_IRQHandler; external name 'ADC1_IRQHandler';
procedure USB_HP_IRQHandler; external name 'USB_HP_IRQHandler';
procedure USB_LP_IRQHandler; external name 'USB_LP_IRQHandler';
procedure C2SEV_PWR_C2H_IRQHandler; external name 'C2SEV_PWR_C2H_IRQHandler';
procedure COMP_IRQHandler; external name 'COMP_IRQHandler';
procedure EXTI9_5_IRQHandler; external name 'EXTI9_5_IRQHandler';
procedure TIM1_BRK_IRQHandler; external name 'TIM1_BRK_IRQHandler';
procedure TIM1_UP_TIM16_IRQHandler; external name 'TIM1_UP_TIM16_IRQHandler';
procedure TIM1_TRG_COM_TIM17_IRQHandler; external name 'TIM1_TRG_COM_TIM17_IRQHandler';
procedure TIM1_CC_IRQHandler; external name 'TIM1_CC_IRQHandler';
procedure TIM2_IRQHandler; external name 'TIM2_IRQHandler';
procedure PKA_IRQHandler; external name 'PKA_IRQHandler';
procedure I2C1_EV_IRQHandler; external name 'I2C1_EV_IRQHandler';
procedure I2C1_ER_IRQHandler; external name 'I2C1_ER_IRQHandler';
procedure I2C3_EV_IRQHandler; external name 'I2C3_EV_IRQHandler';
procedure I2C3_ER_IRQHandler; external name 'I2C3_ER_IRQHandler';
procedure SPI1_IRQHandler; external name 'SPI1_IRQHandler';
procedure SPI2_IRQHandler; external name 'SPI2_IRQHandler';
procedure USART1_IRQHandler; external name 'USART1_IRQHandler';
procedure LPUART1_IRQHandler; external name 'LPUART1_IRQHandler';
procedure SAI1_IRQHandler; external name 'SAI1_IRQHandler';
procedure TSC_IRQHandler; external name 'TSC_IRQHandler';
procedure EXTI15_10_IRQHandler; external name 'EXTI15_10_IRQHandler';
procedure RTC_Alarm_IRQHandler; external name 'RTC_Alarm_IRQHandler';
procedure CRS_IRQHandler; external name 'CRS_IRQHandler';
procedure PWR_SOTF_BLEACT_802ACT_RFPHASE_IRQHandler; external name 'PWR_SOTF_BLEACT_802ACT_RFPHASE_IRQHandler';
procedure IPCC_C1_RX_IRQHandler; external name 'IPCC_C1_RX_IRQHandler';
procedure IPCC_C1_TX_IRQHandler; external name 'IPCC_C1_TX_IRQHandler';
procedure HSEM_IRQHandler; external name 'HSEM_IRQHandler';
procedure LPTIM1_IRQHandler; external name 'LPTIM1_IRQHandler';
procedure LPTIM2_IRQHandler; external name 'LPTIM2_IRQHandler';
procedure LCD_IRQHandler; external name 'LCD_IRQHandler';
procedure QUADSPI_IRQHandler; external name 'QUADSPI_IRQHandler';
procedure AES1_IRQHandler; external name 'AES1_IRQHandler';
procedure AES2_IRQHandler; external name 'AES2_IRQHandler';
procedure RNG_IRQHandler; external name 'RNG_IRQHandler';
procedure FPU_IRQHandler; external name 'FPU_IRQHandler';
procedure DMA2_Channel1_IRQHandler; external name 'DMA2_Channel1_IRQHandler';
procedure DMA2_Channel2_IRQHandler; external name 'DMA2_Channel2_IRQHandler';
procedure DMA2_Channel3_IRQHandler; external name 'DMA2_Channel3_IRQHandler';
procedure DMA2_Channel4_IRQHandler; external name 'DMA2_Channel4_IRQHandler';
procedure DMA2_Channel5_IRQHandler; external name 'DMA2_Channel5_IRQHandler';
procedure DMA2_Channel6_IRQHandler; external name 'DMA2_Channel6_IRQHandler';
procedure DMA2_Channel7_IRQHandler; external name 'DMA2_Channel7_IRQHandler';
procedure DMAMUX1_OVR_IRQHandler; external name 'DMAMUX1_OVR_IRQHandler';


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
  .long TAMP_STAMP_LSECSS_IRQHandler
  .long RTC_WKUP_IRQHandler
  .long FLASH_IRQHandler
  .long RCC_IRQHandler
  .long EXTI0_IRQHandler
  .long EXTI1_IRQHandler
  .long EXTI2_IRQHandler
  .long EXTI3_IRQHandler
  .long EXTI4_IRQHandler
  .long DMA1_Channel1_IRQHandler
  .long DMA1_Channel2_IRQHandler
  .long DMA1_Channel3_IRQHandler
  .long DMA1_Channel4_IRQHandler
  .long DMA1_Channel5_IRQHandler
  .long DMA1_Channel6_IRQHandler
  .long DMA1_Channel7_IRQHandler
  .long ADC1_IRQHandler
  .long USB_HP_IRQHandler
  .long USB_LP_IRQHandler
  .long C2SEV_PWR_C2H_IRQHandler
  .long COMP_IRQHandler
  .long EXTI9_5_IRQHandler
  .long TIM1_BRK_IRQHandler
  .long TIM1_UP_TIM16_IRQHandler
  .long TIM1_TRG_COM_TIM17_IRQHandler
  .long TIM1_CC_IRQHandler
  .long TIM2_IRQHandler
  .long PKA_IRQHandler
  .long I2C1_EV_IRQHandler
  .long I2C1_ER_IRQHandler
  .long I2C3_EV_IRQHandler
  .long I2C3_ER_IRQHandler
  .long SPI1_IRQHandler
  .long SPI2_IRQHandler
  .long USART1_IRQHandler
  .long LPUART1_IRQHandler
  .long SAI1_IRQHandler
  .long TSC_IRQHandler
  .long EXTI15_10_IRQHandler
  .long RTC_Alarm_IRQHandler
  .long CRS_IRQHandler
  .long PWR_SOTF_BLEACT_802ACT_RFPHASE_IRQHandler
  .long IPCC_C1_RX_IRQHandler
  .long IPCC_C1_TX_IRQHandler
  .long HSEM_IRQHandler
  .long LPTIM1_IRQHandler
  .long LPTIM2_IRQHandler
  .long LCD_IRQHandler
  .long QUADSPI_IRQHandler
  .long AES1_IRQHandler
  .long AES2_IRQHandler
  .long RNG_IRQHandler
  .long FPU_IRQHandler
  .long DMA2_Channel1_IRQHandler
  .long DMA2_Channel2_IRQHandler
  .long DMA2_Channel3_IRQHandler
  .long DMA2_Channel4_IRQHandler
  .long DMA2_Channel5_IRQHandler
  .long DMA2_Channel6_IRQHandler
  .long DMA2_Channel7_IRQHandler
  .long DMAMUX1_OVR_IRQHandler

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
  .weak TAMP_STAMP_LSECSS_IRQHandler
  .weak RTC_WKUP_IRQHandler
  .weak FLASH_IRQHandler
  .weak RCC_IRQHandler
  .weak EXTI0_IRQHandler
  .weak EXTI1_IRQHandler
  .weak EXTI2_IRQHandler
  .weak EXTI3_IRQHandler
  .weak EXTI4_IRQHandler
  .weak DMA1_Channel1_IRQHandler
  .weak DMA1_Channel2_IRQHandler
  .weak DMA1_Channel3_IRQHandler
  .weak DMA1_Channel4_IRQHandler
  .weak DMA1_Channel5_IRQHandler
  .weak DMA1_Channel6_IRQHandler
  .weak DMA1_Channel7_IRQHandler
  .weak ADC1_IRQHandler
  .weak USB_HP_IRQHandler
  .weak USB_LP_IRQHandler
  .weak C2SEV_PWR_C2H_IRQHandler
  .weak COMP_IRQHandler
  .weak EXTI9_5_IRQHandler
  .weak TIM1_BRK_IRQHandler
  .weak TIM1_UP_TIM16_IRQHandler
  .weak TIM1_TRG_COM_TIM17_IRQHandler
  .weak TIM1_CC_IRQHandler
  .weak TIM2_IRQHandler
  .weak PKA_IRQHandler
  .weak I2C1_EV_IRQHandler
  .weak I2C1_ER_IRQHandler
  .weak I2C3_EV_IRQHandler
  .weak I2C3_ER_IRQHandler
  .weak SPI1_IRQHandler
  .weak SPI2_IRQHandler
  .weak USART1_IRQHandler
  .weak LPUART1_IRQHandler
  .weak SAI1_IRQHandler
  .weak TSC_IRQHandler
  .weak EXTI15_10_IRQHandler
  .weak RTC_Alarm_IRQHandler
  .weak CRS_IRQHandler
  .weak PWR_SOTF_BLEACT_802ACT_RFPHASE_IRQHandler
  .weak IPCC_C1_RX_IRQHandler
  .weak IPCC_C1_TX_IRQHandler
  .weak HSEM_IRQHandler
  .weak LPTIM1_IRQHandler
  .weak LPTIM2_IRQHandler
  .weak LCD_IRQHandler
  .weak QUADSPI_IRQHandler
  .weak AES1_IRQHandler
  .weak AES2_IRQHandler
  .weak RNG_IRQHandler
  .weak FPU_IRQHandler
  .weak DMA2_Channel1_IRQHandler
  .weak DMA2_Channel2_IRQHandler
  .weak DMA2_Channel3_IRQHandler
  .weak DMA2_Channel4_IRQHandler
  .weak DMA2_Channel5_IRQHandler
  .weak DMA2_Channel6_IRQHandler
  .weak DMA2_Channel7_IRQHandler
  .weak DMAMUX1_OVR_IRQHandler

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
  .set TAMP_STAMP_LSECSS_IRQHandler, Haltproc
  .set RTC_WKUP_IRQHandler, Haltproc
  .set FLASH_IRQHandler, Haltproc
  .set RCC_IRQHandler, Haltproc
  .set EXTI0_IRQHandler, Haltproc
  .set EXTI1_IRQHandler, Haltproc
  .set EXTI2_IRQHandler, Haltproc
  .set EXTI3_IRQHandler, Haltproc
  .set EXTI4_IRQHandler, Haltproc
  .set DMA1_Channel1_IRQHandler, Haltproc
  .set DMA1_Channel2_IRQHandler, Haltproc
  .set DMA1_Channel3_IRQHandler, Haltproc
  .set DMA1_Channel4_IRQHandler, Haltproc
  .set DMA1_Channel5_IRQHandler, Haltproc
  .set DMA1_Channel6_IRQHandler, Haltproc
  .set DMA1_Channel7_IRQHandler, Haltproc
  .set ADC1_IRQHandler, Haltproc
  .set USB_HP_IRQHandler, Haltproc
  .set USB_LP_IRQHandler, Haltproc
  .set C2SEV_PWR_C2H_IRQHandler, Haltproc
  .set COMP_IRQHandler, Haltproc
  .set EXTI9_5_IRQHandler, Haltproc
  .set TIM1_BRK_IRQHandler, Haltproc
  .set TIM1_UP_TIM16_IRQHandler, Haltproc
  .set TIM1_TRG_COM_TIM17_IRQHandler, Haltproc
  .set TIM1_CC_IRQHandler, Haltproc
  .set TIM2_IRQHandler, Haltproc
  .set PKA_IRQHandler, Haltproc
  .set I2C1_EV_IRQHandler, Haltproc
  .set I2C1_ER_IRQHandler, Haltproc
  .set I2C3_EV_IRQHandler, Haltproc
  .set I2C3_ER_IRQHandler, Haltproc
  .set SPI1_IRQHandler, Haltproc
  .set SPI2_IRQHandler, Haltproc
  .set USART1_IRQHandler, Haltproc
  .set LPUART1_IRQHandler, Haltproc
  .set SAI1_IRQHandler, Haltproc
  .set TSC_IRQHandler, Haltproc
  .set EXTI15_10_IRQHandler, Haltproc
  .set RTC_Alarm_IRQHandler, Haltproc
  .set CRS_IRQHandler, Haltproc
  .set PWR_SOTF_BLEACT_802ACT_RFPHASE_IRQHandler, Haltproc
  .set IPCC_C1_RX_IRQHandler, Haltproc
  .set IPCC_C1_TX_IRQHandler, Haltproc
  .set HSEM_IRQHandler, Haltproc
  .set LPTIM1_IRQHandler, Haltproc
  .set LPTIM2_IRQHandler, Haltproc
  .set LCD_IRQHandler, Haltproc
  .set QUADSPI_IRQHandler, Haltproc
  .set AES1_IRQHandler, Haltproc
  .set AES2_IRQHandler, Haltproc
  .set RNG_IRQHandler, Haltproc
  .set FPU_IRQHandler, Haltproc
  .set DMA2_Channel1_IRQHandler, Haltproc
  .set DMA2_Channel2_IRQHandler, Haltproc
  .set DMA2_Channel3_IRQHandler, Haltproc
  .set DMA2_Channel4_IRQHandler, Haltproc
  .set DMA2_Channel5_IRQHandler, Haltproc
  .set DMA2_Channel6_IRQHandler, Haltproc
  .set DMA2_Channel7_IRQHandler, Haltproc
  .set DMAMUX1_OVR_IRQHandler, Haltproc

  .text
  end;
end.
