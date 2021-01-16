unit stm32g441xx;
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
    RTC_TAMP_LSECSS_IRQn = 2,         
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
    ADC1_2_IRQn = 18,                 
    USB_HP_IRQn = 19,                 
    USB_LP_IRQn = 20,                 
    FDCAN1_IT0_IRQn = 21,             
    FDCAN1_IT1_IRQn = 22,             
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
    USBWakeUp_IRQn = 42,              
    TIM8_BRK_IRQn = 43,               
    TIM8_UP_IRQn = 44,                
    TIM8_TRG_COM_IRQn = 45,           
    TIM8_CC_IRQn = 46,                
    LPTIM1_IRQn = 49,                 
    SPI3_IRQn   = 51,                 
    UART4_IRQn  = 52,                 
    TIM6_DAC_IRQn = 54,               
    TIM7_IRQn   = 55,                 
    DMA2_Channel1_IRQn = 56,          
    DMA2_Channel2_IRQn = 57,          
    DMA2_Channel3_IRQn = 58,          
    DMA2_Channel4_IRQn = 59,          
    DMA2_Channel5_IRQn = 60,          
    UCPD1_IRQn  = 63,                 
    COMP1_2_3_IRQn = 64,              
    COMP4_IRQn  = 65,                 
    CRS_IRQn    = 75,                 
    SAI1_IRQn   = 76,                 
    FPU_IRQn    = 81,                 
    AES_IRQn    = 85,                 
    RNG_IRQn    = 90,                 
    LPUART1_IRQn = 91,                
    I2C3_EV_IRQn = 92,                
    I2C3_ER_IRQn = 93,                
    DMAMUX_OVR_IRQn = 94,             
    DMA2_Channel6_IRQn = 97,          
    CORDIC_IRQn = 100,                
    FMAC_IRQn   = 101                 
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
    RESERVED10  : array[0..1] of longword;
    GCOMP       : longword;
  end;

  TADC_Common_Registers = record
    CSR         : longword;
    RESERVED1   : longword;
    CCR         : longword;
    CDR         : longword;
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
    RXGFC       : longword;
    XIDAM       : longword;
    HPMS        : longword;
    RESERVED5   : longword;
    RXF0S       : longword;
    RXF0A       : longword;
    RXF1S       : longword;
    RXF1A       : longword;
    RESERVED6   : array[0..7] of longword;
    TXBC        : longword;
    TXFQS       : longword;
    TXBRP       : longword;
    TXBAR       : longword;
    TXBCR       : longword;
    TXBTO       : longword;
    TXBCF       : longword;
    TXBTIE      : longword;
    TXBCIE      : longword;
    TXEFS       : longword;
    TXEFA       : longword;
  end;

  TFDCAN_Config_Registers = record
    CKDIV       : longword;
  end;

  TCOMP_Registers = record
    CSR         : longword;
  end;

  TCRC_Registers = record
    DR          : longword;
    IDR         : longword;
    CR          : longword;
    RESERVED0   : longword;
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
    RESERVED    : array[0..1] of longword;
    STR1        : longword;
    STR2        : longword;
    STMODR      : longword;
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
    RESERVED2   : array[0..14] of longword;
    SEC1R       : longword;
  end;

  TFMAC_Registers = record
    X1BUFCFG    : longword;
    X2BUFCFG    : longword;
    YBUFCFG     : longword;
    PARAM       : longword;
    CR          : longword;
    SR          : longword;
    WDATA       : longword;
    RDATA       : longword;
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

  TOPAMP_Registers = record
    CSR         : longword;
    RESERVED    : array[0..4] of longword;
    TCMR        : longword;
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
    RESERVED1   : array[0..9] of longword;
    CR5         : longword;
  end;

  TRCC_Registers = record
    CR          : longword;
    ICSCR       : longword;
    CFGR        : longword;
    PLLCFGR     : longword;
    RESERVED0   : longword;
    RESERVED1   : longword;
    CIER        : longword;
    CIFR        : longword;
    CICR        : longword;
    RESERVED2   : longword;
    AHB1RSTR    : longword;
    AHB2RSTR    : longword;
    AHB3RSTR    : longword;
    RESERVED3   : longword;
    APB1RSTR1   : longword;
    APB1RSTR2   : longword;
    APB2RSTR    : longword;
    RESERVED4   : longword;
    AHB1ENR     : longword;
    AHB2ENR     : longword;
    AHB3ENR     : longword;
    RESERVED5   : longword;
    APB1ENR1    : longword;
    APB1ENR2    : longword;
    APB2ENR     : longword;
    RESERVED6   : longword;
    AHB1SMENR   : longword;
    AHB2SMENR   : longword;
    AHB3SMENR   : longword;
    RESERVED7   : longword;
    APB1SMENR1  : longword;
    APB1SMENR2  : longword;
    APB2SMENR   : longword;
    RESERVED8   : longword;
    CCIPR       : longword;
    RESERVED9   : longword;
    BDCR        : longword;
    CSR         : longword;
    CRRCR       : longword;
    CCIPR2      : longword;
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
  end;

  TTAMP_Registers = record
    CR1         : longword;
    CR2         : longword;
    RESERVED0   : longword;
    FLTCR       : longword;
    RESERVED1   : array[0..5] of longword;
    RESERVED2   : longword;
    IER         : longword;
    SR          : longword;
    MISR        : longword;
    RESERVED3   : longword;
    SCR         : longword;
    RESERVED4   : array[0..47] of longword;
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

  TSPI_Registers = record
    CR1         : longword;
    CR2         : longword;
    SR          : longword;
    DR          : longword;
    CRCPR       : longword;
    RXCRCR      : longword;
    TXCRCR      : longword;
    I2SCFGR     : longword;
    I2SPR       : longword;
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
    CCR5        : longword;
    CCR6        : longword;
    CCMR3       : longword;
    DTR2        : longword;
    ECR         : longword;
    TISEL       : longword;
    AF1         : longword;
    AF2         : longword;
    &OR         : longword;
    RESERVED0   : array[0..219] of longword;
    DCR         : longword;
    DMAR        : longword;
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

  TVREFBUF_Registers = record
    CSR         : longword;
    CCR         : longword;
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

  TCORDIC_Registers = record
    CSR         : longword;
    WDATA       : longword;
    RDATA       : longword;
  end;

  TUCPD_Registers = record
    CFG1        : longword;
    CFG2        : longword;
    RESERVED0   : longword;
    CR          : longword;
    IMR         : longword;
    SR          : longword;
    ICR         : longword;
    TX_ORDSET   : longword;
    TX_PAYSZ    : longword;
    TXDR        : longword;
    RX_ORDSET   : longword;
    RX_PAYSZ    : longword;
    RXDR        : longword;
    RX_ORDEXT1  : longword;
    RX_ORDEXT2  : longword;
  end;

const
  __NVIC_PRIO_BITS= 4;
  FLASH_BASE    = $08000000;
  SRAM1_BASE    = $20000000;
  SRAM2_BASE    = $20004000;
  CCMSRAM_BASE  = $10000000;
  PERIPH_BASE   = $40000000;
  SRAM1_BB_BASE = $22000000;
  SRAM2_BB_BASE = $22080000;
  CCMSRAM_BB_BASE= $220B0000;
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
  TIM6_BASE     = APB1PERIPH_BASE + $1000;
  TIM7_BASE     = APB1PERIPH_BASE + $1400;
  CRS_BASE      = APB1PERIPH_BASE + $2000;
  TAMP_BASE     = APB1PERIPH_BASE + $2400;
  RTC_BASE      = APB1PERIPH_BASE + $2800;
  WWDG_BASE     = APB1PERIPH_BASE + $2C00;
  IWDG_BASE     = APB1PERIPH_BASE + $3000;
  SPI2_BASE     = APB1PERIPH_BASE + $3800;
  SPI3_BASE     = APB1PERIPH_BASE + $3C00;
  USART2_BASE   = APB1PERIPH_BASE + $4400;
  USART3_BASE   = APB1PERIPH_BASE + $4800;
  UART4_BASE    = APB1PERIPH_BASE + $4C00;
  I2C1_BASE     = APB1PERIPH_BASE + $5400;
  I2C2_BASE     = APB1PERIPH_BASE + $5800;
  USB_BASE      = APB1PERIPH_BASE + $5C00;
  FDCAN1_BASE   = APB1PERIPH_BASE + $6400;
  FDCAN_CONFIG_BASE= APB1PERIPH_BASE + $6500;
  PWR_BASE      = APB1PERIPH_BASE + $7000;
  I2C3_BASE     = APB1PERIPH_BASE + $7800;
  LPTIM1_BASE   = APB1PERIPH_BASE + $7C00;
  LPUART1_BASE  = APB1PERIPH_BASE + $8000;
  UCPD1_BASE    = APB1PERIPH_BASE + $A000;
  SRAMCAN_BASE  = APB1PERIPH_BASE + $A400;
  SYSCFG_BASE   = APB2PERIPH_BASE + $0000;
  VREFBUF_BASE  = APB2PERIPH_BASE + $0030;
  COMP1_BASE    = APB2PERIPH_BASE + $0200;
  COMP2_BASE    = APB2PERIPH_BASE + $0204;
  COMP3_BASE    = APB2PERIPH_BASE + $0208;
  COMP4_BASE    = APB2PERIPH_BASE + $020C;
  OPAMP_BASE    = APB2PERIPH_BASE + $0300;
  OPAMP1_BASE   = APB2PERIPH_BASE + $0300;
  OPAMP2_BASE   = APB2PERIPH_BASE + $0304;
  OPAMP3_BASE   = APB2PERIPH_BASE + $0308;
  EXTI_BASE     = APB2PERIPH_BASE + $0400;
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
  DMA1_BASE     = AHB1PERIPH_BASE;
  DMA2_BASE     = AHB1PERIPH_BASE + $0400;
  DMAMUX1_BASE  = AHB1PERIPH_BASE + $0800;
  CORDIC_BASE   = AHB1PERIPH_BASE + $0C00;
  RCC_BASE      = AHB1PERIPH_BASE + $1000;
  FMAC_BASE     = AHB1PERIPH_BASE + $1400;
  FLASH_R_BASE  = AHB1PERIPH_BASE + $2000;
  CRC_BASE      = AHB1PERIPH_BASE + $3000;
  DMA1_Channel1_BASE= DMA1_BASE + $0008;
  DMA1_Channel2_BASE= DMA1_BASE + $001C;
  DMA1_Channel3_BASE= DMA1_BASE + $0030;
  DMA1_Channel4_BASE= DMA1_BASE + $0044;
  DMA1_Channel5_BASE= DMA1_BASE + $0058;
  DMA1_Channel6_BASE= DMA1_BASE + $006C;
  DMA2_Channel1_BASE= DMA2_BASE + $0008;
  DMA2_Channel2_BASE= DMA2_BASE + $001C;
  DMA2_Channel3_BASE= DMA2_BASE + $0030;
  DMA2_Channel4_BASE= DMA2_BASE + $0044;
  DMA2_Channel5_BASE= DMA2_BASE + $0058;
  DMA2_Channel6_BASE= DMA2_BASE + $006C;
  DMAMUX1_Channel0_BASE= DMAMUX1_BASE;
  DMAMUX1_Channel1_BASE= DMAMUX1_BASE + $0004;
  DMAMUX1_Channel2_BASE= DMAMUX1_BASE + $0008;
  DMAMUX1_Channel3_BASE= DMAMUX1_BASE + $000C;
  DMAMUX1_Channel4_BASE= DMAMUX1_BASE + $0010;
  DMAMUX1_Channel5_BASE= DMAMUX1_BASE + $0014;
  DMAMUX1_Channel6_BASE= DMAMUX1_BASE + $0020;
  DMAMUX1_Channel7_BASE= DMAMUX1_BASE + $0024;
  DMAMUX1_Channel8_BASE= DMAMUX1_BASE + $0028;
  DMAMUX1_Channel9_BASE= DMAMUX1_BASE + $002C;
  DMAMUX1_Channel10_BASE= DMAMUX1_BASE + $0030;
  DMAMUX1_Channel11_BASE= DMAMUX1_BASE + $0034;
  DMAMUX1_RequestGenerator0_BASE= DMAMUX1_BASE + $0100;
  DMAMUX1_RequestGenerator1_BASE= DMAMUX1_BASE + $0104;
  DMAMUX1_RequestGenerator2_BASE= DMAMUX1_BASE + $0108;
  DMAMUX1_RequestGenerator3_BASE= DMAMUX1_BASE + $010C;
  DMAMUX1_ChannelStatus_BASE= DMAMUX1_BASE + $0080;
  DMAMUX1_RequestGenStatus_BASE= DMAMUX1_BASE + $0140;
  GPIOA_BASE    = AHB2PERIPH_BASE + $0000;
  GPIOB_BASE    = AHB2PERIPH_BASE + $0400;
  GPIOC_BASE    = AHB2PERIPH_BASE + $0800;
  GPIOD_BASE    = AHB2PERIPH_BASE + $0C00;
  GPIOE_BASE    = AHB2PERIPH_BASE + $1000;
  GPIOF_BASE    = AHB2PERIPH_BASE + $1400;
  GPIOG_BASE    = AHB2PERIPH_BASE + $1800;
  ADC1_BASE     = AHB2PERIPH_BASE + $08000000;
  ADC2_BASE     = AHB2PERIPH_BASE + $08000100;
  ADC12_COMMON_BASE= AHB2PERIPH_BASE + $08000300;
  DAC_BASE      = AHB2PERIPH_BASE + $08000800;
  DAC1_BASE     = AHB2PERIPH_BASE + $08000800;
  DAC3_BASE     = AHB2PERIPH_BASE + $08001000;
  AES_BASE      = AHB2PERIPH_BASE + $08060000;
  RNG_BASE      = AHB2PERIPH_BASE + $08060800;
  DBGMCU_BASE   = $E0042000;
  PACKAGE_BASE  = $1FFF7500;
  UID_BASE      = $1FFF7590;
  FLASHSIZE_BASE= $1FFF75E0;

var
  TIM2          : TTIM_Registers absolute TIM2_BASE;
  TIM3          : TTIM_Registers absolute TIM3_BASE;
  TIM4          : TTIM_Registers absolute TIM4_BASE;
  TIM6          : TTIM_Registers absolute TIM6_BASE;
  TIM7          : TTIM_Registers absolute TIM7_BASE;
  CRS           : TCRS_Registers absolute CRS_BASE;
  TAMP          : TTAMP_Registers absolute TAMP_BASE;
  RTC           : TRTC_Registers absolute RTC_BASE;
  WWDG          : TWWDG_Registers absolute WWDG_BASE;
  IWDG          : TIWDG_Registers absolute IWDG_BASE;
  SPI2          : TSPI_Registers absolute SPI2_BASE;
  SPI3          : TSPI_Registers absolute SPI3_BASE;
  USART2        : TUSART_Registers absolute USART2_BASE;
  USART3        : TUSART_Registers absolute USART3_BASE;
  UART4         : TUSART_Registers absolute UART4_BASE;
  I2C1          : TI2C_Registers absolute I2C1_BASE;
  I2C2          : TI2C_Registers absolute I2C2_BASE;
  USB           : TUSB_Registers absolute USB_BASE;
  FDCAN_CONFIG  : TFDCAN_Config_Registers absolute FDCAN_CONFIG_BASE;
  PWR           : TPWR_Registers absolute PWR_BASE;
  I2C3          : TI2C_Registers absolute I2C3_BASE;
  LPTIM1        : TLPTIM_Registers absolute LPTIM1_BASE;
  LPUART1       : TUSART_Registers absolute LPUART1_BASE;
  UCPD1         : TUCPD_Registers absolute UCPD1_BASE;
  SYSCFG        : TSYSCFG_Registers absolute SYSCFG_BASE;
  VREFBUF       : TVREFBUF_Registers absolute VREFBUF_BASE;
  COMP1         : TCOMP_Registers absolute COMP1_BASE;
  COMP2         : TCOMP_Registers absolute COMP2_BASE;
  COMP3         : TCOMP_Registers absolute COMP3_BASE;
  COMP4         : TCOMP_Registers absolute COMP4_BASE;
  OPAMP         : TOPAMP_Registers absolute OPAMP_BASE;
  OPAMP1        : TOPAMP_Registers absolute OPAMP1_BASE;
  OPAMP2        : TOPAMP_Registers absolute OPAMP2_BASE;
  OPAMP3        : TOPAMP_Registers absolute OPAMP3_BASE;
  EXTI          : TEXTI_Registers absolute EXTI_BASE;
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
  DMA1          : TDMA_Registers absolute DMA1_BASE;
  DMA2          : TDMA_Registers absolute DMA2_BASE;
  DMAMUX1       : TDMAMUX_Channel_Registers absolute DMAMUX1_BASE;
  CORDIC        : TCORDIC_Registers absolute CORDIC_BASE;
  RCC           : TRCC_Registers absolute RCC_BASE;
  FMAC          : TFMAC_Registers absolute FMAC_BASE;
  FLASH         : TFLASH_Registers absolute FLASH_R_BASE;
  CRC           : TCRC_Registers absolute CRC_BASE;
  GPIOA         : TGPIO_Registers absolute GPIOA_BASE;
  GPIOB         : TGPIO_Registers absolute GPIOB_BASE;
  GPIOC         : TGPIO_Registers absolute GPIOC_BASE;
  GPIOD         : TGPIO_Registers absolute GPIOD_BASE;
  GPIOE         : TGPIO_Registers absolute GPIOE_BASE;
  GPIOF         : TGPIO_Registers absolute GPIOF_BASE;
  GPIOG         : TGPIO_Registers absolute GPIOG_BASE;
  ADC1          : TADC_Registers absolute ADC1_BASE;
  ADC2          : TADC_Registers absolute ADC2_BASE;
  ADC12_COMMON  : TADC_Common_Registers absolute ADC12_COMMON_BASE;
  DAC           : TDAC_Registers absolute DAC_BASE;
  DAC1          : TDAC_Registers absolute DAC1_BASE;
  DAC3          : TDAC_Registers absolute DAC3_BASE;
  AES           : TAES_Registers absolute AES_BASE;
  RNG           : TRNG_Registers absolute RNG_BASE;
  DMA1_Channel1 : TDMA_Channel_Registers absolute DMA1_Channel1_BASE;
  DMA1_Channel2 : TDMA_Channel_Registers absolute DMA1_Channel2_BASE;
  DMA1_Channel3 : TDMA_Channel_Registers absolute DMA1_Channel3_BASE;
  DMA1_Channel4 : TDMA_Channel_Registers absolute DMA1_Channel4_BASE;
  DMA1_Channel5 : TDMA_Channel_Registers absolute DMA1_Channel5_BASE;
  DMA1_Channel6 : TDMA_Channel_Registers absolute DMA1_Channel6_BASE;
  DMA2_Channel1 : TDMA_Channel_Registers absolute DMA2_Channel1_BASE;
  DMA2_Channel2 : TDMA_Channel_Registers absolute DMA2_Channel2_BASE;
  DMA2_Channel3 : TDMA_Channel_Registers absolute DMA2_Channel3_BASE;
  DMA2_Channel4 : TDMA_Channel_Registers absolute DMA2_Channel4_BASE;
  DMA2_Channel5 : TDMA_Channel_Registers absolute DMA2_Channel5_BASE;
  DMA2_Channel6 : TDMA_Channel_Registers absolute DMA2_Channel6_BASE;
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
  DMAMUX1_RequestGenerator0: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator0_BASE;
  DMAMUX1_RequestGenerator1: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator1_BASE;
  DMAMUX1_RequestGenerator2: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator2_BASE;
  DMAMUX1_RequestGenerator3: TDMAMUX_RequestGen_Registers absolute DMAMUX1_RequestGenerator3_BASE;
  DMAMUX1_ChannelStatus: TDMAMUX_ChannelStatus_Registers absolute DMAMUX1_ChannelStatus_BASE;
  DMAMUX1_RequestGenStatus: TDMAMUX_RequestGenStatus_Registers absolute DMAMUX1_RequestGenStatus_BASE;
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
procedure RTC_TAMP_LSECSS_IRQHandler; external name 'RTC_TAMP_LSECSS_IRQHandler';
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
procedure ADC1_2_IRQHandler; external name 'ADC1_2_IRQHandler';
procedure USB_HP_IRQHandler; external name 'USB_HP_IRQHandler';
procedure USB_LP_IRQHandler; external name 'USB_LP_IRQHandler';
procedure FDCAN1_IT0_IRQHandler; external name 'FDCAN1_IT0_IRQHandler';
procedure FDCAN1_IT1_IRQHandler; external name 'FDCAN1_IT1_IRQHandler';
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
procedure USBWakeUp_IRQHandler; external name 'USBWakeUp_IRQHandler';
procedure TIM8_BRK_IRQHandler; external name 'TIM8_BRK_IRQHandler';
procedure TIM8_UP_IRQHandler; external name 'TIM8_UP_IRQHandler';
procedure TIM8_TRG_COM_IRQHandler; external name 'TIM8_TRG_COM_IRQHandler';
procedure TIM8_CC_IRQHandler; external name 'TIM8_CC_IRQHandler';
procedure LPTIM1_IRQHandler; external name 'LPTIM1_IRQHandler';
procedure SPI3_IRQHandler; external name 'SPI3_IRQHandler';
procedure UART4_IRQHandler; external name 'UART4_IRQHandler';
procedure TIM6_DAC_IRQHandler; external name 'TIM6_DAC_IRQHandler';
procedure TIM7_IRQHandler; external name 'TIM7_IRQHandler';
procedure DMA2_Channel1_IRQHandler; external name 'DMA2_Channel1_IRQHandler';
procedure DMA2_Channel2_IRQHandler; external name 'DMA2_Channel2_IRQHandler';
procedure DMA2_Channel3_IRQHandler; external name 'DMA2_Channel3_IRQHandler';
procedure DMA2_Channel4_IRQHandler; external name 'DMA2_Channel4_IRQHandler';
procedure DMA2_Channel5_IRQHandler; external name 'DMA2_Channel5_IRQHandler';
procedure UCPD1_IRQHandler; external name 'UCPD1_IRQHandler';
procedure COMP1_2_3_IRQHandler; external name 'COMP1_2_3_IRQHandler';
procedure COMP4_IRQHandler; external name 'COMP4_IRQHandler';
procedure CRS_IRQHandler; external name 'CRS_IRQHandler';
procedure SAI1_IRQHandler; external name 'SAI1_IRQHandler';
procedure FPU_IRQHandler; external name 'FPU_IRQHandler';
procedure AES_IRQHandler; external name 'AES_IRQHandler';
procedure RNG_IRQHandler; external name 'RNG_IRQHandler';
procedure LPUART1_IRQHandler; external name 'LPUART1_IRQHandler';
procedure I2C3_EV_IRQHandler; external name 'I2C3_EV_IRQHandler';
procedure I2C3_ER_IRQHandler; external name 'I2C3_ER_IRQHandler';
procedure DMAMUX_OVR_IRQHandler; external name 'DMAMUX_OVR_IRQHandler';
procedure DMA2_Channel6_IRQHandler; external name 'DMA2_Channel6_IRQHandler';
procedure CORDIC_IRQHandler; external name 'CORDIC_IRQHandler';
procedure FMAC_IRQHandler; external name 'FMAC_IRQHandler';


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
  .long RTC_TAMP_LSECSS_IRQHandler
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
  .long 0
  .long ADC1_2_IRQHandler
  .long USB_HP_IRQHandler
  .long USB_LP_IRQHandler
  .long FDCAN1_IT0_IRQHandler
  .long FDCAN1_IT1_IRQHandler
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
  .long USBWakeUp_IRQHandler
  .long TIM8_BRK_IRQHandler
  .long TIM8_UP_IRQHandler
  .long TIM8_TRG_COM_IRQHandler
  .long TIM8_CC_IRQHandler
  .long 0
  .long 0
  .long LPTIM1_IRQHandler
  .long 0
  .long SPI3_IRQHandler
  .long UART4_IRQHandler
  .long 0
  .long TIM6_DAC_IRQHandler
  .long TIM7_IRQHandler
  .long DMA2_Channel1_IRQHandler
  .long DMA2_Channel2_IRQHandler
  .long DMA2_Channel3_IRQHandler
  .long DMA2_Channel4_IRQHandler
  .long DMA2_Channel5_IRQHandler
  .long 0
  .long 0
  .long UCPD1_IRQHandler
  .long COMP1_2_3_IRQHandler
  .long COMP4_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long CRS_IRQHandler
  .long SAI1_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long FPU_IRQHandler
  .long 0
  .long 0
  .long 0
  .long AES_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long RNG_IRQHandler
  .long LPUART1_IRQHandler
  .long I2C3_EV_IRQHandler
  .long I2C3_ER_IRQHandler
  .long DMAMUX_OVR_IRQHandler
  .long 0
  .long 0
  .long DMA2_Channel6_IRQHandler
  .long 0
  .long 0
  .long CORDIC_IRQHandler
  .long FMAC_IRQHandler

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
  .weak RTC_TAMP_LSECSS_IRQHandler
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
  .weak ADC1_2_IRQHandler
  .weak USB_HP_IRQHandler
  .weak USB_LP_IRQHandler
  .weak FDCAN1_IT0_IRQHandler
  .weak FDCAN1_IT1_IRQHandler
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
  .weak USBWakeUp_IRQHandler
  .weak TIM8_BRK_IRQHandler
  .weak TIM8_UP_IRQHandler
  .weak TIM8_TRG_COM_IRQHandler
  .weak TIM8_CC_IRQHandler
  .weak LPTIM1_IRQHandler
  .weak SPI3_IRQHandler
  .weak UART4_IRQHandler
  .weak TIM6_DAC_IRQHandler
  .weak TIM7_IRQHandler
  .weak DMA2_Channel1_IRQHandler
  .weak DMA2_Channel2_IRQHandler
  .weak DMA2_Channel3_IRQHandler
  .weak DMA2_Channel4_IRQHandler
  .weak DMA2_Channel5_IRQHandler
  .weak UCPD1_IRQHandler
  .weak COMP1_2_3_IRQHandler
  .weak COMP4_IRQHandler
  .weak CRS_IRQHandler
  .weak SAI1_IRQHandler
  .weak FPU_IRQHandler
  .weak AES_IRQHandler
  .weak RNG_IRQHandler
  .weak LPUART1_IRQHandler
  .weak I2C3_EV_IRQHandler
  .weak I2C3_ER_IRQHandler
  .weak DMAMUX_OVR_IRQHandler
  .weak DMA2_Channel6_IRQHandler
  .weak CORDIC_IRQHandler
  .weak FMAC_IRQHandler

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
  .set RTC_TAMP_LSECSS_IRQHandler, Haltproc
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
  .set ADC1_2_IRQHandler, Haltproc
  .set USB_HP_IRQHandler, Haltproc
  .set USB_LP_IRQHandler, Haltproc
  .set FDCAN1_IT0_IRQHandler, Haltproc
  .set FDCAN1_IT1_IRQHandler, Haltproc
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
  .set USBWakeUp_IRQHandler, Haltproc
  .set TIM8_BRK_IRQHandler, Haltproc
  .set TIM8_UP_IRQHandler, Haltproc
  .set TIM8_TRG_COM_IRQHandler, Haltproc
  .set TIM8_CC_IRQHandler, Haltproc
  .set LPTIM1_IRQHandler, Haltproc
  .set SPI3_IRQHandler, Haltproc
  .set UART4_IRQHandler, Haltproc
  .set TIM6_DAC_IRQHandler, Haltproc
  .set TIM7_IRQHandler, Haltproc
  .set DMA2_Channel1_IRQHandler, Haltproc
  .set DMA2_Channel2_IRQHandler, Haltproc
  .set DMA2_Channel3_IRQHandler, Haltproc
  .set DMA2_Channel4_IRQHandler, Haltproc
  .set DMA2_Channel5_IRQHandler, Haltproc
  .set UCPD1_IRQHandler, Haltproc
  .set COMP1_2_3_IRQHandler, Haltproc
  .set COMP4_IRQHandler, Haltproc
  .set CRS_IRQHandler, Haltproc
  .set SAI1_IRQHandler, Haltproc
  .set FPU_IRQHandler, Haltproc
  .set AES_IRQHandler, Haltproc
  .set RNG_IRQHandler, Haltproc
  .set LPUART1_IRQHandler, Haltproc
  .set I2C3_EV_IRQHandler, Haltproc
  .set I2C3_ER_IRQHandler, Haltproc
  .set DMAMUX_OVR_IRQHandler, Haltproc
  .set DMA2_Channel6_IRQHandler, Haltproc
  .set CORDIC_IRQHandler, Haltproc
  .set FMAC_IRQHandler, Haltproc

  .text
  end;
end.
