unit stm32l031xx;
interface
{$PACKRECORDS C}
{$GOTO ON}
{$SCOPEDENUMS ON}

type
  TIRQn_Enum = (
    NonMaskableInt_IRQn = -14,        
    HardFault_IRQn = -13,             
    SVC_IRQn    = -5,                 
    PendSV_IRQn = -2,                 
    SysTick_IRQn = -1,                
    WWDG_IRQn   = 0,                  
    PVD_IRQn    = 1,                  
    RTC_IRQn    = 2,                  
    FLASH_IRQn  = 3,                  
    RCC_IRQn    = 4,                  
    EXTI0_1_IRQn = 5,                 
    EXTI2_3_IRQn = 6,                 
    EXTI4_15_IRQn = 7,                
    DMA1_Channel1_IRQn = 9,           
    DMA1_Channel2_3_IRQn = 10,        
    DMA1_Channel4_5_6_7_IRQn = 11,    
    ADC1_COMP_IRQn = 12,              
    LPTIM1_IRQn = 13,                 
    TIM2_IRQn   = 15,                 
    TIM21_IRQn  = 20,                 
    TIM22_IRQn  = 22,                 
    I2C1_IRQn   = 23,                 
    SPI1_IRQn   = 25,                 
    USART2_IRQn = 28,                 
    LPUART1_IRQn = 29                 
  );

  TADC_Registers = record
    ISR         : longword;
    IER         : longword;
    CR          : longword;
    CFGR1       : longword;
    CFGR2       : longword;
    SMPR        : longword;
    RESERVED1   : longword;
    RESERVED2   : longword;
    TR          : longword;
    RESERVED3   : longword;
    CHSELR      : longword;
    RESERVED4   : array[0..4] of longword;
    DR          : longword;
    RESERVED5   : array[0..27] of longword;
    CALFACT     : longword;
  end;

  TADC_Common_Registers = record
    CCR         : longword;
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

  TDBGMCU_Registers = record
    IDCODE      : longword;
    CR          : longword;
    APB1FZ      : longword;
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
    IMR         : longword;
    EMR         : longword;
    RTSR        : longword;
    FTSR        : longword;
    SWIER       : longword;
    PR          : longword;
  end;

  TFLASH_Registers = record
    ACR         : longword;
    PECR        : longword;
    PDKEYR      : longword;
    PEKEYR      : longword;
    PRGKEYR     : longword;
    OPTKEYR     : longword;
    SR          : longword;
    OPTR        : longword;
    WRPR        : longword;
  end;

  TOB_Registers = record
    RDP         : longword;
    USER        : longword;
    WRP01       : longword;
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

  TLPTIM_Registers = record
    ISR         : longword;
    ICR         : longword;
    IER         : longword;
    CFGR        : longword;
    CR          : longword;
    CMP         : longword;
    ARR         : longword;
    CNT         : longword;
  end;

  TSYSCFG_Registers = record
    CFGR1       : longword;
    CFGR2       : longword;
    EXTICR      : array[0..3] of longword;
    RESERVED    : array[0..1] of longword;
    CFGR3       : longword;
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

  TPWR_Registers = record
    CR          : longword;
    CSR         : longword;
  end;

  TRCC_Registers = record
    CR          : longword;
    ICSCR       : longword;
    CRRCR       : longword;
    CFGR        : longword;
    CIER        : longword;
    CIFR        : longword;
    CICR        : longword;
    IOPRSTR     : longword;
    AHBRSTR     : longword;
    APB2RSTR    : longword;
    APB1RSTR    : longword;
    IOPENR      : longword;
    AHBENR      : longword;
    APB2ENR     : longword;
    APB1ENR     : longword;
    IOPSMENR    : longword;
    AHBSMENR    : longword;
    APB2SMENR   : longword;
    APB1SMENR   : longword;
    CCIPR       : longword;
    CSR         : longword;
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
    RESERVED12  : longword;
    CCR1        : longword;
    CCR2        : longword;
    CCR3        : longword;
    CCR4        : longword;
    RESERVED17  : longword;
    DCR         : longword;
    DMAR        : longword;
    &OR         : longword;
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
  end;

  TWWDG_Registers = record
    CR          : longword;
    CFR         : longword;
    SR          : longword;
  end;

const
  __NVIC_PRIO_BITS= 2;
  FLASH_BASE    = $08000000;
  DATA_EEPROM_BASE= $08080000;
  SRAM_BASE     = $20000000;
  PERIPH_BASE   = $40000000;
  APBPERIPH_BASE= PERIPH_BASE;
  AHBPERIPH_BASE= PERIPH_BASE + $00020000;
  IOPPERIPH_BASE= PERIPH_BASE + $10000000;
  TIM2_BASE     = APBPERIPH_BASE + $00000000;
  RTC_BASE      = APBPERIPH_BASE + $00002800;
  WWDG_BASE     = APBPERIPH_BASE + $00002C00;
  IWDG_BASE     = APBPERIPH_BASE + $00003000;
  USART2_BASE   = APBPERIPH_BASE + $00004400;
  LPUART1_BASE  = APBPERIPH_BASE + $00004800;
  I2C1_BASE     = APBPERIPH_BASE + $00005400;
  PWR_BASE      = APBPERIPH_BASE + $00007000;
  LPTIM1_BASE   = APBPERIPH_BASE + $00007C00;
  SYSCFG_BASE   = APBPERIPH_BASE + $00010000;
  COMP1_BASE    = APBPERIPH_BASE + $00010018;
  COMP2_BASE    = APBPERIPH_BASE + $0001001C;
  EXTI_BASE     = APBPERIPH_BASE + $00010400;
  TIM21_BASE    = APBPERIPH_BASE + $00010800;
  TIM22_BASE    = APBPERIPH_BASE + $00011400;
  ADC1_BASE     = APBPERIPH_BASE + $00012400;
  ADC_BASE      = APBPERIPH_BASE + $00012708;
  SPI1_BASE     = APBPERIPH_BASE + $00013000;
  DBGMCU_BASE   = APBPERIPH_BASE + $00015800;
  DMA1_BASE     = AHBPERIPH_BASE + $00000000;
  DMA1_Channel1_BASE= DMA1_BASE + $00000008;
  DMA1_Channel2_BASE= DMA1_BASE + $0000001C;
  DMA1_Channel3_BASE= DMA1_BASE + $00000030;
  DMA1_Channel4_BASE= DMA1_BASE + $00000044;
  DMA1_Channel5_BASE= DMA1_BASE + $00000058;
  DMA1_Channel6_BASE= DMA1_BASE + $0000006C;
  DMA1_Channel7_BASE= DMA1_BASE + $00000080;
  DMA1_CSELR_BASE= DMA1_BASE + $000000A8;
  RCC_BASE      = AHBPERIPH_BASE + $00001000;
  FLASH_R_BASE  = AHBPERIPH_BASE + $00002000;
  OB_BASE       = $1FF80000;
  FLASHSIZE_BASE= $1FF8007C;
  UID_BASE      = $1FF80050;
  CRC_BASE      = AHBPERIPH_BASE + $00003000;
  GPIOA_BASE    = IOPPERIPH_BASE + $00000000;
  GPIOB_BASE    = IOPPERIPH_BASE + $00000400;
  GPIOC_BASE    = IOPPERIPH_BASE + $00000800;
  GPIOH_BASE    = IOPPERIPH_BASE + $00001C00;

var
  COMP12_COMMON : TCOMP_Common_Registers absolute COMP1_BASE;
  TIM2          : TTIM_Registers absolute TIM2_BASE;
  RTC           : TRTC_Registers absolute RTC_BASE;
  WWDG          : TWWDG_Registers absolute WWDG_BASE;
  IWDG          : TIWDG_Registers absolute IWDG_BASE;
  USART2        : TUSART_Registers absolute USART2_BASE;
  LPUART1       : TUSART_Registers absolute LPUART1_BASE;
  I2C1          : TI2C_Registers absolute I2C1_BASE;
  PWR           : TPWR_Registers absolute PWR_BASE;
  LPTIM1        : TLPTIM_Registers absolute LPTIM1_BASE;
  SYSCFG        : TSYSCFG_Registers absolute SYSCFG_BASE;
  COMP1         : TCOMP_Registers absolute COMP1_BASE;
  COMP2         : TCOMP_Registers absolute COMP2_BASE;
  EXTI          : TEXTI_Registers absolute EXTI_BASE;
  TIM21         : TTIM_Registers absolute TIM21_BASE;
  TIM22         : TTIM_Registers absolute TIM22_BASE;
  ADC1          : TADC_Registers absolute ADC1_BASE;
  ADC1_COMMON   : TADC_Common_Registers absolute ADC_BASE;
  SPI1          : TSPI_Registers absolute SPI1_BASE;
  DBGMCU        : TDBGMCU_Registers absolute DBGMCU_BASE;
  DMA1          : TDMA_Registers absolute DMA1_BASE;
  DMA1_Channel1 : TDMA_Channel_Registers absolute DMA1_Channel1_BASE;
  DMA1_Channel2 : TDMA_Channel_Registers absolute DMA1_Channel2_BASE;
  DMA1_Channel3 : TDMA_Channel_Registers absolute DMA1_Channel3_BASE;
  DMA1_Channel4 : TDMA_Channel_Registers absolute DMA1_Channel4_BASE;
  DMA1_Channel5 : TDMA_Channel_Registers absolute DMA1_Channel5_BASE;
  DMA1_Channel6 : TDMA_Channel_Registers absolute DMA1_Channel6_BASE;
  DMA1_Channel7 : TDMA_Channel_Registers absolute DMA1_Channel7_BASE;
  DMA1_CSELR    : TDMA_Request_Registers absolute DMA1_CSELR_BASE;
  FLASH         : TFLASH_Registers absolute FLASH_R_BASE;
  OB            : TOB_Registers absolute OB_BASE;
  RCC           : TRCC_Registers absolute RCC_BASE;
  CRC           : TCRC_Registers absolute CRC_BASE;
  GPIOA         : TGPIO_Registers absolute GPIOA_BASE;
  GPIOB         : TGPIO_Registers absolute GPIOB_BASE;
  GPIOC         : TGPIO_Registers absolute GPIOC_BASE;
  GPIOH         : TGPIO_Registers absolute GPIOH_BASE;

implementation

procedure NonMaskableInt_Handler; external name 'NonMaskableInt_Handler';
procedure HardFault_Handler; external name 'HardFault_Handler';
procedure SVC_Handler; external name 'SVC_Handler';
procedure PendSV_Handler; external name 'PendSV_Handler';
procedure SysTick_Handler; external name 'SysTick_Handler';
procedure WWDG_IRQHandler; external name 'WWDG_IRQHandler';
procedure PVD_IRQHandler; external name 'PVD_IRQHandler';
procedure RTC_IRQHandler; external name 'RTC_IRQHandler';
procedure FLASH_IRQHandler; external name 'FLASH_IRQHandler';
procedure RCC_IRQHandler; external name 'RCC_IRQHandler';
procedure EXTI0_1_IRQHandler; external name 'EXTI0_1_IRQHandler';
procedure EXTI2_3_IRQHandler; external name 'EXTI2_3_IRQHandler';
procedure EXTI4_15_IRQHandler; external name 'EXTI4_15_IRQHandler';
procedure DMA1_Channel1_IRQHandler; external name 'DMA1_Channel1_IRQHandler';
procedure DMA1_Channel2_3_IRQHandler; external name 'DMA1_Channel2_3_IRQHandler';
procedure DMA1_Channel4_5_6_7_IRQHandler; external name 'DMA1_Channel4_5_6_7_IRQHandler';
procedure ADC1_COMP_IRQHandler; external name 'ADC1_COMP_IRQHandler';
procedure LPTIM1_IRQHandler; external name 'LPTIM1_IRQHandler';
procedure TIM2_IRQHandler; external name 'TIM2_IRQHandler';
procedure TIM21_IRQHandler; external name 'TIM21_IRQHandler';
procedure TIM22_IRQHandler; external name 'TIM22_IRQHandler';
procedure I2C1_IRQHandler; external name 'I2C1_IRQHandler';
procedure SPI1_IRQHandler; external name 'SPI1_IRQHandler';
procedure USART2_IRQHandler; external name 'USART2_IRQHandler';
procedure LPUART1_IRQHandler; external name 'LPUART1_IRQHandler';


{$i cortexm0p_start.inc}

procedure Vectors; assembler; nostackframe;
label interrupt_vectors;
asm
  .section ".init.interrupt_vectors"
  interrupt_vectors:
  .long _stack_top
  .long Startup
  .long NonMaskableInt_Handler
  .long HardFault_Handler
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long 0
  .long SVC_Handler
  .long 0
  .long 0
  .long PendSV_Handler
  .long SysTick_Handler
  .long WWDG_IRQHandler
  .long PVD_IRQHandler
  .long RTC_IRQHandler
  .long FLASH_IRQHandler
  .long RCC_IRQHandler
  .long EXTI0_1_IRQHandler
  .long EXTI2_3_IRQHandler
  .long EXTI4_15_IRQHandler
  .long 0
  .long DMA1_Channel1_IRQHandler
  .long DMA1_Channel2_3_IRQHandler
  .long DMA1_Channel4_5_6_7_IRQHandler
  .long ADC1_COMP_IRQHandler
  .long LPTIM1_IRQHandler
  .long 0
  .long TIM2_IRQHandler
  .long 0
  .long 0
  .long 0
  .long 0
  .long TIM21_IRQHandler
  .long 0
  .long TIM22_IRQHandler
  .long I2C1_IRQHandler
  .long 0
  .long SPI1_IRQHandler
  .long 0
  .long 0
  .long USART2_IRQHandler
  .long LPUART1_IRQHandler

  .weak NonMaskableInt_Handler
  .weak HardFault_Handler
  .weak SVC_Handler
  .weak PendSV_Handler
  .weak SysTick_Handler
  .weak WWDG_IRQHandler
  .weak PVD_IRQHandler
  .weak RTC_IRQHandler
  .weak FLASH_IRQHandler
  .weak RCC_IRQHandler
  .weak EXTI0_1_IRQHandler
  .weak EXTI2_3_IRQHandler
  .weak EXTI4_15_IRQHandler
  .weak DMA1_Channel1_IRQHandler
  .weak DMA1_Channel2_3_IRQHandler
  .weak DMA1_Channel4_5_6_7_IRQHandler
  .weak ADC1_COMP_IRQHandler
  .weak LPTIM1_IRQHandler
  .weak TIM2_IRQHandler
  .weak TIM21_IRQHandler
  .weak TIM22_IRQHandler
  .weak I2C1_IRQHandler
  .weak SPI1_IRQHandler
  .weak USART2_IRQHandler
  .weak LPUART1_IRQHandler

  .set NonMaskableInt_Handler, _NonMaskableInt_Handler
  .set HardFault_Handler, _HardFault_Handler
  .set SVC_Handler, _SVC_Handler
  .set PendSV_Handler, _PendSV_Handler
  .set SysTick_Handler, _SysTick_Handler
  .set WWDG_IRQHandler, Haltproc
  .set PVD_IRQHandler, Haltproc
  .set RTC_IRQHandler, Haltproc
  .set FLASH_IRQHandler, Haltproc
  .set RCC_IRQHandler, Haltproc
  .set EXTI0_1_IRQHandler, Haltproc
  .set EXTI2_3_IRQHandler, Haltproc
  .set EXTI4_15_IRQHandler, Haltproc
  .set DMA1_Channel1_IRQHandler, Haltproc
  .set DMA1_Channel2_3_IRQHandler, Haltproc
  .set DMA1_Channel4_5_6_7_IRQHandler, Haltproc
  .set ADC1_COMP_IRQHandler, Haltproc
  .set LPTIM1_IRQHandler, Haltproc
  .set TIM2_IRQHandler, Haltproc
  .set TIM21_IRQHandler, Haltproc
  .set TIM22_IRQHandler, Haltproc
  .set I2C1_IRQHandler, Haltproc
  .set SPI1_IRQHandler, Haltproc
  .set USART2_IRQHandler, Haltproc
  .set LPUART1_IRQHandler, Haltproc

  .text
  end;
end.
