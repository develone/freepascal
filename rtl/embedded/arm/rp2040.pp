unit rp2040;
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
    TIMER_IRQ_0 = 0,
    TIMER_IRQ_1 = 1,
    TIMER_IRQ_2 = 2,
    TIMER_IRQ_3 = 3,
    PWM_IRQ_WRAP =4,
    USBCTRL_IRQ =5,
    XIP_IRQ     =6,
    PIO0_IRQ_0  =7,
    PIO0_IRQ_1  =8,
    PIO1_IRQ_0  =9,
    PIO1_IRQ_1  =10,
    DMA_IRQ_0   =11,
    DMA_IRQ_1   =12,
    IO_IRQ_BANK0=13,
    IO_IRQ_QSPI  =14,
    SIO_IRQ_PROC0=15,
    SIO_IRQ_PROC1 =16,
    CLOCKS_IRQ =17,
    SPI0_IRQ =18,
    SPI1_IRQ =19,
    UART0_IRQ =20,
    UART1_IRQ =21,
    ADC0_IRQ_FIFO=22,
    I2C0_IRQ=23,
    I2C1_IRQ=24,
    RTC_IRQ=25
  );

type
  TADC_Registers = record
    cs : longWord;
    result : longWord;
    fcs : longWord;
    fifo : longWord;
    &div : longWord;
    intr : longWord;
    inte : longWord;
    intf : longWord;
    ints : longWord;
  end;

  TBUSCTRL_Registers = record
    priority : longWord;
    priority_ack : longWord;
    perf : array[0..3] of record
      ctr : longWord;
      sel : longWord;
    end;
  end;

  TCLOCK_Registers = record
    ctrl : longWord;
    &div : longWord;
    selected : longWord;
  end;

  TFC_Registers = record
    ref_khz : longWord;
    min_khz : longWord;
    max_khz : longWord;
    delay : longWord;
    interval : longWord;
    src : longWord;
    status : longWord;
    result : longWord;
  end;

  TCLOCKS_Registers = record
    clk_gpout : array[0..3] of TCLOCK_Registers;
    clk_ref : TCLOCK_Registers;
    clk_sys : TCLOCK_Registers;
    clk_peri : TCLOCK_Registers;
    clk_usb : TCLOCK_Registers;
    clk_adc : TCLOCK_Registers;
    clk_rtc : TCLOCK_Registers;
    clk_sys_resus : record
      ctrl : longWord;
      status : longWord;
    end;
    fc0 : TFC_Registers;
    wake_en0 : longWord;
    wake_en1 : longWord;
    sleep_en0 : longWord;
    sleep_en1 : longWord;
    enabled0 : longWord;
    enabled1 : longWord;
    intr : longWord;
    inte : longWord;
    intf : longWord;
    ints : longWord;
  end;

  TDMACHANNEL_Registers = record
    read_addr : longWord;
    write_addr : longWord;
    transfer_count : longWord;
    ctrl_trig : longWord;
    al1_ctrl : longWord;
    al1_read_addr : longWord;
    al1_write_addr : longWord;
    al1_transfer_count_trig : longWord;
    al2_ctrl : longWord;
    al2_transfer_count : longWord;
    al2_read_addr : longWord;
    al2_write_addr_trig : longWord;
    al3_ctrl : longWord;
    al3_write_addr : longWord;
    al3_transfer_count : longWord;
    al3_read_addr_trig : longWord;
  end;

  TDMA_Registers = record
    ch : array[0..11] of TDMACHANNEL_Registers;
    RESERVED0 : array[0..63] of longWord;
    intr : longWord;
    inte0 : longWord;
    intf0 : longWord;
    ints0 : longWord;
    RESERVED1 : longWord;
    inte1 : longWord;
    intf1 : longWord;
    ints1 : longWord;
    timer : array[0..1] of longWord;
    RESERVED2 : array[0..1] of longWord;
    multi_channel_trigger : longWord;
    sniff_ctrl : longWord;
    sniff_data : longWord;
    RESERVED3 : longWord;
    fifo_levels : longWord;
    abort : longWord;
  end;

  TDMADEBUG_Registers = record
    ch : array[0..11] of record
      ctrdeq : longWord;
      tcr : longWord;
      RESERVED0 : array[0..13] of longWord;
    end;
  end;

  TI2C_Registers = record
    con : longWord;
    tar : longWord;
    sar : longWord;
    RESERVED0 : longWord;
    data_cmd : longWord;
    ss_scl_hcnt : longWord;
    ss_scl_lcnt : longWord;
    fs_scl_hcnt : longWord;
    fs_scl_lcnt : longWord;
    RESERVED1 : array[0..1] of longWord;
    intr_stat : longWord;
    intr_mask : longWord;
    raw_intr_stat : longWord;
    rx_tl : longWord;
    tx_tl : longWord;
    clr_intr : longWord;
    clr_rx_under : longWord;
    clr_rx_over : longWord;
    clr_tx_over : longWord;
    clr_rd_req : longWord;
    clr_tx_abrt : longWord;
    clr_rx_done : longWord;
    clr_activity : longWord;
    clr_stop_det : longWord;
    clr_start_det : longWord;
    clr_gen_call : longWord;
    enable : longWord;
    status : longWord;
    txflr : longWord;
    rxflr : longWord;
    sda_hold : longWord;
    tx_abrt_source : longWord;
    slv_data_nack_only : longWord;
    dma_cr : longWord;
    dma_tdlr : longWord;
    dma_rdlr : longWord;
    sda_setup : longWord;
    ack_general_call : longWord;
    enable_status : longWord;
    fs_spklen : longWord;
    RESERVED2 : longWord;
    clr_restart_det : longWord;
    RESERVED3 : array[0..17] of longWord;
    comp_param_1 : longWord;
    comp_version : longWord;
    comp_type : longWord;
  end;

  TIOIRQCTRL_Registers = record
    inte : array[0..3] of longWord;
    intf : array[0..3] of longWord;
    ints : array[0..3] of longWord;
  end;

  TIOBANK0_Registers = record
    io : array[0..29] of record
      status : longWord;
      ctrl : longWord;
    end;
    intr : array[0..3] of longWord;
    proc0_irq_ctrl : TIOIRQCTRL_Registers;
    proc1_irq_ctrl : TIOIRQCTRL_Registers;
    dormant_wake_irq_ctrl : TIOIRQCTRL_Registers;
  end;

  TIOQSPI_Registers = record
    io : array[0..5] of record
      status : longWord;
      ctrl : longWord;
    end;
  end;

  TPADSQSPI_Registers = record
    voltage_select : longWord;
    io : array[0..5] of longWord;
  end;

  TPADSBANK0_Registers = record
    voltage_select : longWord;
    io : array[0..29] of longWord;
  end;

  TPIO_Registers = record
    ctrl : longWord;
    fstat : longWord;
    fdebug : longWord;
    flevel : longWord;
    txf : array[0..1] of longWord;
    rxf : array[0..1] of longWord;
    irq : longWord;
    irq_force : longWord;
    input_sync_bypass : longWord;
    dbg_padout : longWord;
    dbg_padoe : longWord;
    dbg_cfginfo : longWord;
    instr_mem : array[0..31] of longWord;
    sm : array[0..1] of record
      clkdiv : longWord;
      execctrl : longWord;
      shiftctrl : longWord;
      addr : longWord;
      instr : longWord;
      pinctrl : longWord;
    end;
    intr : longWord;
    inte0 : longWord;
    intf0 : longWord;
    ints0 : longWord;
    inte1 : longWord;
    intf1 : longWord;
    ints1 : longWord;
  end;

  TPLL_Registers = record
    cs : longWord;
    pwr : longWord;
    fbdiv_int : longWord;
    prim : longWord;
  end;

  TPSM_Registers = record
    frce_on : longWord;
    frce_off : longWord;
    wdsel : longWord;
    done : longWord;
  end;

  TPWMSLICE_Registers = record
    csr : longWord;
    &div : longWord;
    ctr : longWord;
    cc : longWord;
    top : longWord;
  end;

  TPWM_Registers = record
    slice : array[0..7] of TPWMSLICE_Registers;
    en : longWord;
    intr : longWord;
    inte : longWord;
    intf : longWord;
    ints : longWord;
  end;

  TRESETS_Registers = record
    reset : longWord;
    wdsel : longWord;
    reset_done : longWord;
    reserved0 : array[0..$3FF-$03] of longWord;
    reset_togl : longWord;
    wdsel_togl : longWord;
    reset_done_togl : longWord;
    reserved1 : array[0..$3FF-$03] of longWord;
    reset_set : longWord;
    wdsel_set : longWord;
    reset_done_set : longWord;
    reserved2 : array[0..$3FF-$03] of longWord;
    reset_clr : longWord;
    wdsel_clr : longWord;
    reset_done_clr : longWord;
  end;

  TROSC_Registers = record
    ctrl : longWord;
    freqa : longWord;
    freqb : longWord;
    dormant : longWord;
    &div : longWord;
    phase : longWord;
    status : longWord;
    randombit : longWord;
    count : longWord;
    dftx : longWord;
  end;

  TRTC_Registers = record
    clkdiv_m1 : longWord;
    setup_0 : longWord;
    setup_1 : longWord;
    ctrl : longWord;
    irq_setup_0 : longWord;
    irq_setup_1 : longWord;
    rtc_1 : longWord;
    rtc_0 : longWord;
    intr : longWord;
    inte : longWord;
    intf : longWord;
    ints : longWord;
  end;

  TINTERP_Registers = record
    accum : array[0..1] of longWord;
    base : array[0..2] of longWord;
    pop : array[0..2] of longWord;
    peek : array[0..2] of longWord;
    ctrl : array[0..1] of longWord;
    add_raw : array[0..1] of longWord;
    base01 : longWord;
  end;

  TSIO_Registers = record
    cpuid : longWord;
    gpio_in : longWord;
    gpio_hi_in : longWord;
    RESERVED0 : longWord;
    gpio_out : longWord;
    gpio_set : longWord;
    gpio_clr : longWord;
    gpio_togl : longWord;
    gpio_oe : longWord;
    gpio_oe_set : longWord;
    gpio_oe_clr : longWord;
    gpio_oe_togl : longWord;
    gpio_hi_out : longWord;
    gpio_hi_set : longWord;
    gpio_hi_clr : longWord;
    gpio_hi_togl : longWord;
    gpio_hi_oe : longWord;
    gpio_hi_oe_set : longWord;
    gpio_hi_oe_clr : longWord;
    gpio_hi_oe_togl : longWord;
    fifo_st : longWord;
    fifo_wr : longWord;
    fifo_rd : longWord;
    spinlock_st : longWord;
    div_udividend : longWord;
    div_udivisor : longWord;
    div_sdividend : longWord;
    div_sdivisor : longWord;
    div_quotient : longWord;
    div_remainder : longWord;
    div_csr : longWord;
    RESERVED1 : longWord;
    interp : array[0..1] of TINTERP_Registers;
    spinlock : array[0..31] of longWord;
  end;

  TSPI_Registers = record
    cr0 : longWord;
    cr1 : longWord;
    dr : longWord;
    sr : longWord;
    cpsr : longWord;
    imsc : longWord;
    ris : longWord;
    mis : longWord;
    icr : longWord;
    dmacr : longWord;
  end;

  TSSI_Registers = record
    ctrlr0 : longWord;
    ctrlr1 : longWord;
    ssienr : longWord;
    mwcr : longWord;
    ser : longWord;
    baudr : longWord;
    txftlr : longWord;
    rxftlr : longWord;
    txflr : longWord;
    rxflr : longWord;
    sr : longWord;
    imr : longWord;
    isr : longWord;
    risr : longWord;
    txoicr : longWord;
    rxoicr : longWord;
    rxuicr : longWord;
    msticr : longWord;
    icr : longWord;
    dmacr : longWord;
    dmatdlr : longWord;
    dmardlr : longWord;
    idr : longWord;
    ssi_version_id : longWord;
    dr0 : longWord;
    RESERVED0 : array[0..34] of longWord;
    rx_sample_dly : longWord;
    spi_ctrlr0 : longWord;
    txd_drive_edge : longWord;
  end;

  TSYSCFG_Registers = record
    proc0_nmi_mask : longWord;
    proc1_nmi_mask : longWord;
    proc_config : longWord;
    proc_in_sync_bypass : longWord;
    proc_in_sync_bypass_hi : longWord;
    dbgforce : longWord;
    mempowerdown : longWord;
  end;

  TSYSINFO_Registers = record
    chip_id : longWord;
    platform : longWord;
    reserved0 : array[0..$3F-$08] of longWord;
    gitref_rp2040 : longWord;
  end;

  TTIMER_Registers = record
    timehw : longWord;
    timelw : longWord;
    timehr : longWord;
    timelr : longWord;
    alarm : array[0..3] of longWord;
    armed : longWord;
    timerawh : longWord;
    timerawl : longWord;
    dbgpause : longWord;
    pause : longWord;
    intr : longWord;
    inte : longWord;
    intf : longWord;
    ints : longWord;
  end;

  TUART_Registers = record
    dr : longWord;
    rsr : longWord;
    RESERVED0 : array[0..3] of longWord;
    fr : longWord;
    RESERVED1 : longWord;
    ilpr : longWord;
    ibrd : longWord;
    fbrd : longWord;
    lcr_h : longWord;
    cr : longWord;
    ifls : longWord;
    imsc : longWord;
    ris : longWord;
    mis : longWord;
    icr : longWord;
    dmacr : longWord;
  end;

  TUSBDEVICEDPRAM = record
    setup_packet : array[0..7] of byte;
    ep_ctrl : array[0..14] of record
      &in : longWord;
      &out : longWord;
    end;
    ep_buf_ctrl : array[0..15] of record
      &in : longWord;
      &out : longWord;
    end;
    ep0_buf_a : array[0..63] of byte;
    ep0_buf_b : array[0..63] of byte;
    epx_data : array[0..(4096-$180)-1] of byte;
  end;

  TUSBHOSTDPRAM = record
    setup_packet : array[0..7] of byte;
    int_ep_ctrl : array[0..14] of record
      ctrl : longWord;
      spare : longWord;
    end;
    epx_buf_ctrl : longWord;
    _spare0 : longWord;
    int_ep_buffer_ctrl : array[0..14] of record
      ctrl : longWord;
      spare : longWord;
    end;
    epx_ctrl : longWord;
    _spare1 : array[0..123] of byte;
    epx_data : array[0..(4096-$180)-1] of byte;
  end;

  TUSB_Registers = record
    dev_addr_ctrl : longWord;
    int_ep_addr_ctrl : array[1..15] of longWord;
    main_ctrl : longWord;
    sof_wr : longWord;
    sof_rd : longWord;
    sie_ctrl : longWord;
    sie_status : longWord;
    int_ep_ctrl : longWord;
    buf_status : longWord;
    buf_cpu_should_handle : longWord;
    abort : longWord;
    abort_done : longWord;
    ep_stall_arm : longWord;
    nak_poll : longWord;
    ep_nak_stall_status : longWord;
    muxing : longWord;
    pwr : longWord;
    phy_direct : longWord;
    phy_direct_override : longWord;
    phy_trim : longWord;
    linestate_tuning : longWord;
    intr : longWord;
    inte : longWord;
    intf : longWord;
    ints : longWord;
  end;

  TVREGANDCHIPRESET_Registers = record
    vreg : longWord;
    bod : longWord;
    chip_reset : longWord;
  end;

  TWATCHDOG_Registers = record
    ctrl : longWord;
    load : longWord;
    reason : longWord;
    scratch : array[0..7] of longWord;
    tick : longWord;
  end;

  TXIPCTRL_Registers = record
    ctrl : longWord;
    flush : longWord;
    stat : longWord;
    ctr_hit : longWord;
    ctr_acc : longWord;
    stream_addr : longWord;
    stream_ctr : longWord;
    stream_fifo : longWord;
  end;

  TXOSC_Registers = record
    ctrl : longWord;
    status : longWord;
    dormant : longWord;
    startup : longWord;
    RESERVED0 : array[0..2] of longWord;
    count : longWord;
  end;

  TMPU_Registers = record
    _type : longWord;
    ctrl : longWord;
    rnr : longWord;
    rbar : longWord;
    rasr : longWord;
  end;

  TSYSTICK_Registers = record
    csr : longWord;
    rvr : longWord;
    cvr : longWord;
    calib : longWord;
  end;

  TSCB_Reqisters = record
    cpuid : longWord;
    icsr : longWord;
    vtor : longWord;
    aircr : longWord;
    scr : longWord;
  end;

const
  __NVIC_PRIO_BITS= 2;
  SRAM0_BASE      = $21000000;
  SRAM1_BASE      = $21010000;
  SRAM2_BASE      = $21020000;
  SRAM3_BASE      = $21030000;
  SYSINFO_BASE    = $40000000;
  SYSCFG_BASE     = $40004000;
  CLOCKS_BASE     = $40008000;
  RESETS_BASE     = $4000c000;
  PSM_BASE        = $40010000;
  IO_BANK0_BASE   = $40014000;
  IO_QSPI_BASE    = $40018000;
  PADS_BANK0_BASE = $4001c000;
  PADS_QSPI_BASE  = $40020000;
  XOSC_BASE       = $40024000;
  PLL_SYS_BASE    = $40028000;
  PLL_USB_BASE    = $4002c000;
  BUSCTRL_BASE    = $40030000;
  UART0_BASE      = $40034000;
  UART1_BASE      = $40038000;
  SPI0_BASE       = $4003c000;
  SPI1_BASE       = $40040000;
  I2C0_BASE       = $40044000;
  I2C1_BASE       = $40048000;
  ADC_BASE        = $4004c000;
  PWM_BASE        = $40050000;
  TIMER_BASE      = $40054000;
  WATCHDOG_BASE   = $40058000;
  RTC_BASE        = $4005c000;
  ROSC_BASE       = $40060000;
  VREG_AND_CHIP_RESET_BASE = $40064000;
  TBMAN_BASE      = $4006c000;
  DMA_BASE        = $50000000;
  USBCTRL_BASE    = $50100000;
  USBCTRL_DPRAM_BASE = $50100000;
  USBCTRL_REGS_BASE = $50110000;
  PIO0_BASE       = $50200000;
  PIO1_BASE       = $50300000;
  XIP_AUX_BASE    = $50400000;
  SIO_BASE        = $d0000000;
  PPB_BASE        = $e0000000;

var
  SysInfo : TSysInfo_Registers absolute SYSINFO_BASE;
  SysCfg : TSYSCFG_REGISTERS absolute SYSCFG_BASE;
  Clocks : TCLOCKS_Registers absolute CLOCKS_BASE;
  Resets : TRESETS_Registers absolute RESETS_BASE;
  PSM : TPSM_Registers absolute PSM_BASE;
  IOBANK0 : TIOBANK0_Registers absolute IO_BANK0_BASE;
  IOQSPI : TIOQSPI_Registers absolute IO_QSPI_BASE;
  PADSBANK0 : TPADSBANK0_Registers absolute PADS_BANK0_BASE;
  PADSQSPI : TPADSQSPI_Registers absolute PADS_QSPI_BASE;
  XOSC : TXOSC_Registers absolute XOSC_BASE;
  PLLSYS : TPLL_Registers absolute PLL_SYS_BASE;
  PLLUSB : TPLL_Registers absolute PLL_USB_BASE;
  BUSCTRL : TBUSCTRL_Registers absolute BUSCTRL_BASE;
  UART0 : TUART_Registers absolute UART0_BASE;
  UART1 : TUART_Registers absolute UART1_BASE;
  SPI0 : TSPI_Registers absolute SPI0_BASE;
  SPI1 : TSPI_Registers absolute SPI1_BASE;
  I2C0 : TI2C_Registers absolute I2C0_BASE;
  I2C1 : TI2C_Registers absolute I2C1_BASE;
  ADC : TADC_Registers absolute ADC_BASE;
  PWM : TPWM_Registers absolute PWM_BASE;
  TIMER : TTIMER_Registers absolute TIMER_BASE;
  WATCHDOG : TWATCHDOG_Registers absolute WATCHDOG_BASE;
  RTC : TRTC_Registers absolute RTC_BASE;
  ROSC : TROSC_Registers absolute ROSC_BASE;
  VREGANDCHIPRESET : TVREGANDCHIPRESET_Registers absolute VREG_AND_CHIP_RESET_BASE;
  DMA : TDMA_Registers absolute DMA_BASE;
  //USBCTRL_BASE = $50100000
  //USBCTRL_DPRAM_BASE = $50100000
  USB : TUSB_Registers absolute USBCTRL_REGS_BASE;
  PIO0 : TPIO_Registers absolute PIO0_BASE;
  PIO1 : TPIO_Registers absolute PIO1_BASE;
  //XIP_AUX_BASE = $50400000
  SIO : TSIO_Registers absolute SIO_BASE;

implementation

procedure NonMaskableInt_Handler; external name 'NonMaskableInt_Handler';
procedure HardFault_Handler; external name 'HardFault_Handler';
procedure SVC_Handler; external name 'SVC_Handler';
procedure PendSV_Handler; external name 'PendSV_Handler';
procedure SysTick_Handler; external name 'SysTick_Handler';
procedure TIMER0_IRQHandler; external name 'TIMER0_IRQHandler';
procedure TIMER1_IRQHandler; external name 'TIMER1_IRQHandler';
procedure TIMER2_IRQHandler; external name 'TIMER2_IRQHandler';
procedure TIMER3_IRQHandler; external name 'TIMER3_IRQHandler';
procedure PWM_IRQHandler; external name 'PWM_IRQHandler';
procedure USB_IRQHandler; external name 'USB_IRQHandler';
procedure XIP_IRQHandler; external name 'XIP_IRQHandler';
procedure PIO0_0_IRQHandler; external name 'PIO0_0_IRQHandler';
procedure PIO0_1_IRQHandler; external name 'PIO0_1_IRQHandler';
procedure PIO1_0_IRQHandler; external name 'PIO1_0_IRQHandler';
procedure PIO1_1_IRQHandler; external name 'PIO1_1_IRQHandler';
procedure DMA0_IRQHandler; external name 'DMA0_IRQHandler';
procedure DMA1_IRQHandler; external name 'DMA1_IRQHandler';
procedure IO_BANK0_IRQHandler; external name 'IO_BANK0_IRQHandler';
procedure IO_QSPI_IRQHandler; external name 'IO_QSPI_IRQHandler';
procedure SIO_PROC0_IRQHandler; external name 'SIO_PROC0_IRQHandler';
procedure SIO_PROC1_IRQHandler; external name 'SIO_PROC1_IRQHandler';
procedure CLOCKS_IRQHandler; external name 'CLOCKS_IRQHandler';
procedure SPI0_IRQHandler; external name 'SPI0_IRQHandler';
procedure SPI1_IRQHandler; external name 'SPI1_IRQHandler';
procedure UART0_IRQHandler; external name 'UART0_IRQHandler';
procedure UART1_IRQHandler; external name 'UART1_IRQHandler';
procedure ADC0_IRQHandler; external name 'ADC0_IRQHandler';
procedure I2C0_IRQHandler; external name 'I2C0_IRQHandler';
procedure I2C1_IRQHandler; external name 'I2C1_IRQHandler';
procedure RTC_IRQHandler; external name 'RTC_IRQHandler';

{$i cortexm0p_start.inc}

procedure Vectors; assembler; nostackframe;
label interrupt_vectors;
asm
  .section ".init.secondstageboot"
  .long  0x4B2FB500
  .long  0x60582021
  .long  0x21026898
  .long  0x60984388
  .long  0x611860D8
  .long  0x4B2B6158
  .long  0x60992100
  .long  0x61592102
  .long  0x22F02101
  .long  0x49285099
  .long  0x21016019
  .long  0x20356099
  .long  0xF83EF000
  .long  0x42902202
  .long  0x2106D014
  .long  0xF0006619
  .long  0x6E19F82E
  .long  0x66192101
  .long  0x66182000
  .long  0xF000661A
  .long  0x6E19F826
  .long  0x6E196E19
  .long  0xF0002005
  .long  0x2101F829
  .long  0xD1F94208
  .long  0x60992100
  .long  0x60194918
  .long  0x60592100
  .long  0x48184917
  .long  0x21016001
  .long  0x21EB6099
  .long  0x21A06619
  .long  0xF0006619
  .long  0x2100F80C
  .long  0x49136099
  .long  0x60014811
  .long  0x60992101
  .long  0x2800BC01
  .long  0x4810D100
  .long  0xB5034700
  .long  0x20046A99
  .long  0xD0FB4201
  .long  0x42012001
  .long  0xBD03D1F8
  .long  0x6618B502
  .long  0xF7FF6618
  .long  0x6E18FFF2
  .long  0xBD026E18
  .long  0x40020000
  .long  0x18000000
  .long  0x00070000
  .long  0x005F0300
  .long  0x00002221
  .long  0x180000F4
  .long  0xA0002022
  .long  0x10000101
  .long  0x00000000
  .long  0x00000000
  .long  0x00000000
  .long  0x00000000
  .long  0x00000000
  .long  0x00000000
  .long  0x00000000
  .long  0x602A273E

  .section ".init.morestuff"
  .long  0xE0004827
  .long  0x49272000
  .long  0xC8066088
  .long  0x8808F381
  .long  0x48254710
  .long  0x28006800
  .long  0xA412D139
  .long  0x2900CC0E
  .long  0xF000D002
  .long  0xE7F9F812
  .long  0x4A214920
  .long  0xE0002000
  .long  0x4291C101
  .long  0x491FD1FC
  .long  0x491F4788
  .long  0x491F4788
  .long  0xBE004788
  .long  0xC901E7FD
  .long  0x429AC201
  .long  0x4770D3FB
  .long  0x7188EBF2
  .long  0x10002780
  .long  0x1000279C
  .long  0x10000164
  .long  0xE71AA390
  .long  0x1000279C
  .long  0x200000C0
  .long  0x20000A5C
  .long  0x10003138
  .long  0x20040000
  .long  0x20040000
  .long  0x10003138
  .long  0x20041000
  .long  0x20041000
  .long  0x00000000
  .long  0x480C4770
  .long  0xFC8AF001
  .long  0xF3EF4700
  .long  0xB2C08005
  .long  0x00004770
  .long  0x10000200
  .long  0xE000ED00
  .long  0xD0000000
  .long  0x20000A5C
  .long  0x20000D30
  .long  0x10001241
  .long  0x10000321
  .long  0x10001361
  .long  0x00005657
  .long  0x50520006
  .long  0x5360B3AB
  .long  0x10002758
  .long  0x50520006
  .long  0x02031C86
  .long  0x10002768
  .long  0x50520006
  .long  0x9DA22254
  .long  0x10002770
  .long  0x50520005
  .long  0x68F465DE
  .long  0x10003138
  .long  0x00000000
  .long  0x00000000
  .long  0x00000000

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
  .long TIMER0_IRQHandler
  .long TIMER1_IRQHandler
  .long TIMER2_IRQHandler
  .long TIMER3_IRQHandler
  .long PWM_IRQHandler
  .long USB_IRQHandler
  .long XIP_IRQHandler
  .long PIO0_0_IRQHandler
  .long PIO0_1_IRQHandler
  .long PIO1_0_IRQHandler
  .long PIO1_1_IRQHandler
  .long DMA0_IRQHandler
  .long DMA1_IRQHandler
  .long IO_BANK0_IRQHandler
  .long IO_QSPI_IRQHandler
  .long SIO_PROC0_IRQHandler
  .long SIO_PROC1_IRQHandler
  .long CLOCKS_IRQHandler
  .long SPI0_IRQHandler
  .long SPI1_IRQHandler
  .long UART0_IRQHandler
  .long UART1_IRQHandler
  .long ADC0_IRQHandler
  .long I2C0_IRQHandler
  .long I2C1_IRQHandler
  .long RTC_IRQHandler


  .weak NonMaskableInt_Handler
  .weak HardFault_Handler
  .weak SVC_Handler
  .weak PendSV_Handler
  .weak SysTick_Handler
  .weak TIMER0_IRQHandler
  .weak TIMER1_IRQHandler
  .weak TIMER2_IRQHandler
  .weak TIMER3_IRQHandler
  .weak PWM_IRQHandler
  .weak USB_IRQHandler
  .weak XIP_IRQHandler
  .weak PIO0_0_IRQHandler
  .weak PIO0_1_IRQHandler
  .weak PIO1_0_IRQHandler
  .weak PIO1_1_IRQHandler
  .weak DMA0_IRQHandler
  .weak DMA1_IRQHandler
  .weak IO_BANK0_IRQHandler
  .weak IO_QSPI_IRQHandler
  .weak SIO_PROC0_IRQHandler
  .weak SIO_PROC1_IRQHandler
  .weak CLOCKS_IRQHandler
  .weak SPI0_IRQHandler
  .weak SPI1_IRQHandler
  .weak UART0_IRQHandler
  .weak UART1_IRQHandler
  .weak ADC0_IRQHandler
  .weak I2C0_IRQHandler
  .weak I2C1_IRQHandler
  .weak RTC_IRQHandler

  .set NonMaskableInt_Handler, _NonMaskableInt_Handler
  .set HardFault_Handler, _HardFault_Handler
  .set SVC_Handler, _SVC_Handler
  .set PendSV_Handler, _PendSV_Handler
  .set SysTick_Handler, _SysTick_Handler
  .set TIMER0_IRQHandler, Haltproc
  .set TIMER1_IRQHandler, Haltproc
  .set TIMER2_IRQHandler, Haltproc
  .set TIMER3_IRQHandler, Haltproc
  .set PWM_IRQHandler, Haltproc
  .set USB_IRQHandler, Haltproc
  .set XIP_IRQHandler, Haltproc
  .set PIO0_0_IRQHandler, Haltproc
  .set PIO0_1_IRQHandler, Haltproc
  .set PIO1_0_IRQHandler, Haltproc
  .set PIO1_1_IRQHandler, Haltproc
  .set DMA0_IRQHandler, Haltproc
  .set DMA1_IRQHandler, Haltproc
  .set IO_BANK0_IRQHandler, Haltproc
  .set IO_QSPI_IRQHandler, Haltproc
  .set SIO_PROC0_IRQHandler, Haltproc
  .set SIO_PROC1_IRQHandler, Haltproc
  .set CLOCKS_IRQHandler, Haltproc
  .set SPI0_IRQHandler, Haltproc
  .set SPI1_IRQHandler, Haltproc
  .set UART0_IRQHandler, Haltproc
  .set UART1_IRQHandler, Haltproc
  .set ADC0_IRQHandler, Haltproc
  .set I2C0_IRQHandler, Haltproc
  .set I2C1_IRQHandler, Haltproc
  .set RTC_IRQHandler, Haltproc

  .text
  end;
end.
