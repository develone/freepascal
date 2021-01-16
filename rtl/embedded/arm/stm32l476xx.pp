unit stm32l476xx;
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
    TAMP_STAMP_IRQn = 2,              
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
    ADC1_2_IRQn = 18,                 
    CAN1_TX_IRQn = 19,                
    CAN1_RX0_IRQn = 20,               
    CAN1_RX1_IRQn = 21,               
    CAN1_SCE_IRQn = 22,               
    EXTI9_5_IRQn = 23,                
    TIM1_BRK_TIM15_IRQn = 24,         
    TIM1_UP_TIM16_IRQn = 25,          
    TIM1_TRG_COM_TIM17_IRQn = 26,     
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
    DFSDM1_FLT3_IRQn = 42,            
    TIM8_BRK_IRQn = 43,               
    TIM8_UP_IRQn = 44,                
    TIM8_TRG_COM_IRQn = 45,           
    TIM8_CC_IRQn = 46,                
    ADC3_IRQn   = 47,                 
    FMC_IRQn    = 48,                 
    SDMMC1_IRQn = 49,                 
    TIM5_IRQn   = 50,                 
    SPI3_IRQn   = 51,                 
    UART4_IRQn  = 52,                 
    UART5_IRQn  = 53,                 
    TIM6_DAC_IRQn = 54,               
    TIM7_IRQn   = 55,                 
    DMA2_Channel1_IRQn = 56,          
    DMA2_Channel2_IRQn = 57,          
    DMA2_Channel3_IRQn = 58,          
    DMA2_Channel4_IRQn = 59,          
    DMA2_Channel5_IRQn = 60,          
    DFSDM1_FLT0_IRQn = 61,            
    DFSDM1_FLT1_IRQn = 62,            
    DFSDM1_FLT2_IRQn = 63,            
    COMP_IRQn   = 64,                 
    LPTIM1_IRQn = 65,                 
    LPTIM2_IRQn = 66,                 
    OTG_FS_IRQn = 67,                 
    DMA2_Channel6_IRQn = 68,          
    DMA2_Channel7_IRQn = 69,          
    LPUART1_IRQn = 70,                
    QUADSPI_IRQn = 71,                
    I2C3_EV_IRQn = 72,                
    I2C3_ER_IRQn = 73,                
    SAI1_IRQn   = 74,                 
    SAI2_IRQn   = 75,                 
    SWPMI1_IRQn = 76,                 
    TSC_IRQn    = 77,                 
    LCD_IRQn    = 78,                 
    RNG_IRQn    = 80,                 
    FPU_IRQn    = 81                  
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
    CSR         : longword;
    RESERVED    : longword;
    CCR         : longword;
    CDR         : longword;
  end;

  TCAN_TxMailBox_Registers = record
    TIR         : longword;
    TDTR        : longword;
    TDLR        : longword;
    TDHR        : longword;
  end;

  TCAN_FIFOMailBox_Registers = record
    RIR         : longword;
    RDTR        : longword;
    RDLR        : longword;
    RDHR        : longword;
  end;

  TCAN_FilterRegister_Registers = record
    FR1         : longword;
    FR2         : longword;
  end;

  TCAN_Registers = record
    MCR         : longword;
    MSR         : longword;
    TSR         : longword;
    RF0R        : longword;
    RF1R        : longword;
    IER         : longword;
    ESR         : longword;
    BTR         : longword;
    RESERVED0   : array[0..87] of longword;
    sTxMailBox  : array[0..2] of TCAN_TxMailBox_Registers;
    sFIFOMailBox : array[0..1] of TCAN_FIFOMailBox_Registers;
    RESERVED1   : array[0..11] of longword;
    FMR         : longword;
    FM1R        : longword;
    RESERVED2   : longword;
    FS1R        : longword;
    RESERVED3   : longword;
    FFA1R       : longword;
    RESERVED4   : longword;
    FA1R        : longword;
    RESERVED5   : array[0..7] of longword;
    sFilterRegister : array[0..27] of TCAN_FilterRegister_Registers;
  end;

  TCOMP_Registers = record
    CSR         : longword;
  end;

  TCOMP_Common_Registers = record
    CSR         : longword;
  end;

  TCRC_Registers = record
    DR          : longword;
    IDR         : byte;
    RESERVED0   : byte;
    RESERVED1   : word;
    CR          : longword;
    RESERVED2   : longword;
    INIT        : longword;
    POL         : longword;
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
  end;

  TDBGMCU_Registers = record
    IDCODE      : longword;
    CR          : longword;
    APB1FZR1    : longword;
    APB1FZR2    : longword;
    APB2FZ      : longword;
  end;

  TDMA_Channel_Registers = record
    CCR         : longword;
    CNDTR       : longword;
    CPAR        : longword;
    CMAR        : longword;
  end;

  TDMA_Registers = record
    ISR         : longword;
    IFCR        : longword;
  end;

  TDMA_Request_Registers = record
    CSELR       : longword;
  end;

  TEXTI_Registers = record
    IMR1        : longword;
    EMR1        : longword;
    RTSR1       : longword;
    FTSR1       : longword;
    SWIER1      : longword;
    PR1         : longword;
    RESERVED1   : longword;
    RESERVED2   : longword;
    IMR2        : longword;
    EMR2        : longword;
    RTSR2       : longword;
    FTSR2       : longword;
    SWIER2      : longword;
    PR2         : longword;
  end;

  TFIREWALL_Registers = record
    CSSA        : longword;
    CSL         : longword;
    NVDSSA      : longword;
    NVDSL       : longword;
    VDSSA       : longword;
    VDSL        : longword;
    RESERVED1   : longword;
    RESERVED2   : longword;
    CR          : longword;
  end;

  TFLASH_Registers = record
    ACR         : longword;
    PDKEYR      : longword;
    KEYR        : longword;
    OPTKEYR     : longword;
    SR          : longword;
    CR          : longword;
    ECCR        : longword;
    RESERVED1   : longword;
    OPTR        : longword;
    PCROP1SR    : longword;
    PCROP1ER    : longword;
    WRP1AR      : longword;
    WRP1BR      : longword;
    RESERVED2   : array[0..3] of longword;
    PCROP2SR    : longword;
    PCROP2ER    : longword;
    WRP2AR      : longword;
    WRP2BR      : longword;
  end;

  TFMC_Bank1_Registers = record
    BTCR        : array[0..7] of longword;
  end;

  TFMC_Bank1E_Registers = record
    BWTR        : array[0..6] of longword;
  end;

  TFMC_Bank3_Registers = record
    PCR         : longword;
    SR          : longword;
    PMEM        : longword;
    PATT        : longword;
    RESERVED0   : longword;
    ECCR        : longword;
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
    ASCR        : longword;
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

  TLCD_Registers = record
    CR          : longword;
    FCR         : longword;
    SR          : longword;
    CLR         : longword;
    RESERVED    : longword;
    RAM         : array[0..15] of longword;
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

  TOPAMP_Registers = record
    CSR         : longword;
    OTR         : longword;
    LPOTR       : longword;
  end;

  TOPAMP_Common_Registers = record
    CSR         : longword;
  end;

  TPWR_Registers = record
    CR1         : longword;
    CR2         : longword;
    CR3         : longword;
    CR4         : longword;
    SR1         : longword;
    SR2         : longword;
    SCR         : longword;
    RESERVED    : longword;
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
    PUCRF       : longword;
    PDCRF       : longword;
    PUCRG       : longword;
    PDCRG       : longword;
    PUCRH       : longword;
    PDCRH       : longword;
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
    PLLSAI2CFGR : longword;
    CIER        : longword;
    CIFR        : longword;
    CICR        : longword;
    RESERVED0   : longword;
    AHB1RSTR    : longword;
    AHB2RSTR    : longword;
    AHB3RSTR    : longword;
    RESERVED1   : longword;
    APB1RSTR1   : longword;
    APB1RSTR2   : longword;
    APB2RSTR    : longword;
    RESERVED2   : longword;
    AHB1ENR     : longword;
    AHB2ENR     : longword;
    AHB3ENR     : longword;
    RESERVED3   : longword;
    APB1ENR1    : longword;
    APB1ENR2    : longword;
    APB2ENR     : longword;
    RESERVED4   : longword;
    AHB1SMENR   : longword;
    AHB2SMENR   : longword;
    AHB3SMENR   : longword;
    RESERVED5   : longword;
    APB1SMENR1  : longword;
    APB1SMENR2  : longword;
    APB2SMENR   : longword;
    RESERVED6   : longword;
    CCIPR       : longword;
    RESERVED7   : longword;
    BDCR        : longword;
    CSR         : longword;
  end;

  TRTC_Registers = record
    TR          : longword;
    DR          : longword;
    CR          : longword;
    ISR         : longword;
    PRER        : longword;
    WUTR        : longword;
    reserved    : longword;
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
    RESERVED0   : array[0..1] of longword;
    FIFOCNT     : longword;
    RESERVED1   : array[0..12] of longword;
    FIFO        : longword;
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

  TSYSCFG_Registers = record
    MEMRMP      : longword;
    CFGR1       : longword;
    EXTICR      : array[0..3] of longword;
    SCSR        : longword;
    CFGR2       : longword;
    SWPR        : longword;
    SKR         : longword;
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
    OR1         : longword;
    CCMR3       : longword;
    CCR5        : longword;
    CCR6        : longword;
    OR2         : longword;
    OR3         : longword;
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
    IOGXCR      : array[0..7] of longword;
  end;

  TUSART_Registers = record
    CR1         : longword;
    CR2         : longword;
    CR3         : longword;
    BRR         : longword;
    GTPR        : word;
    RESERVED2   : word;
    RTOR        : longword;
    RQR         : word;
    RESERVED3   : word;
    ISR         : longword;
    ICR         : longword;
    RDR         : word;
    RESERVED4   : word;
    TDR         : word;
    RESERVED5   : word;
  end;

  TVREFBUF_Registers = record
    CSR         : longword;
    CCR         : longword;
  end;

  TWWDG_Registers = record
    CR          : longword;
    CFR         : longword;
    SR          : longword;
  end;

  TRNG_Registers = record
    CR          : longword;
    SR          : longword;
    DR          : longword;
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
    Reserved24  : longword;
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

const
  __NVIC_PRIO_BITS= 4;
  FLASH_BASE    = $08000000;
  SRAM1_BASE    = $20000000;
  SRAM2_BASE    = $10000000;
  PERIPH_BASE   = $40000000;
  FMC_BASE      = $60000000;
  QSPI_BASE     = $90000000;
  FMC_R_BASE    = $A0000000;
  QSPI_R_BASE   = $A0001000;
  SRAM1_BB_BASE = $22000000;
  PERIPH_BB_BASE= $42000000;
  SRAM_BASE     = SRAM1_BASE;
  SRAM_BB_BASE  = SRAM1_BB_BASE;
  APB1PERIPH_BASE= PERIPH_BASE;
  APB2PERIPH_BASE= PERIPH_BASE + $00010000;
  AHB1PERIPH_BASE= PERIPH_BASE + $00020000;
  AHB2PERIPH_BASE= PERIPH_BASE + $08000000;
  TIM2_BASE     = APB1PERIPH_BASE + $0000;
  TIM3_BASE     = APB1PERIPH_BASE + $0400;
  TIM4_BASE     = APB1PERIPH_BASE + $0800;
  TIM5_BASE     = APB1PERIPH_BASE + $0C00;
  TIM6_BASE     = APB1PERIPH_BASE + $1000;
  TIM7_BASE     = APB1PERIPH_BASE + $1400;
  LCD_BASE      = APB1PERIPH_BASE + $2400;
  RTC_BASE      = APB1PERIPH_BASE + $2800;
  WWDG_BASE     = APB1PERIPH_BASE + $2C00;
  IWDG_BASE     = APB1PERIPH_BASE + $3000;
  SPI2_BASE     = APB1PERIPH_BASE + $3800;
  SPI3_BASE     = APB1PERIPH_BASE + $3C00;
  USART2_BASE   = APB1PERIPH_BASE + $4400;
  USART3_BASE   = APB1PERIPH_BASE + $4800;
  UART4_BASE    = APB1PERIPH_BASE + $4C00;
  UART5_BASE    = APB1PERIPH_BASE + $5000;
  I2C1_BASE     = APB1PERIPH_BASE + $5400;
  I2C2_BASE     = APB1PERIPH_BASE + $5800;
  I2C3_BASE     = APB1PERIPH_BASE + $5C00;
  CAN1_BASE     = APB1PERIPH_BASE + $6400;
  PWR_BASE      = APB1PERIPH_BASE + $7000;
  DAC_BASE      = APB1PERIPH_BASE + $7400;
  DAC1_BASE     = APB1PERIPH_BASE + $7400;
  OPAMP_BASE    = APB1PERIPH_BASE + $7800;
  OPAMP1_BASE   = APB1PERIPH_BASE + $7800;
  OPAMP2_BASE   = APB1PERIPH_BASE + $7810;
  LPTIM1_BASE   = APB1PERIPH_BASE + $7C00;
  LPUART1_BASE  = APB1PERIPH_BASE + $8000;
  SWPMI1_BASE   = APB1PERIPH_BASE + $8800;
  LPTIM2_BASE   = APB1PERIPH_BASE + $9400;
  SYSCFG_BASE   = APB2PERIPH_BASE + $0000;
  VREFBUF_BASE  = APB2PERIPH_BASE + $0030;
  COMP1_BASE    = APB2PERIPH_BASE + $0200;
  COMP2_BASE    = APB2PERIPH_BASE + $0204;
  EXTI_BASE     = APB2PERIPH_BASE + $0400;
  FIREWALL_BASE = APB2PERIPH_BASE + $1C00;
  SDMMC1_BASE   = APB2PERIPH_BASE + $2800;
  TIM1_BASE     = APB2PERIPH_BASE + $2C00;
  SPI1_BASE     = APB2PERIPH_BASE + $3000;
  TIM8_BASE     = APB2PERIPH_BASE + $3400;
  USART1_BASE   = APB2PERIPH_BASE + $3800;
  TIM15_BASE    = APB2PERIPH_BASE + $4000;
  TIM16_BASE    = APB2PERIPH_BASE + $4400;
  TIM17_BASE    = APB2PERIPH_BASE + $4800;
  SAI1_BASE     = APB2PERIPH_BASE + $5400;
  SAI1_Block_A_BASE= SAI1_BASE + $0004;
  SAI1_Block_B_BASE= SAI1_BASE + $0024;
  SAI2_BASE     = APB2PERIPH_BASE + $5800;
  SAI2_Block_A_BASE= SAI2_BASE + $0004;
  SAI2_Block_B_BASE= SAI2_BASE + $0024;
  DFSDM1_BASE   = APB2PERIPH_BASE + $6000;
  DFSDM1_Channel0_BASE= DFSDM1_BASE + $0000;
  DFSDM1_Channel1_BASE= DFSDM1_BASE + $0020;
  DFSDM1_Channel2_BASE= DFSDM1_BASE + $0040;
  DFSDM1_Channel3_BASE= DFSDM1_BASE + $0060;
  DFSDM1_Channel4_BASE= DFSDM1_BASE + $0080;
  DFSDM1_Channel5_BASE= DFSDM1_BASE + $00A0;
  DFSDM1_Channel6_BASE= DFSDM1_BASE + $00C0;
  DFSDM1_Channel7_BASE= DFSDM1_BASE + $00E0;
  DFSDM1_Filter0_BASE= DFSDM1_BASE + $0100;
  DFSDM1_Filter1_BASE= DFSDM1_BASE + $0180;
  DFSDM1_Filter2_BASE= DFSDM1_BASE + $0200;
  DFSDM1_Filter3_BASE= DFSDM1_BASE + $0280;
  DMA1_BASE     = AHB1PERIPH_BASE;
  DMA2_BASE     = AHB1PERIPH_BASE + $0400;
  RCC_BASE      = AHB1PERIPH_BASE + $1000;
  FLASH_R_BASE  = AHB1PERIPH_BASE + $2000;
  CRC_BASE      = AHB1PERIPH_BASE + $3000;
  TSC_BASE      = AHB1PERIPH_BASE + $4000;
  DMA1_Channel1_BASE= DMA1_BASE + $0008;
  DMA1_Channel2_BASE= DMA1_BASE + $001C;
  DMA1_Channel3_BASE= DMA1_BASE + $0030;
  DMA1_Channel4_BASE= DMA1_BASE + $0044;
  DMA1_Channel5_BASE= DMA1_BASE + $0058;
  DMA1_Channel6_BASE= DMA1_BASE + $006C;
  DMA1_Channel7_BASE= DMA1_BASE + $0080;
  DMA1_CSELR_BASE= DMA1_BASE + $00A8;
  DMA2_Channel1_BASE= DMA2_BASE + $0008;
  DMA2_Channel2_BASE= DMA2_BASE + $001C;
  DMA2_Channel3_BASE= DMA2_BASE + $0030;
  DMA2_Channel4_BASE= DMA2_BASE + $0044;
  DMA2_Channel5_BASE= DMA2_BASE + $0058;
  DMA2_Channel6_BASE= DMA2_BASE + $006C;
  DMA2_Channel7_BASE= DMA2_BASE + $0080;
  DMA2_CSELR_BASE= DMA2_BASE + $00A8;
  GPIOA_BASE    = AHB2PERIPH_BASE + $0000;
  GPIOB_BASE    = AHB2PERIPH_BASE + $0400;
  GPIOC_BASE    = AHB2PERIPH_BASE + $0800;
  GPIOD_BASE    = AHB2PERIPH_BASE + $0C00;
  GPIOE_BASE    = AHB2PERIPH_BASE + $1000;
  GPIOF_BASE    = AHB2PERIPH_BASE + $1400;
  GPIOG_BASE    = AHB2PERIPH_BASE + $1800;
  GPIOH_BASE    = AHB2PERIPH_BASE + $1C00;
  USBOTG_BASE   = AHB2PERIPH_BASE + $08000000;
  ADC1_BASE     = AHB2PERIPH_BASE + $08040000;
  ADC2_BASE     = AHB2PERIPH_BASE + $08040100;
  ADC3_BASE     = AHB2PERIPH_BASE + $08040200;
  ADC123_COMMON_BASE= AHB2PERIPH_BASE + $08040300;
  RNG_BASE      = AHB2PERIPH_BASE + $08060800;
  FMC_Bank1_R_BASE= FMC_R_BASE + $0000;
  FMC_Bank1E_R_BASE= FMC_R_BASE + $0104;
  FMC_Bank3_R_BASE= FMC_R_BASE + $0080;
  DBGMCU_BASE   = $E0042000;
  USB_OTG_FS_PERIPH_BASE= $50000000;
  USB_OTG_GLOBAL_BASE= $00000000;
  USB_OTG_DEVICE_BASE= $00000800;
  USB_OTG_IN_ENDPOINT_BASE= $00000900;
  USB_OTG_OUT_ENDPOINT_BASE= $00000B00;
  USB_OTG_HOST_BASE= $00000400;
  USB_OTG_HOST_PORT_BASE= $00000440;
  USB_OTG_HOST_CHANNEL_BASE= $00000500;
  USB_OTG_PCGCCTL_BASE= $00000E00;
  USB_OTG_FIFO_BASE= $00001000;
  PACKAGE_BASE  = $1FFF7500;
  UID_BASE      = $1FFF7590;
  FLASHSIZE_BASE= $1FFF75E0;

var
  TIM2          : TTIM_Registers absolute TIM2_BASE;
  TIM3          : TTIM_Registers absolute TIM3_BASE;
  TIM4          : TTIM_Registers absolute TIM4_BASE;
  TIM5          : TTIM_Registers absolute TIM5_BASE;
  TIM6          : TTIM_Registers absolute TIM6_BASE;
  TIM7          : TTIM_Registers absolute TIM7_BASE;
  LCD           : TLCD_Registers absolute LCD_BASE;
  RTC           : TRTC_Registers absolute RTC_BASE;
  WWDG          : TWWDG_Registers absolute WWDG_BASE;
  IWDG          : TIWDG_Registers absolute IWDG_BASE;
  SPI2          : TSPI_Registers absolute SPI2_BASE;
  SPI3          : TSPI_Registers absolute SPI3_BASE;
  USART2        : TUSART_Registers absolute USART2_BASE;
  USART3        : TUSART_Registers absolute USART3_BASE;
  UART4         : TUSART_Registers absolute UART4_BASE;
  UART5         : TUSART_Registers absolute UART5_BASE;
  I2C1          : TI2C_Registers absolute I2C1_BASE;
  I2C2          : TI2C_Registers absolute I2C2_BASE;
  I2C3          : TI2C_Registers absolute I2C3_BASE;
  CAN           : TCAN_Registers absolute CAN1_BASE;
  CAN1          : TCAN_Registers absolute CAN1_BASE;
  PWR           : TPWR_Registers absolute PWR_BASE;
  DAC           : TDAC_Registers absolute DAC1_BASE;
  DAC1          : TDAC_Registers absolute DAC1_BASE;
  OPAMP         : TOPAMP_Registers absolute OPAMP_BASE;
  OPAMP1        : TOPAMP_Registers absolute OPAMP1_BASE;
  OPAMP2        : TOPAMP_Registers absolute OPAMP2_BASE;
  OPAMP12_COMMON: TOPAMP_Common_Registers absolute OPAMP1_BASE;
  LPTIM1        : TLPTIM_Registers absolute LPTIM1_BASE;
  LPUART1       : TUSART_Registers absolute LPUART1_BASE;
  SWPMI1        : TSWPMI_Registers absolute SWPMI1_BASE;
  LPTIM2        : TLPTIM_Registers absolute LPTIM2_BASE;
  SYSCFG        : TSYSCFG_Registers absolute SYSCFG_BASE;
  VREFBUF       : TVREFBUF_Registers absolute VREFBUF_BASE;
  COMP1         : TCOMP_Registers absolute COMP1_BASE;
  COMP2         : TCOMP_Registers absolute COMP2_BASE;
  COMP12_COMMON : TCOMP_Common_Registers absolute COMP2_BASE;
  EXTI          : TEXTI_Registers absolute EXTI_BASE;
  FIREWALL      : TFIREWALL_Registers absolute FIREWALL_BASE;
  SDMMC1        : TSDMMC_Registers absolute SDMMC1_BASE;
  TIM1          : TTIM_Registers absolute TIM1_BASE;
  SPI1          : TSPI_Registers absolute SPI1_BASE;
  TIM8          : TTIM_Registers absolute TIM8_BASE;
  USART1        : TUSART_Registers absolute USART1_BASE;
  TIM15         : TTIM_Registers absolute TIM15_BASE;
  TIM16         : TTIM_Registers absolute TIM16_BASE;
  TIM17         : TTIM_Registers absolute TIM17_BASE;
  SAI1          : TSAI_Registers absolute SAI1_BASE;
  SAI1_Block_A  : TSAI_Block_Registers absolute SAI1_Block_A_BASE;
  SAI1_Block_B  : TSAI_Block_Registers absolute SAI1_Block_B_BASE;
  SAI2          : TSAI_Registers absolute SAI2_BASE;
  SAI2_Block_A  : TSAI_Block_Registers absolute SAI2_Block_A_BASE;
  SAI2_Block_B  : TSAI_Block_Registers absolute SAI2_Block_B_BASE;
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
  DMA1          : TDMA_Registers absolute DMA1_BASE;
  DMA2          : TDMA_Registers absolute DMA2_BASE;
  RCC           : TRCC_Registers absolute RCC_BASE;
  FLASH         : TFLASH_Registers absolute FLASH_R_BASE;
  CRC           : TCRC_Registers absolute CRC_BASE;
  TSC           : TTSC_Registers absolute TSC_BASE;
  GPIOA         : TGPIO_Registers absolute GPIOA_BASE;
  GPIOB         : TGPIO_Registers absolute GPIOB_BASE;
  GPIOC         : TGPIO_Registers absolute GPIOC_BASE;
  GPIOD         : TGPIO_Registers absolute GPIOD_BASE;
  GPIOE         : TGPIO_Registers absolute GPIOE_BASE;
  GPIOF         : TGPIO_Registers absolute GPIOF_BASE;
  GPIOG         : TGPIO_Registers absolute GPIOG_BASE;
  GPIOH         : TGPIO_Registers absolute GPIOH_BASE;
  ADC1          : TADC_Registers absolute ADC1_BASE;
  ADC2          : TADC_Registers absolute ADC2_BASE;
  ADC3          : TADC_Registers absolute ADC3_BASE;
  ADC123_COMMON : TADC_Common_Registers absolute ADC123_COMMON_BASE;
  RNG           : TRNG_Registers absolute RNG_BASE;
  DMA1_Channel1 : TDMA_Channel_Registers absolute DMA1_Channel1_BASE;
  DMA1_Channel2 : TDMA_Channel_Registers absolute DMA1_Channel2_BASE;
  DMA1_Channel3 : TDMA_Channel_Registers absolute DMA1_Channel3_BASE;
  DMA1_Channel4 : TDMA_Channel_Registers absolute DMA1_Channel4_BASE;
  DMA1_Channel5 : TDMA_Channel_Registers absolute DMA1_Channel5_BASE;
  DMA1_Channel6 : TDMA_Channel_Registers absolute DMA1_Channel6_BASE;
  DMA1_Channel7 : TDMA_Channel_Registers absolute DMA1_Channel7_BASE;
  DMA1_CSELR    : TDMA_Request_Registers absolute DMA1_CSELR_BASE;
  DMA2_Channel1 : TDMA_Channel_Registers absolute DMA2_Channel1_BASE;
  DMA2_Channel2 : TDMA_Channel_Registers absolute DMA2_Channel2_BASE;
  DMA2_Channel3 : TDMA_Channel_Registers absolute DMA2_Channel3_BASE;
  DMA2_Channel4 : TDMA_Channel_Registers absolute DMA2_Channel4_BASE;
  DMA2_Channel5 : TDMA_Channel_Registers absolute DMA2_Channel5_BASE;
  DMA2_Channel6 : TDMA_Channel_Registers absolute DMA2_Channel6_BASE;
  DMA2_Channel7 : TDMA_Channel_Registers absolute DMA2_Channel7_BASE;
  DMA2_CSELR    : TDMA_Request_Registers absolute DMA2_CSELR_BASE;
  FMC_Bank1_R   : TFMC_Bank1_Registers absolute FMC_Bank1_R_BASE;
  FMC_Bank1E_R  : TFMC_Bank1E_Registers absolute FMC_Bank1E_R_BASE;
  FMC_Bank3_R   : TFMC_Bank3_Registers absolute FMC_Bank3_R_BASE;
  QUADSPI       : TQUADSPI_Registers absolute QSPI_R_BASE;
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
procedure TAMP_STAMP_IRQHandler; external name 'TAMP_STAMP_IRQHandler';
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
procedure ADC1_2_IRQHandler; external name 'ADC1_2_IRQHandler';
procedure CAN1_TX_IRQHandler; external name 'CAN1_TX_IRQHandler';
procedure CAN1_RX0_IRQHandler; external name 'CAN1_RX0_IRQHandler';
procedure CAN1_RX1_IRQHandler; external name 'CAN1_RX1_IRQHandler';
procedure CAN1_SCE_IRQHandler; external name 'CAN1_SCE_IRQHandler';
procedure EXTI9_5_IRQHandler; external name 'EXTI9_5_IRQHandler';
procedure TIM1_BRK_TIM15_IRQHandler; external name 'TIM1_BRK_TIM15_IRQHandler';
procedure TIM1_UP_TIM16_IRQHandler; external name 'TIM1_UP_TIM16_IRQHandler';
procedure TIM1_TRG_COM_TIM17_IRQHandler; external name 'TIM1_TRG_COM_TIM17_IRQHandler';
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
procedure DFSDM1_FLT3_IRQHandler; external name 'DFSDM1_FLT3_IRQHandler';
procedure TIM8_BRK_IRQHandler; external name 'TIM8_BRK_IRQHandler';
procedure TIM8_UP_IRQHandler; external name 'TIM8_UP_IRQHandler';
procedure TIM8_TRG_COM_IRQHandler; external name 'TIM8_TRG_COM_IRQHandler';
procedure TIM8_CC_IRQHandler; external name 'TIM8_CC_IRQHandler';
procedure ADC3_IRQHandler; external name 'ADC3_IRQHandler';
procedure FMC_IRQHandler; external name 'FMC_IRQHandler';
procedure SDMMC1_IRQHandler; external name 'SDMMC1_IRQHandler';
procedure TIM5_IRQHandler; external name 'TIM5_IRQHandler';
procedure SPI3_IRQHandler; external name 'SPI3_IRQHandler';
procedure UART4_IRQHandler; external name 'UART4_IRQHandler';
procedure UART5_IRQHandler; external name 'UART5_IRQHandler';
procedure TIM6_DAC_IRQHandler; external name 'TIM6_DAC_IRQHandler';
procedure TIM7_IRQHandler; external name 'TIM7_IRQHandler';
procedure DMA2_Channel1_IRQHandler; external name 'DMA2_Channel1_IRQHandler';
procedure DMA2_Channel2_IRQHandler; external name 'DMA2_Channel2_IRQHandler';
procedure DMA2_Channel3_IRQHandler; external name 'DMA2_Channel3_IRQHandler';
procedure DMA2_Channel4_IRQHandler; external name 'DMA2_Channel4_IRQHandler';
procedure DMA2_Channel5_IRQHandler; external name 'DMA2_Channel5_IRQHandler';
procedure DFSDM1_FLT0_IRQHandler; external name 'DFSDM1_FLT0_IRQHandler';
procedure DFSDM1_FLT1_IRQHandler; external name 'DFSDM1_FLT1_IRQHandler';
procedure DFSDM1_FLT2_IRQHandler; external name 'DFSDM1_FLT2_IRQHandler';
procedure COMP_IRQHandler; external name 'COMP_IRQHandler';
procedure LPTIM1_IRQHandler; external name 'LPTIM1_IRQHandler';
procedure LPTIM2_IRQHandler; external name 'LPTIM2_IRQHandler';
procedure OTG_FS_IRQHandler; external name 'OTG_FS_IRQHandler';
procedure DMA2_Channel6_IRQHandler; external name 'DMA2_Channel6_IRQHandler';
procedure DMA2_Channel7_IRQHandler; external name 'DMA2_Channel7_IRQHandler';
procedure LPUART1_IRQHandler; external name 'LPUART1_IRQHandler';
procedure QUADSPI_IRQHandler; external name 'QUADSPI_IRQHandler';
procedure I2C3_EV_IRQHandler; external name 'I2C3_EV_IRQHandler';
procedure I2C3_ER_IRQHandler; external name 'I2C3_ER_IRQHandler';
procedure SAI1_IRQHandler; external name 'SAI1_IRQHandler';
procedure SAI2_IRQHandler; external name 'SAI2_IRQHandler';
procedure SWPMI1_IRQHandler; external name 'SWPMI1_IRQHandler';
procedure TSC_IRQHandler; external name 'TSC_IRQHandler';
procedure LCD_IRQHandler; external name 'LCD_IRQHandler';
procedure RNG_IRQHandler; external name 'RNG_IRQHandler';
procedure FPU_IRQHandler; external name 'FPU_IRQHandler';


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
  .long TAMP_STAMP_IRQHandler
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
  .long ADC1_2_IRQHandler
  .long CAN1_TX_IRQHandler
  .long CAN1_RX0_IRQHandler
  .long CAN1_RX1_IRQHandler
  .long CAN1_SCE_IRQHandler
  .long EXTI9_5_IRQHandler
  .long TIM1_BRK_TIM15_IRQHandler
  .long TIM1_UP_TIM16_IRQHandler
  .long TIM1_TRG_COM_TIM17_IRQHandler
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
  .long DFSDM1_FLT3_IRQHandler
  .long TIM8_BRK_IRQHandler
  .long TIM8_UP_IRQHandler
  .long TIM8_TRG_COM_IRQHandler
  .long TIM8_CC_IRQHandler
  .long ADC3_IRQHandler
  .long FMC_IRQHandler
  .long SDMMC1_IRQHandler
  .long TIM5_IRQHandler
  .long SPI3_IRQHandler
  .long UART4_IRQHandler
  .long UART5_IRQHandler
  .long TIM6_DAC_IRQHandler
  .long TIM7_IRQHandler
  .long DMA2_Channel1_IRQHandler
  .long DMA2_Channel2_IRQHandler
  .long DMA2_Channel3_IRQHandler
  .long DMA2_Channel4_IRQHandler
  .long DMA2_Channel5_IRQHandler
  .long DFSDM1_FLT0_IRQHandler
  .long DFSDM1_FLT1_IRQHandler
  .long DFSDM1_FLT2_IRQHandler
  .long COMP_IRQHandler
  .long LPTIM1_IRQHandler
  .long LPTIM2_IRQHandler
  .long OTG_FS_IRQHandler
  .long DMA2_Channel6_IRQHandler
  .long DMA2_Channel7_IRQHandler
  .long LPUART1_IRQHandler
  .long QUADSPI_IRQHandler
  .long I2C3_EV_IRQHandler
  .long I2C3_ER_IRQHandler
  .long SAI1_IRQHandler
  .long SAI2_IRQHandler
  .long SWPMI1_IRQHandler
  .long TSC_IRQHandler
  .long LCD_IRQHandler
  .long 0
  .long RNG_IRQHandler
  .long FPU_IRQHandler

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
  .weak TAMP_STAMP_IRQHandler
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
  .weak ADC1_2_IRQHandler
  .weak CAN1_TX_IRQHandler
  .weak CAN1_RX0_IRQHandler
  .weak CAN1_RX1_IRQHandler
  .weak CAN1_SCE_IRQHandler
  .weak EXTI9_5_IRQHandler
  .weak TIM1_BRK_TIM15_IRQHandler
  .weak TIM1_UP_TIM16_IRQHandler
  .weak TIM1_TRG_COM_TIM17_IRQHandler
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
  .weak DFSDM1_FLT3_IRQHandler
  .weak TIM8_BRK_IRQHandler
  .weak TIM8_UP_IRQHandler
  .weak TIM8_TRG_COM_IRQHandler
  .weak TIM8_CC_IRQHandler
  .weak ADC3_IRQHandler
  .weak FMC_IRQHandler
  .weak SDMMC1_IRQHandler
  .weak TIM5_IRQHandler
  .weak SPI3_IRQHandler
  .weak UART4_IRQHandler
  .weak UART5_IRQHandler
  .weak TIM6_DAC_IRQHandler
  .weak TIM7_IRQHandler
  .weak DMA2_Channel1_IRQHandler
  .weak DMA2_Channel2_IRQHandler
  .weak DMA2_Channel3_IRQHandler
  .weak DMA2_Channel4_IRQHandler
  .weak DMA2_Channel5_IRQHandler
  .weak DFSDM1_FLT0_IRQHandler
  .weak DFSDM1_FLT1_IRQHandler
  .weak DFSDM1_FLT2_IRQHandler
  .weak COMP_IRQHandler
  .weak LPTIM1_IRQHandler
  .weak LPTIM2_IRQHandler
  .weak OTG_FS_IRQHandler
  .weak DMA2_Channel6_IRQHandler
  .weak DMA2_Channel7_IRQHandler
  .weak LPUART1_IRQHandler
  .weak QUADSPI_IRQHandler
  .weak I2C3_EV_IRQHandler
  .weak I2C3_ER_IRQHandler
  .weak SAI1_IRQHandler
  .weak SAI2_IRQHandler
  .weak SWPMI1_IRQHandler
  .weak TSC_IRQHandler
  .weak LCD_IRQHandler
  .weak RNG_IRQHandler
  .weak FPU_IRQHandler

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
  .set TAMP_STAMP_IRQHandler, Haltproc
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
  .set ADC1_2_IRQHandler, Haltproc
  .set CAN1_TX_IRQHandler, Haltproc
  .set CAN1_RX0_IRQHandler, Haltproc
  .set CAN1_RX1_IRQHandler, Haltproc
  .set CAN1_SCE_IRQHandler, Haltproc
  .set EXTI9_5_IRQHandler, Haltproc
  .set TIM1_BRK_TIM15_IRQHandler, Haltproc
  .set TIM1_UP_TIM16_IRQHandler, Haltproc
  .set TIM1_TRG_COM_TIM17_IRQHandler, Haltproc
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
  .set DFSDM1_FLT3_IRQHandler, Haltproc
  .set TIM8_BRK_IRQHandler, Haltproc
  .set TIM8_UP_IRQHandler, Haltproc
  .set TIM8_TRG_COM_IRQHandler, Haltproc
  .set TIM8_CC_IRQHandler, Haltproc
  .set ADC3_IRQHandler, Haltproc
  .set FMC_IRQHandler, Haltproc
  .set SDMMC1_IRQHandler, Haltproc
  .set TIM5_IRQHandler, Haltproc
  .set SPI3_IRQHandler, Haltproc
  .set UART4_IRQHandler, Haltproc
  .set UART5_IRQHandler, Haltproc
  .set TIM6_DAC_IRQHandler, Haltproc
  .set TIM7_IRQHandler, Haltproc
  .set DMA2_Channel1_IRQHandler, Haltproc
  .set DMA2_Channel2_IRQHandler, Haltproc
  .set DMA2_Channel3_IRQHandler, Haltproc
  .set DMA2_Channel4_IRQHandler, Haltproc
  .set DMA2_Channel5_IRQHandler, Haltproc
  .set DFSDM1_FLT0_IRQHandler, Haltproc
  .set DFSDM1_FLT1_IRQHandler, Haltproc
  .set DFSDM1_FLT2_IRQHandler, Haltproc
  .set COMP_IRQHandler, Haltproc
  .set LPTIM1_IRQHandler, Haltproc
  .set LPTIM2_IRQHandler, Haltproc
  .set OTG_FS_IRQHandler, Haltproc
  .set DMA2_Channel6_IRQHandler, Haltproc
  .set DMA2_Channel7_IRQHandler, Haltproc
  .set LPUART1_IRQHandler, Haltproc
  .set QUADSPI_IRQHandler, Haltproc
  .set I2C3_EV_IRQHandler, Haltproc
  .set I2C3_ER_IRQHandler, Haltproc
  .set SAI1_IRQHandler, Haltproc
  .set SAI2_IRQHandler, Haltproc
  .set SWPMI1_IRQHandler, Haltproc
  .set TSC_IRQHandler, Haltproc
  .set LCD_IRQHandler, Haltproc
  .set RNG_IRQHandler, Haltproc
  .set FPU_IRQHandler, Haltproc

  .text
  end;
end.
