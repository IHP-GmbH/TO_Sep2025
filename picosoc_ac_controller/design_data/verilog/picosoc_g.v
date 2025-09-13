/*
 *  PicoSoC - A simple example SoC using PicoRV32
 *  (with MAX6675 SPI temperature sensor peripheral)
 *
 *  Notes:
 *   - Hooks max6675 into mem_ready/mem_rdata so CPU accesses at 0x0300_0000 work.
 *   - No SystemVerilog features used (pure Verilog-2001).
 */

`ifndef PICORV32_REGS
`ifdef PICORV32_V
`error "picosoc.v must be read before picorv32.v!"
`endif
`define PICORV32_REGS picosoc_regs
`endif

`ifndef PICOSOC_MEM
`define PICOSOC_MEM picosoc_mem
`endif

`define PICOSOC_V

module picosoc (
    input  clk,
    input  resetn,

    output        iomem_valid,
    input         iomem_ready,
    output [ 3:0] iomem_wstrb,
    output [31:0] iomem_addr,
    output [31:0] iomem_wdata,
    input  [31:0] iomem_rdata,

    input  irq_5,
    input  irq_6,
    input  irq_7,

    output ser_tx,
    input  ser_rx,

    output flash_csb,
    output flash_clk,

    output flash_io0_oe,
    output flash_io1_oe,
    output flash_io2_oe,
    output flash_io3_oe,

    output flash_io0_do,
    output flash_io1_do,
    output flash_io2_do,
    output flash_io3_do,

    input  flash_io0_di,
    input  flash_io1_di,
    input  flash_io2_di,
    input  flash_io3_di,

    // MAX6675 pins
    output cs_n,
    output sck,
    input  so
);
    parameter [0:0] BARREL_SHIFTER = 1;
    parameter [0:0] ENABLE_MUL = 1;
    parameter [0:0] ENABLE_DIV = 1;
    parameter [0:0] ENABLE_FAST_MUL = 0;
    parameter [0:0] ENABLE_COMPRESSED = 1;
    parameter [0:0] ENABLE_COUNTERS = 1;
    parameter [0:0] ENABLE_IRQ_QREGS = 0;

    parameter integer MEM_WORDS = 256;
    parameter [31:0] STACKADDR = (4*MEM_WORDS);       // end of memory
    parameter [31:0] PROGADDR_RESET = 32'h0010_0000;  // 1 MB into flash
    parameter [31:0] PROGADDR_IRQ   = 32'h0000_0000;

    // IRQ fabric
    reg [31:0] irq;
    wire irq_stall = 0;
    wire irq_uart  = 0;

    always @* begin
        irq = 32'b0;
        irq[3] = irq_stall;
        irq[4] = irq_uart;
        irq[5] = irq_5;
        irq[6] = irq_6;
        irq[7] = irq_7;
    end

    // CPU memory bus
    wire        mem_valid;
    wire        mem_instr;
    wire        mem_ready;
    wire [31:0] mem_addr;
    wire [31:0] mem_wdata;
    wire [ 3:0] mem_wstrb;
    wire [31:0] mem_rdata;

    // SPI flash XIP
    wire        spimem_ready;
    wire [31:0] spimem_rdata;

    // on-chip RAM
    reg         ram_ready;
    wire [31:0] ram_rdata;

    // Map high address region as "iomem" (external peripherals)
    assign iomem_valid = mem_valid && (mem_addr[31:24] > 8'h01);
    assign iomem_wstrb = mem_wstrb;
    assign iomem_addr  = mem_addr;
    assign iomem_wdata = mem_wdata;

    // Peripherals at 0x0200_0000 region (KLayout’s original picosoc space)
    wire spimemio_cfgreg_sel       = mem_valid && (mem_addr == 32'h0200_0000);
    wire [31:0] spimemio_cfgreg_do;

    wire        simpleuart_reg_div_sel = mem_valid && (mem_addr == 32'h0200_0004);
    wire [31:0] simpleuart_reg_div_do;

    wire        simpleuart_reg_dat_sel = mem_valid && (mem_addr == 32'h0200_0008);
    wire [31:0] simpleuart_reg_dat_do;
    wire        simpleuart_reg_dat_wait;

    // ---------- MAX6675 peripheral wires ----------
    wire        max6675_ready;
    wire [31:0] max6675_rdata;

    // Global ready / rdata mux (include all on-chip peripherals)
    assign mem_ready = (iomem_valid && iomem_ready) ||
                       spimem_ready ||
                       ram_ready    ||
                       spimemio_cfgreg_sel ||
                       simpleuart_reg_div_sel ||
                       (simpleuart_reg_dat_sel && !simpleuart_reg_dat_wait) ||
                       max6675_ready;

    assign mem_rdata = (iomem_valid && iomem_ready) ? iomem_rdata :
                       spimem_ready ? spimem_rdata :
                       ram_ready    ? ram_rdata    :
                       spimemio_cfgreg_sel    ? spimemio_cfgreg_do    :
                       simpleuart_reg_div_sel ? simpleuart_reg_div_do :
                       simpleuart_reg_dat_sel ? simpleuart_reg_dat_do :
                       max6675_ready          ? max6675_rdata         :
                       32'h0000_0000;

    // -------------------------------------------------------------------------
    // CPU
    // -------------------------------------------------------------------------
    picorv32 #(
        .STACKADDR(STACKADDR),
        .PROGADDR_RESET(PROGADDR_RESET),
        .PROGADDR_IRQ(PROGADDR_IRQ),
        .BARREL_SHIFTER(BARREL_SHIFTER),
        .COMPRESSED_ISA(ENABLE_COMPRESSED),
        .ENABLE_COUNTERS(ENABLE_COUNTERS),
        .ENABLE_MUL(ENABLE_MUL),
        .ENABLE_DIV(ENABLE_DIV),
        .ENABLE_FAST_MUL(ENABLE_FAST_MUL),
        .ENABLE_IRQ(1),
        .ENABLE_IRQ_QREGS(ENABLE_IRQ_QREGS)
    ) cpu (
        .clk       (clk),
        .resetn    (resetn),
        .mem_valid (mem_valid),
        .mem_instr (mem_instr),
        .mem_ready (mem_ready),
        .mem_addr  (mem_addr),
        .mem_wdata (mem_wdata),
        .mem_wstrb (mem_wstrb),
        .mem_rdata (mem_rdata),
        .irq       (irq)
    );

    // -------------------------------------------------------------------------
    // Execute-in-place SPI flash
    // -------------------------------------------------------------------------
    spimemio spimemio (
        .clk    (clk),
        .resetn (resetn),
        .valid  (mem_valid && mem_addr >= 4*MEM_WORDS && mem_addr < 32'h0200_0000),
        .ready  (spimem_ready),
        .addr   (mem_addr[23:0]),
        .rdata  (spimem_rdata),

        .flash_csb    (flash_csb   ),
        .flash_clk    (flash_clk   ),

        .flash_io0_oe (flash_io0_oe),
        .flash_io1_oe (flash_io1_oe),
        .flash_io2_oe (flash_io2_oe),
        .flash_io3_oe (flash_io3_oe),

        .flash_io0_do (flash_io0_do),
        .flash_io1_do (flash_io1_do),
        .flash_io2_do (flash_io2_do),
        .flash_io3_do (flash_io3_do),

        .flash_io0_di (flash_io0_di),
        .flash_io1_di (flash_io1_di),
        .flash_io2_di (flash_io2_di),
        .flash_io3_di (flash_io3_di),

        .cfgreg_we(spimemio_cfgreg_sel ? mem_wstrb : 4'b0000),
        .cfgreg_di(mem_wdata),
        .cfgreg_do(spimemio_cfgreg_do)
    );

    // -------------------------------------------------------------------------
    // UART
    // -------------------------------------------------------------------------
    simpleuart simpleuart (
        .clk         (clk),
        .resetn      (resetn),

        .ser_tx      (ser_tx),
        .ser_rx      (ser_rx),

        .reg_div_we  (simpleuart_reg_div_sel ? mem_wstrb : 4'b0000),
        .reg_div_di  (mem_wdata),
        .reg_div_do  (simpleuart_reg_div_do),

        .reg_dat_we  (simpleuart_reg_dat_sel ? mem_wstrb[0] : 1'b0),
        .reg_dat_re  (simpleuart_reg_dat_sel && !mem_wstrb),
        .reg_dat_di  (mem_wdata),
        .reg_dat_do  (simpleuart_reg_dat_do),
        .reg_dat_wait(simpleuart_reg_dat_wait)
    );

    // -------------------------------------------------------------------------
    // On-chip RAM (ready pulse)
    // -------------------------------------------------------------------------
    always @(posedge clk)
        ram_ready <= mem_valid && !mem_ready && mem_addr < 4*MEM_WORDS;

    // Example RAM wrapper (replace with your memory macro as needed)
    sp_ram_512 memory_512 (
        .clk  (clk),
        .addr (mem_addr),
        .wdata(mem_wdata),
        .rdata(ram_rdata),
        .wen  (mem_valid && !mem_ready && mem_addr < 4*MEM_WORDS),
        .wstrb(mem_wstrb)
    );

    // -------------------------------------------------------------------------
    // MAX6675 temperature sensor peripheral (memory-mapped at 0x0300_0000)
    // -------------------------------------------------------------------------
    max6675 #(
        .CLK_HZ   (50_000_000),         // SoC clock (set to your clock)
        .SCK_HZ   (1_000_000),          // <= 4.3 MHz for MAX6675
        .BASE_ADDR(32'h0300_0000)       // CTRL @ +0x0, DATA @ +0x4
    ) u_max6675 (
        .clk         (clk),
        .resetn      (resetn),

        .iomem_valid (iomem_valid),
        .iomem_ready (max6675_ready),
        .iomem_addr  (iomem_addr),
        .iomem_wdata (iomem_wdata),
        .iomem_wstrb (iomem_wstrb),
        .iomem_rdata (max6675_rdata),

        .cs_n (cs_n),
        .sck  (sck),
        .so   (so)
    );

endmodule

// -----------------------------------------------------------------------------
// Example register file (unchanged)
// -----------------------------------------------------------------------------
module picosoc_regs (
    input clk, wen,
    input [5:0] waddr,
    input [5:0] raddr1,
    input [5:0] raddr2,
    input [31:0] wdata,
    output [31:0] rdata1,
    output [31:0] rdata2
);
    reg [31:0] regs [0:31];

    always @(posedge clk)
        if (wen) regs[waddr[4:0]] <= wdata;

    assign rdata1 = regs[raddr1[4:0]];
    assign rdata2 = regs[raddr2[4:0]];
endmodule

/* Reference soft RAM (kept commented, as in original)
module picosoc_mem #(
    parameter integer WORDS = 256
) (
    input clk,
    input [3:0] wen,
    input [21:0] addr,
    input [31:0] wdata,
    output reg [31:0] rdata
);
    reg [31:0] mem [0:WORDS-1];
    always @(posedge clk) begin
        rdata <= mem[addr];
        if (wen[0]) mem[addr][ 7: 0] <= wdata[ 7: 0];
        if (wen[1]) mem[addr][15: 8] <= wdata[15: 8];
        if (wen[2]) mem[addr][23:16] <= wdata[23:16];
        if (wen[3]) mem[addr][31:24] <= wdata[31:24];
    end
endmodule
*/

