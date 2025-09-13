/*
 *  PicoSoC (UART removed)
 *  + MAX6675 SPI temperature peripheral @ 0x0300_0000
 *  + 4-bit compressor drive GPIO        @ 0x0300_0010
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

    // External “iomem” bus (if you have off-chip peripherals)
    output        iomem_valid,
    input         iomem_ready,
    output [ 3:0] iomem_wstrb,
    output [31:0] iomem_addr,
    output [31:0] iomem_wdata,
    input  [31:0] iomem_rdata,

    // IRQs (keep as-is)
    input  irq_5,
    input  irq_6,
    input  irq_7,

    // SPI flash
    output flash_csb,
    output flash_clk,
    output flash_io0_oe, output flash_io1_oe, output flash_io2_oe, output flash_io3_oe,
    output flash_io0_do, output flash_io1_do, output flash_io2_do, output flash_io3_do,
    input  flash_io0_di, input  flash_io1_di, input  flash_io2_di, input  flash_io3_di,

    // MAX6675 pins
    output cs_n,
    output sck,
    input  so,

    // NEW: 4-bit compressor drive (16 levels)
    output [3:0] comp_drive
);
    // -------------------- Parameters --------------------
    parameter [0:0] BARREL_SHIFTER     = 0;
    parameter [0:0] ENABLE_MUL         = 1;
    parameter [0:0] ENABLE_DIV         = 0;
    parameter [0:0] ENABLE_FAST_MUL    = 0;
    parameter [0:0] ENABLE_COMPRESSED  = 0;
    parameter [0:0] ENABLE_COUNTERS    = 0;
    parameter [0:0] ENABLE_IRQ_QREGS   = 0;

    parameter integer MEM_WORDS        = 256;
    parameter [31:0] STACKADDR         = (4*MEM_WORDS);
    parameter [31:0] PROGADDR_RESET    = 32'h0010_0000;  // 1 MB into flash
    parameter [31:0] PROGADDR_IRQ      = 32'h0000_0000;

    // -------------------- IRQ fabric --------------------
    reg [31:0] irq;
    wire irq_stall = 1'b0;
    wire irq_uart  = 1'b0; // not used, kept for numbering compatibility

    always @* begin
        irq       = 32'b0;
        irq[3]    = irq_stall;
        irq[4]    = irq_uart;
        irq[5]    = irq_5;
        irq[6]    = irq_6;
        irq[7]    = irq_7;
    end

    // -------------------- CPU memory bus ----------------
    wire        mem_valid;
    wire        mem_instr;
    wire        mem_ready;
    wire [31:0] mem_addr;
    wire [31:0] mem_wdata;
    wire [ 3:0] mem_wstrb;
    wire [31:0] mem_rdata;

    // -------------------- Flash XIP ---------------------
    wire        spimem_ready;
    wire [31:0] spimem_rdata;

    // -------------------- On-chip RAM -------------------
    reg         ram_ready;
    wire [31:0] ram_rdata;

    // -------------------- Peripherals -------------------
    // SPI flash config reg (original picosoc mapping)
    wire        spimemio_cfgreg_sel = mem_valid && (mem_addr == 32'h0200_0000);
    wire [31:0] spimemio_cfgreg_do;

    // MAX6675 (base 0x0300_0000)
    wire        max6675_ready;
    wire [31:0] max6675_rdata;

    // NEW: 4-bit compressor drive GPIO (base 0x0300_0010)
    reg  [3:0]  comp_drive_q;
    wire        gpio4_sel   = mem_valid && (mem_addr == 32'h0300_0010);
    wire        gpio4_ready = gpio4_sel;                 // single-cycle ready
    wire [31:0] gpio4_rdata = {28'b0, comp_drive_q};

    // -------------------- iomem pass-through ------------
    assign iomem_valid = mem_valid && (mem_addr[31:24] > 8'h01);
    assign iomem_wstrb = mem_wstrb;
    assign iomem_addr  = mem_addr;
    assign iomem_wdata = mem_wdata;

    // -------------------- ready / rdata mux -------------
    assign mem_ready = (iomem_valid && iomem_ready) ||
                       spimem_ready ||
                       ram_ready    ||
                       spimemio_cfgreg_sel ||
                       max6675_ready ||
                       gpio4_ready;

    assign mem_rdata = (iomem_valid && iomem_ready) ? iomem_rdata :
                       spimem_ready ? spimem_rdata :
                       ram_ready    ? ram_rdata    :
                       spimemio_cfgreg_sel ? spimemio_cfgreg_do :
                       max6675_ready ? max6675_rdata :
                       gpio4_ready   ? gpio4_rdata  :
                       32'h0000_0000;

    // -------------------- CPU core ----------------------
    picorv32 #(
        .STACKADDR        (STACKADDR),
        .PROGADDR_RESET   (PROGADDR_RESET),
        .PROGADDR_IRQ     (PROGADDR_IRQ),
        .BARREL_SHIFTER   (BARREL_SHIFTER),
        .COMPRESSED_ISA   (ENABLE_COMPRESSED),
        .ENABLE_COUNTERS  (ENABLE_COUNTERS),
        .ENABLE_MUL       (ENABLE_MUL),
        .ENABLE_DIV       (ENABLE_DIV),
        .ENABLE_FAST_MUL  (ENABLE_FAST_MUL),
        .ENABLE_IRQ       (1),
        .ENABLE_IRQ_QREGS (ENABLE_IRQ_QREGS)
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

    // -------------------- SPI flash XIP -----------------
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

    // -------------------- On-chip RAM -------------------
    always @(posedge clk)
        ram_ready <= mem_valid && !mem_ready && mem_addr < 4*MEM_WORDS;

    sp_ram_512 memory_512 (
        .clk   (clk),
        .addr  (mem_addr),
        .wdata (mem_wdata),
        .rdata (ram_rdata),
        .wen   (mem_valid && !mem_ready && mem_addr < 4*MEM_WORDS),
        .wstrb (mem_wstrb)
    );

    // -------------------- MAX6675 -----------------------
    max6675 #(
        .CLK_HZ    (50_000_000),       // set to your system clock
        .SCK_HZ    (1_000_000),        // ≤ 4.3 MHz for MAX6675
        .BASE_ADDR (32'h0300_0000)     // CTRL @ +0x0, DATA @ +0x4
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

    // -------------------- 4-bit GPIO (compressor) ------
    // Write:  mem_addr = 0x0300_0010, use mem_wstrb[0]
    // Read :  returns {28'b0, comp_drive_q}
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            comp_drive_q <= 4'b0000;
        end else if (gpio4_sel && mem_wstrb[0]) begin
            comp_drive_q <= mem_wdata[3:0];
        end
    end

    assign comp_drive = comp_drive_q;

endmodule


// ---------------- Example register file ----------------
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

