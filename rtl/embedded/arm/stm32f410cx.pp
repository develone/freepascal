unit stm32f410cx;
interface
{$PACKRECORDS C}
{$GOTO ON}
{$SCOPEDENUMS ON}

type
  TIRQn_Enum = (
    NonMaskableInt_IRQn = -14,        
    MemoryManagement_IRQn = -12,      
    BusFault_IRQn = -11,              
    UsageFault_IRQn = -10,            
    SVCall_IRQn = -5,                 
    DebugMonitor_IRQn = -4,           
    PendSV_IRQn = -2,                 
    SysTick_IRQn = -1,                
    WWDG_IRQn   = 0,                  
    PVD_IRQn    = 1,                  
    TAMP_STAMP_IRQn = 2,              
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
    EXTI9_5_IRQn = 23,                
    TIM1_BRK_TIM9_IRQn = 24,          
    TIM1_UP_IRQn = 25,                
    TIM1_TRG_COM_TIM11_IRQn = 26,     
    TIM1_CC_IRQn = 27,                
    I2C1_EV_IRQn = 31,                
    I2C1_ER_IRQn = 32,                
    I2C2_EV_IRQn = 33,                
    I2C2_ER_IRQn = 34,                
    SPI1_IRQn   = 35,                 
    SPI2_IRQn   = 36,                 
    USART1_IRQn = 37,                 
    USART2_IRQn = 38,                 
    EXTI15_10_IRQn = 40,              
    RTC_Alarm_IRQn = 41,              
    DMA1_Stream7_IRQn = 47,           
    TIM5_IRQn   = 50,                 
    TIM6_DAC_IRQn = 54,               
    DMA2_Stream0_IRQn = 56,           
    DMA2_Stream1_IRQn = 57,           
    DMA2_Stream2_IRQn = 58,           
    DMA2_Stream3_IRQn = 59,           
    DMA2_Stream4_IRQn = 60,           
    DMA2_Stream5_IRQn = 68,           
    DMA2_Stream6_IRQn = 69,           
    DMA2_Stream7_IRQn = 70,           
    USART6_IRQn = 71,                 
    RNG_IRQn    = 80,                 
    FPU_IRQn    = 81,                 
    SPI5_IRQn   = 85,                 
    FMPI2C1_EV_IRQn = 95,             
    FMPI2C1_ER_IRQn = 96,             
    LPTIM1_IRQn = 97                  
  );

  TADC_Registers = record
    SR          : longword;
    CR1         : longword;
    CR2         : longword;
    SMPR1       : longword;
    SMPR2       : longword;
    JOFR1       : longword;
    JOFR2       : longword;
    JOFR3       : longword;
    JOFR4       : longword;
    HTR         : longword;
    LTR         : longword;
    SQR1        : longword;
    SQR2        : longword;
    SQR3        : longword;
    JSQR        : longword;
    JDR1        : longword;
    JDR2        : longword;
    JDR3        : longword;
    JDR4        : longword;
    DR          : longword;
  end;

  TADC_Common_Registers = record
    CSR         : longword;
    CCR         : longword;
    CDR         : longword;
  end;

  TCRC_Registers = record
    DR          : longword;
    IDR         : byte;
    RESERVED0   : byte;
    RESERVED1   : word;
    CR          : longword;
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
  end;

  TDBGMCU_Registers = record
    IDCODE      : longword;
    CR          : longword;
    APB1FZ      : longword;
    APB2FZ      : longword;
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

  TEXTI_Registers = record
    IMR         : longword;
    EMR         : longword;
    RTSR        : longword;
    FTSR        : longword;
    SWIER       : longword;
    PR          : longword;
  end;

  TFLASH_Registers = record
    ACR         : longword;
    KEYR        : longword;
    OPTKEYR     : longword;
    SR          : longword;
    CR          : longword;
    OPTCR       : longword;
    OPTCR1      : longword;
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

  TSYSCFG_Registers = record
    MEMRMP      : longword;
    PMC         : longword;
    EXTICR      : array[0..3] of longword;
    RESERVED    : longword;
    CFGR2       : longword;
    CMPCR       : longword;
    CFGR        : longword;
  end;

  TI2C_Registers = record
    CR1         : longword;
    CR2         : longword;
    OAR1        : longword;
    OAR2        : longword;
    DR          : longword;
    SR1         : longword;
    SR2         : longword;
    CCR         : longword;
    TRISE       : longword;
    FLTR        : longword;
  end;

  TFMPI2C_Registers = record
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
  end;

  TPWR_Registers = record
    CR          : longword;
    CSR         : longword;
  end;

  TRCC_Registers = record
    CR          : longword;
    PLLCFGR     : longword;
    CFGR        : longword;
    CIR         : longword;
    AHB1RSTR    : longword;
    RESERVED0   : array[0..2] of longword;
    APB1RSTR    : longword;
    APB2RSTR    : longword;
    RESERVED1   : array[0..1] of longword;
    AHB1ENR     : longword;
    RESERVED2   : array[0..2] of longword;
    APB1ENR     : longword;
    APB2ENR     : longword;
    RESERVED3   : array[0..1] of longword;
    AHB1LPENR   : longword;
    RESERVED4   : array[0..2] of longword;
    APB1LPENR   : longword;
    APB2LPENR   : longword;
    RESERVED5   : array[0..1] of longword;
    BDCR        : longword;
    CSR         : longword;
    RESERVED6   : array[0..1] of longword;
    SSCGR       : longword;
    RESERVED7   : array[0..1] of longword;
    DCKCFGR     : longword;
    CKGATENR    : longword;
    DCKCFGR2    : longword;
  end;

  TRTC_Registers = record
    TR          : longword;
    DR          : longword;
    CR          : longword;
    ISR         : longword;
    PRER        : longword;
    WUTR        : longword;
    CALIBR      : longword;
    ALRMAR      : longword;
    ALRMBR      : longword;
    WPR         : longword;
    SSR         : longword;
    SHIFTR      : longword;
    TSTR        : longword;
    TSDR        : longword;
    TSSSR       : longword;
    CALR        : longword;
    TAFCR       : longword;
    ALRMASSR    : longword;
    ALRMBSSR    : longword;
    RESERVED7   : longword;
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
    I2SCFGR     : longword;
    I2SPR       : longword;
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
  end;

  TUSART_Registers = record
    SR          : longword;
    DR          : longword;
    BRR         : longword;
    CR1         : longword;
    CR2         : longword;
    CR3         : longword;
    GTPR        : longword;
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

const
  __NVIC_PRIO_BITS= 4;
  FLASH_BASE    = $08000000;
  SRAM1_BASE    = $20000000;
  PERIPH_BASE   = $40000000;
  SRAM1_BB_BASE = $22000000;
  PERIPH_BB_BASE= $42000000;
  FLASH_OTP_BASE= $1FFF7800;
  SRAM_BASE     = SRAM1_BASE;
  SRAM_BB_BASE  = SRAM1_BB_BASE;
  APB1PERIPH_BASE= PERIPH_BASE;
  APB2PERIPH_BASE= PERIPH_BASE + $00010000;
  AHB1PERIPH_BASE= PERIPH_BASE + $00020000;
  TIM5_BASE     = APB1PERIPH_BASE + $0C00;
  TIM6_BASE     = APB1PERIPH_BASE + $1000;
  LPTIM1_BASE   = APB1PERIPH_BASE + $2400;
  RTC_BASE      = APB1PERIPH_BASE + $2800;
  WWDG_BASE     = APB1PERIPH_BASE + $2C00;
  IWDG_BASE     = APB1PERIPH_BASE + $3000;
  I2S2ext_BASE  = APB1PERIPH_BASE + $3400;
  SPI2_BASE     = APB1PERIPH_BASE + $3800;
  USART2_BASE   = APB1PERIPH_BASE + $4400;
  I2C1_BASE     = APB1PERIPH_BASE + $5400;
  I2C2_BASE     = APB1PERIPH_BASE + $5800;
  FMPI2C1_BASE  = APB1PERIPH_BASE + $6000;
  PWR_BASE      = APB1PERIPH_BASE + $7000;
  DAC_BASE      = APB1PERIPH_BASE + $7400;
  TIM1_BASE     = APB2PERIPH_BASE + $0000;
  USART1_BASE   = APB2PERIPH_BASE + $1000;
  USART6_BASE   = APB2PERIPH_BASE + $1400;
  ADC1_BASE     = APB2PERIPH_BASE + $2000;
  ADC1_COMMON_BASE= APB2PERIPH_BASE + $2300;
  ADC_BASE      = ADC1_COMMON_BASE;
  SPI1_BASE     = APB2PERIPH_BASE + $3000;
  SYSCFG_BASE   = APB2PERIPH_BASE + $3800;
  EXTI_BASE     = APB2PERIPH_BASE + $3C00;
  TIM9_BASE     = APB2PERIPH_BASE + $4000;
  TIM11_BASE    = APB2PERIPH_BASE + $4800;
  SPI5_BASE     = APB2PERIPH_BASE + $5000;
  GPIOA_BASE    = AHB1PERIPH_BASE + $0000;
  GPIOB_BASE    = AHB1PERIPH_BASE + $0400;
  GPIOC_BASE    = AHB1PERIPH_BASE + $0800;
  GPIOH_BASE    = AHB1PERIPH_BASE + $1C00;
  CRC_BASE      = AHB1PERIPH_BASE + $3000;
  RCC_BASE      = AHB1PERIPH_BASE + $3800;
  FLASH_R_BASE  = AHB1PERIPH_BASE + $3C00;
  DMA1_BASE     = AHB1PERIPH_BASE + $6000;
  DMA1_Stream0_BASE= DMA1_BASE + $010;
  DMA1_Stream1_BASE= DMA1_BASE + $028;
  DMA1_Stream2_BASE= DMA1_BASE + $040;
  DMA1_Stream3_BASE= DMA1_BASE + $058;
  DMA1_Stream4_BASE= DMA1_BASE + $070;
  DMA1_Stream5_BASE= DMA1_BASE + $088;
  DMA1_Stream6_BASE= DMA1_BASE + $0A0;
  DMA1_Stream7_BASE= DMA1_BASE + $0B8;
  DMA2_BASE     = AHB1PERIPH_BASE + $6400;
  DMA2_Stream0_BASE= DMA2_BASE + $010;
  DMA2_Stream1_BASE= DMA2_BASE + $028;
  DMA2_Stream2_BASE= DMA2_BASE + $040;
  DMA2_Stream3_BASE= DMA2_BASE + $058;
  DMA2_Stream4_BASE= DMA2_BASE + $070;
  DMA2_Stream5_BASE= DMA2_BASE + $088;
  DMA2_Stream6_BASE= DMA2_BASE + $0A0;
  DMA2_Stream7_BASE= DMA2_BASE + $0B8;
  RNG_BASE      = PERIPH_BASE + $80000;
  DBGMCU_BASE   = $E0042000;
  UID_BASE      = $1FFF7A10;
  FLASHSIZE_BASE= $1FFF7A22;
  PACKAGE_BASE  = $1FFF7BF0;

var
  TIM5          : TTIM_Registers absolute TIM5_BASE;
  TIM6          : TTIM_Registers absolute TIM6_BASE;
  RTC           : TRTC_Registers absolute RTC_BASE;
  WWDG          : TWWDG_Registers absolute WWDG_BASE;
  IWDG          : TIWDG_Registers absolute IWDG_BASE;
  SPI2          : TSPI_Registers absolute SPI2_BASE;
  USART2        : TUSART_Registers absolute USART2_BASE;
  I2C1          : TI2C_Registers absolute I2C1_BASE;
  I2C2          : TI2C_Registers absolute I2C2_BASE;
  FMPI2C1       : TFMPI2C_Registers absolute FMPI2C1_BASE;
  LPTIM1        : TLPTIM_Registers absolute LPTIM1_BASE;
  PWR           : TPWR_Registers absolute PWR_BASE;
  DAC1          : TDAC_Registers absolute DAC_BASE;
  DAC           : TDAC_Registers absolute DAC_BASE;
  TIM1          : TTIM_Registers absolute TIM1_BASE;
  USART1        : TUSART_Registers absolute USART1_BASE;
  USART6        : TUSART_Registers absolute USART6_BASE;
  ADC1          : TADC_Registers absolute ADC1_BASE;
  ADC1_COMMON   : TADC_Common_Registers absolute ADC1_COMMON_BASE;
  SPI1          : TSPI_Registers absolute SPI1_BASE;
  SYSCFG        : TSYSCFG_Registers absolute SYSCFG_BASE;
  EXTI          : TEXTI_Registers absolute EXTI_BASE;
  TIM9          : TTIM_Registers absolute TIM9_BASE;
  TIM11         : TTIM_Registers absolute TIM11_BASE;
  SPI5          : TSPI_Registers absolute SPI5_BASE;
  GPIOA         : TGPIO_Registers absolute GPIOA_BASE;
  GPIOB         : TGPIO_Registers absolute GPIOB_BASE;
  GPIOC         : TGPIO_Registers absolute GPIOC_BASE;
  GPIOH         : TGPIO_Registers absolute GPIOH_BASE;
  CRC           : TCRC_Registers absolute CRC_BASE;
  RCC           : TRCC_Registers absolute RCC_BASE;
  FLASH         : TFLASH_Registers absolute FLASH_R_BASE;
  DMA1          : TDMA_Registers absolute DMA1_BASE;
  DMA1_Stream0  : TDMA_Stream_Registers absolute DMA1_Stream0_BASE;
  DMA1_Stream1  : TDMA_Stream_Registers absolute DMA1_Stream1_BASE;
  DMA1_Stream2  : TDMA_Stream_Registers absolute DMA1_Stream2_BASE;
  DMA1_Stream3  : TDMA_Stream_Registers absolute DMA1_Stream3_BASE;
  DMA1_Stream4  : TDMA_Stream_Registers absolute DMA1_Stream4_BASE;
  DMA1_Stream5  : TDMA_Stream_Registers absolute DMA1_Stream5_BASE;
  DMA1_Stream6  : TDMA_Stream_Registers absolute DMA1_Stream6_BASE;
  DMA1_Stream7  : TDMA_Stream_Registers absolute DMA1_Stream7_BASE;
  DMA2          : TDMA_Registers absolute DMA2_BASE;
  DMA2_Stream0  : TDMA_Stream_Registers absolute DMA2_Stream0_BASE;
  DMA2_Stream1  : TDMA_Stream_Registers absolute DMA2_Stream1_BASE;
  DMA2_Stream2  : TDMA_Stream_Registers absolute DMA2_Stream2_BASE;
  DMA2_Stream3  : TDMA_Stream_Registers absolute DMA2_Stream3_BASE;
  DMA2_Stream4  : TDMA_Stream_Registers absolute DMA2_Stream4_BASE;
  DMA2_Stream5  : TDMA_Stream_Registers absolute DMA2_Stream5_BASE;
  DMA2_Stream6  : TDMA_Stream_Registers absolute DMA2_Stream6_BASE;
  DMA2_Stream7  : TDMA_Stream_Registers absolute DMA2_Stream7_BASE;
  RNG           : TRNG_Registers absolute RNG_BASE;
  DBGMCU        : TDBGMCU_Registers absolute DBGMCU_BASE;

implementation

procedure NonMaskableInt_Handler; external name 'NonMaskableInt_Handler';
procedure MemoryManagement_Handler; external name 'MemoryManagement_Handler';
procedure BusFault_Handler; external name 'BusFault_Handler';
procedure UsageFault_Handler; external name 'UsageFault_Handler';
procedure SVCall_Handler; external name 'SVCall_Handler';
procedure DebugMonitor_Handler; external name 'DebugMonitor_Handler';
procedure PendSV_Handler; external name 'PendSV_Handler';
procedure SysTick_Handler; external name 'SysTick_Handler';
procedure WWDG_IRQHandler; external name 'WWDG_IRQHandler';
procedure PVD_IRQHandler; external name 'PVD_IRQHandler';
procedure TAMP_STAMP_IRQHandler; external name 'TAMP_STAMP_IRQHandler';
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
procedure EXTI9_5_IRQHandler; external name 'EXTI9_5_IRQHandler';
procedure TIM1_BRK_TIM9_IRQHandler; external name 'TIM1_BRK_TIM9_IRQHandler';
procedure TIM1_UP_IRQHandler; external name 'TIM1_UP_IRQHandler';
procedure TIM1_TRG_COM_TIM11_IRQHandler; external name 'TIM1_TRG_COM_TIM11_IRQHandler';
procedure TIM1_CC_IRQHandler; external name 'TIM1_CC_IRQHandler';
procedure I2C1_EV_IRQHandler; external name 'I2C1_EV_IRQHandler';
procedure I2C1_ER_IRQHandler; external name 'I2C1_ER_IRQHandler';
procedure I2C2_EV_IRQHandler; external name 'I2C2_EV_IRQHandler';
procedure I2C2_ER_IRQHandler; external name 'I2C2_ER_IRQHandler';
procedure SPI1_IRQHandler; external name 'SPI1_IRQHandler';
procedure SPI2_IRQHandler; external name 'SPI2_IRQHandler';
procedure USART1_IRQHandler; external name 'USART1_IRQHandler';
procedure USART2_IRQHandler; external name 'USART2_IRQHandler';
procedure EXTI15_10_IRQHandler; external name 'EXTI15_10_IRQHandler';
procedure RTC_Alarm_IRQHandler; external name 'RTC_Alarm_IRQHandler';
procedure DMA1_Stream7_IRQHandler; external name 'DMA1_Stream7_IRQHandler';
procedure TIM5_IRQHandler; external name 'TIM5_IRQHandler';
procedure TIM6_DAC_IRQHandler; external name 'TIM6_DAC_IRQHandler';
procedure DMA2_Stream0_IRQHandler; external name 'DMA2_Stream0_IRQHandler';
procedure DMA2_Stream1_IRQHandler; external name 'DMA2_Stream1_IRQHandler';
procedure DMA2_Stream2_IRQHandler; external name 'DMA2_Stream2_IRQHandler';
procedure DMA2_Stream3_IRQHandler; external name 'DMA2_Stream3_IRQHandler';
procedure DMA2_Stream4_IRQHandler; external name 'DMA2_Stream4_IRQHandler';
procedure DMA2_Stream5_IRQHandler; external name 'DMA2_Stream5_IRQHandler';
procedure DMA2_Stream6_IRQHandler; external name 'DMA2_Stream6_IRQHandler';
procedure DMA2_Stream7_IRQHandler; external name 'DMA2_Stream7_IRQHandler';
procedure USART6_IRQHandler; external name 'USART6_IRQHandler';
procedure RNG_IRQHandler; external name 'RNG_IRQHandler';
procedure FPU_IRQHandler; external name 'FPU_IRQHandler';
procedure SPI5_IRQHandler; external name 'SPI5_IRQHandler';
procedure FMPI2C1_EV_IRQHandler; external name 'FMPI2C1_EV_IRQHandler';
procedure FMPI2C1_ER_IRQHandler; external name 'FMPI2C1_ER_IRQHandler';
procedure LPTIM1_IRQHandler; external name 'LPTIM1_IRQHandler';


{$i cortexm4f_start.inc}

procedure Vectors; assembler; nostackframe;
label interrupt_vectors;
asm
  .section ".init.interrupt_vectors"
  interrupt_vectors:
  .long _stack_top
  .long Startup
  .long NonMaskableInt_Handler
  .long 0
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
  .long PVD_IRQHandler
  .long TAMP_STAMP_IRQHandler
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
  .long 0
  .long 0
  .long 0
  .long 0
  .long EXTI9_5_IRQHandler
  .long TIM1_BRK_TIM9_IRQHandler
  .long TIM1_UP_IRQHandler
  .long TIM1_TRG_COM_TIM11_IRQHandler
  .long TIM1_CC_IRQHandler
  .long 0
  .long 0
  .long 0
  .long I2C1_EV_IRQHandler
  .long I2C1_ER_IRQHandler
  .long I2C2_EV_IRQHandler
  .long I2C2_ER_IRQHandler
  .long SPI1_IRQHandler
  .long SPI2_IRQHandler
  .long USART1_IRQHandler
  .long USART2_IRQHandler
  .long 0
  .long EXTI15_10_IRQHandler
  .long RTC_Alarm_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long DMA1_Stream7_IRQHandler
  .long 0
  .long 0
  .long TIM5_IRQHandler
  .long 0
  .long 0
  .long 0
  .long TIM6_DAC_IRQHandler
  .long 0
  .long DMA2_Stream0_IRQHandler
  .long DMA2_Stream1_IRQHandler
  .long DMA2_Stream2_IRQHandler
  .long DMA2_Stream3_IRQHandler
  .long DMA2_Stream4_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long DMA2_Stream5_IRQHandler
  .long DMA2_Stream6_IRQHandler
  .long DMA2_Stream7_IRQHandler
  .long USART6_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long RNG_IRQHandler
  .long FPU_IRQHandler
  .long 0
  .long 0
  .long 0
  .long SPI5_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long FMPI2C1_EV_IRQHandler
  .long FMPI2C1_ER_IRQHandler
  .long LPTIM1_IRQHandler

  .weak NonMaskableInt_Handler
  .weak MemoryManagement_Handler
  .weak BusFault_Handler
  .weak UsageFault_Handler
  .weak SVCall_Handler
  .weak DebugMonitor_Handler
  .weak PendSV_Handler
  .weak SysTick_Handler
  .weak WWDG_IRQHandler
  .weak PVD_IRQHandler
  .weak TAMP_STAMP_IRQHandler
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
  .weak EXTI9_5_IRQHandler
  .weak TIM1_BRK_TIM9_IRQHandler
  .weak TIM1_UP_IRQHandler
  .weak TIM1_TRG_COM_TIM11_IRQHandler
  .weak TIM1_CC_IRQHandler
  .weak I2C1_EV_IRQHandler
  .weak I2C1_ER_IRQHandler
  .weak I2C2_EV_IRQHandler
  .weak I2C2_ER_IRQHandler
  .weak SPI1_IRQHandler
  .weak SPI2_IRQHandler
  .weak USART1_IRQHandler
  .weak USART2_IRQHandler
  .weak EXTI15_10_IRQHandler
  .weak RTC_Alarm_IRQHandler
  .weak DMA1_Stream7_IRQHandler
  .weak TIM5_IRQHandler
  .weak TIM6_DAC_IRQHandler
  .weak DMA2_Stream0_IRQHandler
  .weak DMA2_Stream1_IRQHandler
  .weak DMA2_Stream2_IRQHandler
  .weak DMA2_Stream3_IRQHandler
  .weak DMA2_Stream4_IRQHandler
  .weak DMA2_Stream5_IRQHandler
  .weak DMA2_Stream6_IRQHandler
  .weak DMA2_Stream7_IRQHandler
  .weak USART6_IRQHandler
  .weak RNG_IRQHandler
  .weak FPU_IRQHandler
  .weak SPI5_IRQHandler
  .weak FMPI2C1_EV_IRQHandler
  .weak FMPI2C1_ER_IRQHandler
  .weak LPTIM1_IRQHandler

  .set NonMaskableInt_Handler, _NonMaskableInt_Handler
  .set MemoryManagement_Handler, _MemoryManagement_Handler
  .set BusFault_Handler, _BusFault_Handler
  .set UsageFault_Handler, _UsageFault_Handler
  .set SVCall_Handler, _SVCall_Handler
  .set DebugMonitor_Handler, _DebugMonitor_Handler
  .set PendSV_Handler, _PendSV_Handler
  .set SysTick_Handler, _SysTick_Handler
  .set WWDG_IRQHandler, Haltproc
  .set PVD_IRQHandler, Haltproc
  .set TAMP_STAMP_IRQHandler, Haltproc
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
  .set EXTI9_5_IRQHandler, Haltproc
  .set TIM1_BRK_TIM9_IRQHandler, Haltproc
  .set TIM1_UP_IRQHandler, Haltproc
  .set TIM1_TRG_COM_TIM11_IRQHandler, Haltproc
  .set TIM1_CC_IRQHandler, Haltproc
  .set I2C1_EV_IRQHandler, Haltproc
  .set I2C1_ER_IRQHandler, Haltproc
  .set I2C2_EV_IRQHandler, Haltproc
  .set I2C2_ER_IRQHandler, Haltproc
  .set SPI1_IRQHandler, Haltproc
  .set SPI2_IRQHandler, Haltproc
  .set USART1_IRQHandler, Haltproc
  .set USART2_IRQHandler, Haltproc
  .set EXTI15_10_IRQHandler, Haltproc
  .set RTC_Alarm_IRQHandler, Haltproc
  .set DMA1_Stream7_IRQHandler, Haltproc
  .set TIM5_IRQHandler, Haltproc
  .set TIM6_DAC_IRQHandler, Haltproc
  .set DMA2_Stream0_IRQHandler, Haltproc
  .set DMA2_Stream1_IRQHandler, Haltproc
  .set DMA2_Stream2_IRQHandler, Haltproc
  .set DMA2_Stream3_IRQHandler, Haltproc
  .set DMA2_Stream4_IRQHandler, Haltproc
  .set DMA2_Stream5_IRQHandler, Haltproc
  .set DMA2_Stream6_IRQHandler, Haltproc
  .set DMA2_Stream7_IRQHandler, Haltproc
  .set USART6_IRQHandler, Haltproc
  .set RNG_IRQHandler, Haltproc
  .set FPU_IRQHandler, Haltproc
  .set SPI5_IRQHandler, Haltproc
  .set FMPI2C1_EV_IRQHandler, Haltproc
  .set FMPI2C1_ER_IRQHandler, Haltproc
  .set LPTIM1_IRQHandler, Haltproc

  .text
  end;
end.
