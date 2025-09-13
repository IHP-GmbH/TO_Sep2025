/*
 *  PicoSoC - A simple example SoC using PicoRV32
 *
 *  Copyright (C) 2017  Claire Xenia Wolf <claire@yosyshq.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
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

// this macro can be used to check if the verilog files in your
// design are read in the correct order.
`define PICOSOC_V

module picosoc (
	input clk_p,
	input resetn_p,

	output        iomem_valid_p,
	input         iomem_ready_p,
	output [ 3:0] iomem_wstrb_p,
	output [31:0] iomem_addr_p,
	output [31:0] iomem_wdata_p,
	input  [31:0] iomem_rdata_p,

	input  irq_5_p,
	input  irq_6_p,
	input  irq_7_p,

	output ser_tx_p,
	input  ser_rx_p,

	output flash_csb_p,
	output flash_clk_p,

	output flash_io0_oe_p,
	output flash_io1_oe_p,
	output flash_io2_oe_p,
	output flash_io3_oe_p,

	output flash_io0_do_p,
	output flash_io1_do_p,
	output flash_io2_do_p,
	output flash_io3_do_p,

	input  flash_io0_di_p,
	input  flash_io1_di_p,
	input  flash_io2_di_p,
	input  flash_io3_di_p
);

	// Internal wires without _p suffix
	wire clk;
	wire resetn;
	
	wire iomem_valid;
	wire iomem_ready;
	wire [3:0] iomem_wstrb;
	wire [31:0] iomem_addr;
	wire [31:0] iomem_wdata;
	wire [31:0] iomem_rdata;
	
	wire irq_5;
	wire irq_6;
	wire irq_7;
	
	wire ser_tx;
	wire ser_rx;
	
	wire flash_csb;
	wire flash_clk;
	
	wire flash_io0_oe;
	wire flash_io1_oe;
	wire flash_io2_oe;
	wire flash_io3_oe;
	
	wire flash_io0_do;
	wire flash_io1_do;
	wire flash_io2_do;
	wire flash_io3_do;
	
	wire flash_io0_di;
	wire flash_io1_di;
	wire flash_io2_di;
	wire flash_io3_di;
	
	parameter [0:0] BARREL_SHIFTER = 1;
	parameter [0:0] ENABLE_MUL = 1;
	parameter [0:0] ENABLE_DIV = 1;
	parameter [0:0] ENABLE_FAST_MUL = 0;
	parameter [0:0] ENABLE_COMPRESSED = 1;
	parameter [0:0] ENABLE_COUNTERS = 1;
	parameter [0:0] ENABLE_IRQ_QREGS = 0;

	parameter integer MEM_WORDS = 256;
	parameter [31:0] STACKADDR = (4*MEM_WORDS);       // end of memory
	parameter [31:0] PROGADDR_RESET = 32'h 0010_0000; // 1 MB into flash
	parameter [31:0] PROGADDR_IRQ = 32'h 0000_0000;

	reg [31:0] irq;
	wire irq_stall = 0;
	wire irq_uart = 0;

// instantiate pad module

// Pad instantiation
pads pad_inst (
    // Clock and Reset
    .clk(clk_p),
    .resetn(resetn_p),
    .clk_p(clk),
    .resetn_p(resetn),

    // IOMEM Interface
    .iomem_valid(iomem_valid_p),
    .iomem_valid_p(iomem_valid),
    .iomem_ready_p(iomem_ready),
    .iomem_ready(iomem_ready_p),
    .iomem_wstrb(iomem_wstrb_p),
    .iomem_wstrb_p(iomem_wstrb),
    .iomem_addr(iomem_addr_p),
    .iomem_addr_p(iomem_addr),
    .iomem_wdata(iomem_wdata_p),
    .iomem_wdata_p(iomem_wdata),
    .iomem_rdata_p(iomem_rdata),
    .iomem_rdata(iomem_rdata_p),

    // Interrupts
    .irq_5(irq_5_p),
    .irq_6(irq_6_p),
    .irq_7(irq_7_p),
    .irq_5_p(irq_5),
    .irq_6_p(irq_6),
    .irq_7_p(irq_7),

    // Serial
    .ser_rx(ser_rx_p),
    .ser_rx_p(ser_rx),
    .ser_tx_p(ser_tx),
    .ser_tx(ser_tx_p),

    // Flash Interface
    .flash_io0_di(flash_io0_di_p),
    .flash_io0_di_p(flash_io0_di),
    .flash_io1_di(flash_io1_di_p),
    .flash_io1_di_p(flash_io1_di),
    .flash_io2_di(flash_io2_di_p),
    .flash_io2_di_p(flash_io2_di),
    .flash_io3_di(flash_io3_di_p),
    .flash_io3_di_p(flash_io3_di),
    
    .flash_io0_oe(flash_io0_oe_p),
    .flash_io0_oe_p(flash_io0_oe),
    .flash_io1_oe(flash_io1_oe_p),
    .flash_io1_oe_p(flash_io1_oe),
    .flash_io2_oe(flash_io2_oe_p),
    .flash_io2_oe_p(flash_io2_oe),
    .flash_io3_oe(flash_io3_oe_p),
    .flash_io3_oe_p(flash_io3_oe),
    
    .flash_io0_do(flash_io0_do_p),
    .flash_io0_do_p(flash_io0_do),
    .flash_io1_do(flash_io1_do_p),
    .flash_io1_do_p(flash_io1_do),
    .flash_io2_do(flash_io2_do_p),
    .flash_io2_do_p(flash_io2_do),
    .flash_io3_do(flash_io3_do_p),
    .flash_io3_do_p(flash_io3_do),
    
    .flash_csb(flash_csb_p),
    .flash_csb_p(flash_csb),
    .flash_clk(flash_clk_p),
    .flash_clk_p(flash_clk)
);




	always @* begin
		irq = 0;
		irq[3] = irq_stall;
		irq[4] = irq_uart;
		irq[5] = irq_5;
		irq[6] = irq_6;
		irq[7] = irq_7;
	end

	wire mem_valid;
	wire mem_instr;
	wire mem_ready;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
	wire [3:0] mem_wstrb;
	wire [31:0] mem_rdata;

	wire spimem_ready;
	wire [31:0] spimem_rdata;

	reg ram_ready;
	wire [31:0] ram_rdata;

	assign iomem_valid = mem_valid && (mem_addr[31:24] > 8'h 01);
	assign iomem_wstrb = mem_wstrb;
	assign iomem_addr = mem_addr;
	assign iomem_wdata = mem_wdata;

	wire spimemio_cfgreg_sel = mem_valid && (mem_addr == 32'h 0200_0000);
	wire [31:0] spimemio_cfgreg_do;

	wire        simpleuart_reg_div_sel = mem_valid && (mem_addr == 32'h 0200_0004);
	wire [31:0] simpleuart_reg_div_do;

	wire        simpleuart_reg_dat_sel = mem_valid && (mem_addr == 32'h 0200_0008);
	wire [31:0] simpleuart_reg_dat_do;
	wire        simpleuart_reg_dat_wait;

	assign mem_ready = (iomem_valid && iomem_ready) || spimem_ready || ram_ready || spimemio_cfgreg_sel ||
			simpleuart_reg_div_sel || (simpleuart_reg_dat_sel && !simpleuart_reg_dat_wait);

	assign mem_rdata = (iomem_valid && iomem_ready) ? iomem_rdata : spimem_ready ? spimem_rdata : ram_ready ? ram_rdata :
			spimemio_cfgreg_sel ? spimemio_cfgreg_do : simpleuart_reg_div_sel ? simpleuart_reg_div_do :
			simpleuart_reg_dat_sel ? simpleuart_reg_dat_do : 32'h 0000_0000;

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
		.clk         (clk        ),
		.resetn      (resetn     ),
		.mem_valid   (mem_valid  ),
		.mem_instr   (mem_instr  ),
		.mem_ready   (mem_ready  ),
		.mem_addr    (mem_addr   ),
		.mem_wdata   (mem_wdata  ),
		.mem_wstrb   (mem_wstrb  ),
		.mem_rdata   (mem_rdata  ),
		.irq         (irq        )
	);

	spimemio spimemio (
		.clk    (clk),
		.resetn (resetn),
		.valid  (mem_valid && mem_addr >= 4*MEM_WORDS && mem_addr < 32'h 0200_0000),
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

		.cfgreg_we(spimemio_cfgreg_sel ? mem_wstrb : 4'b 0000),
		.cfgreg_di(mem_wdata),
		.cfgreg_do(spimemio_cfgreg_do)
	);

	simpleuart simpleuart (
		.clk         (clk         ),
		.resetn      (resetn      ),

		.ser_tx      (ser_tx      ),
		.ser_rx      (ser_rx      ),

		.reg_div_we  (simpleuart_reg_div_sel ? mem_wstrb : 4'b 0000),
		.reg_div_di  (mem_wdata),
		.reg_div_do  (simpleuart_reg_div_do),

		.reg_dat_we  (simpleuart_reg_dat_sel ? mem_wstrb[0] : 1'b 0),
		.reg_dat_re  (simpleuart_reg_dat_sel && !mem_wstrb),
		.reg_dat_di  (mem_wdata),
		.reg_dat_do  (simpleuart_reg_dat_do),
		.reg_dat_wait(simpleuart_reg_dat_wait)
	);

	always @(posedge clk)
		ram_ready <= mem_valid && !mem_ready && mem_addr < 4*MEM_WORDS;
/*
	`PICOSOC_MEM #(
		.WORDS(MEM_WORDS)
	) memory (
		.clk(clk),
		.wen((mem_valid && !mem_ready && mem_addr < 4*MEM_WORDS) ? mem_wstrb : 4'b0),
		.addr(mem_addr[23:2]),
		.wdata(mem_wdata),
		.rdata(ram_rdata)
	);
*/	


sp_ram memory (
	.clk(clk),
	.wen(mem_valid && !mem_ready && mem_addr < 4*MEM_WORDS),
	.wstrb(mem_wstrb),
	.addr(mem_addr),
	.wdata(mem_wdata),
	.rdata(ram_rdata)
);

endmodule

// Implementation note:
// Replace the following two modules with wrappers for your SRAM cells.

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

/*
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






module pads (
    // Clock and Reset
    input clk,
    input resetn,
    output clk_p,
    output resetn_p,

    // IOMEM Interface
    input        iomem_valid,
    output       iomem_valid_p,
    output       iomem_ready_p,
    input        iomem_ready,
    input [3:0]  iomem_wstrb,
    output [3:0] iomem_wstrb_p,
    input [31:0] iomem_addr,
    output [31:0] iomem_addr_p,
    input [31:0] iomem_wdata,
    output [31:0] iomem_wdata_p,
    output [31:0] iomem_rdata_p,
    input [31:0]  iomem_rdata,

    // Interrupts
    input  irq_5,
    input  irq_6,
    input  irq_7,
    output irq_5_p,
    output irq_6_p,
    output irq_7_p,

    // Serial
    input  ser_rx,
    output ser_rx_p,
    output ser_tx_p,
    input  ser_tx,

    // Flash Interface
    input  flash_io0_di,
    output flash_io0_di_p,
    input  flash_io1_di,
    output flash_io1_di_p,
    input  flash_io2_di,
    output flash_io2_di_p,
    input  flash_io3_di,
    output flash_io3_di_p,
    
    input  flash_io0_oe,
    output flash_io0_oe_p,
    input  flash_io1_oe,
    output flash_io1_oe_p,
    input  flash_io2_oe,
    output flash_io2_oe_p,
    input  flash_io3_oe,
    output flash_io3_oe_p,
    
    input  flash_io0_do,
    output flash_io0_do_p,
    input  flash_io1_do,
    output flash_io1_do_p,
    input  flash_io2_do,
    output flash_io2_do_p,
    input  flash_io3_do,
    output flash_io3_do_p,
    
    input  flash_csb,
    output flash_csb_p,
    input  flash_clk,
    output flash_clk_p
);

  // Input Pad instantiations (external -> internal)
  sg13g2_IOPadIn sg13g2_IOPadIn_clk (.pad(clk), .p2c(clk_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_resetn (.pad(resetn), .p2c(resetn_p));
  
  // IOMEM Interface
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_valid (.pad(iomem_valid), .p2c(iomem_valid_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_ready (.pad(iomem_ready), .p2c(iomem_ready_p));
  
  // iomem_wstrb (4-bit)
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wstrb_0 (.pad(iomem_wstrb[0]), .p2c(iomem_wstrb_p[0]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wstrb_1 (.pad(iomem_wstrb[1]), .p2c(iomem_wstrb_p[1]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wstrb_2 (.pad(iomem_wstrb[2]), .p2c(iomem_wstrb_p[2]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wstrb_3 (.pad(iomem_wstrb[3]), .p2c(iomem_wstrb_p[3]));
  
  // iomem_addr (32-bit)
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_0 (.pad(iomem_addr[0]), .p2c(iomem_addr_p[0]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_1 (.pad(iomem_addr[1]), .p2c(iomem_addr_p[1]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_2 (.pad(iomem_addr[2]), .p2c(iomem_addr_p[2]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_3 (.pad(iomem_addr[3]), .p2c(iomem_addr_p[3]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_4 (.pad(iomem_addr[4]), .p2c(iomem_addr_p[4]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_5 (.pad(iomem_addr[5]), .p2c(iomem_addr_p[5]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_6 (.pad(iomem_addr[6]), .p2c(iomem_addr_p[6]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_7 (.pad(iomem_addr[7]), .p2c(iomem_addr_p[7]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_8 (.pad(iomem_addr[8]), .p2c(iomem_addr_p[8]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_9 (.pad(iomem_addr[9]), .p2c(iomem_addr_p[9]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_10 (.pad(iomem_addr[10]), .p2c(iomem_addr_p[10]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_11 (.pad(iomem_addr[11]), .p2c(iomem_addr_p[11]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_12 (.pad(iomem_addr[12]), .p2c(iomem_addr_p[12]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_13 (.pad(iomem_addr[13]), .p2c(iomem_addr_p[13]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_14 (.pad(iomem_addr[14]), .p2c(iomem_addr_p[14]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_15 (.pad(iomem_addr[15]), .p2c(iomem_addr_p[15]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_16 (.pad(iomem_addr[16]), .p2c(iomem_addr_p[16]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_17 (.pad(iomem_addr[17]), .p2c(iomem_addr_p[17]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_18 (.pad(iomem_addr[18]), .p2c(iomem_addr_p[18]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_19 (.pad(iomem_addr[19]), .p2c(iomem_addr_p[19]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_20 (.pad(iomem_addr[20]), .p2c(iomem_addr_p[20]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_21 (.pad(iomem_addr[21]), .p2c(iomem_addr_p[21]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_22 (.pad(iomem_addr[22]), .p2c(iomem_addr_p[22]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_23 (.pad(iomem_addr[23]), .p2c(iomem_addr_p[23]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_24 (.pad(iomem_addr[24]), .p2c(iomem_addr_p[24]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_25 (.pad(iomem_addr[25]), .p2c(iomem_addr_p[25]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_26 (.pad(iomem_addr[26]), .p2c(iomem_addr_p[26]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_27 (.pad(iomem_addr[27]), .p2c(iomem_addr_p[27]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_28 (.pad(iomem_addr[28]), .p2c(iomem_addr_p[28]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_29 (.pad(iomem_addr[29]), .p2c(iomem_addr_p[29]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_30 (.pad(iomem_addr[30]), .p2c(iomem_addr_p[30]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_addr_31 (.pad(iomem_addr[31]), .p2c(iomem_addr_p[31]));
  
  // iomem_wdata (32-bit)
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_0 (.pad(iomem_wdata[0]), .p2c(iomem_wdata_p[0]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_1 (.pad(iomem_wdata[1]), .p2c(iomem_wdata_p[1]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_2 (.pad(iomem_wdata[2]), .p2c(iomem_wdata_p[2]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_3 (.pad(iomem_wdata[3]), .p2c(iomem_wdata_p[3]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_4 (.pad(iomem_wdata[4]), .p2c(iomem_wdata_p[4]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_5 (.pad(iomem_wdata[5]), .p2c(iomem_wdata_p[5]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_6 (.pad(iomem_wdata[6]), .p2c(iomem_wdata_p[6]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_7 (.pad(iomem_wdata[7]), .p2c(iomem_wdata_p[7]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_8 (.pad(iomem_wdata[8]), .p2c(iomem_wdata_p[8]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_9 (.pad(iomem_wdata[9]), .p2c(iomem_wdata_p[9]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_10 (.pad(iomem_wdata[10]), .p2c(iomem_wdata_p[10]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_11 (.pad(iomem_wdata[11]), .p2c(iomem_wdata_p[11]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_12 (.pad(iomem_wdata[12]), .p2c(iomem_wdata_p[12]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_13 (.pad(iomem_wdata[13]), .p2c(iomem_wdata_p[13]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_14 (.pad(iomem_wdata[14]), .p2c(iomem_wdata_p[14]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_15 (.pad(iomem_wdata[15]), .p2c(iomem_wdata_p[15]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_16 (.pad(iomem_wdata[16]), .p2c(iomem_wdata_p[16]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_17 (.pad(iomem_wdata[17]), .p2c(iomem_wdata_p[17]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_18 (.pad(iomem_wdata[18]), .p2c(iomem_wdata_p[18]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_19 (.pad(iomem_wdata[19]), .p2c(iomem_wdata_p[19]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_20 (.pad(iomem_wdata[20]), .p2c(iomem_wdata_p[20]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_21 (.pad(iomem_wdata[21]), .p2c(iomem_wdata_p[21]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_22 (.pad(iomem_wdata[22]), .p2c(iomem_wdata_p[22]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_23 (.pad(iomem_wdata[23]), .p2c(iomem_wdata_p[23]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_24 (.pad(iomem_wdata[24]), .p2c(iomem_wdata_p[24]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_25 (.pad(iomem_wdata[25]), .p2c(iomem_wdata_p[25]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_26 (.pad(iomem_wdata[26]), .p2c(iomem_wdata_p[26]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_27 (.pad(iomem_wdata[27]), .p2c(iomem_wdata_p[27]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_28 (.pad(iomem_wdata[28]), .p2c(iomem_wdata_p[28]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_29 (.pad(iomem_wdata[29]), .p2c(iomem_wdata_p[29]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_30 (.pad(iomem_wdata[30]), .p2c(iomem_wdata_p[30]));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_wdata_31 (.pad(iomem_wdata[31]), .p2c(iomem_wdata_p[31]));
  
  // iomem_rdata (32-bit)
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_0 (.pad(iomem_rdata[0]), .c2p(iomem_rdata_p[0]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_1 (.pad(iomem_rdata[1]), .c2p(iomem_rdata_p[1]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_2 (.pad(iomem_rdata[2]), .c2p(iomem_rdata_p[2]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_3 (.pad(iomem_rdata[3]), .c2p(iomem_rdata_p[3]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_4 (.pad(iomem_rdata[4]), .c2p(iomem_rdata_p[4]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_5 (.pad(iomem_rdata[5]), .c2p(iomem_rdata_p[5]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_6 (.pad(iomem_rdata[6]), .c2p(iomem_rdata_p[6]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_7 (.pad(iomem_rdata[7]), .c2p(iomem_rdata_p[7]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_8 (.pad(iomem_rdata[8]), .c2p(iomem_rdata_p[8]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_9 (.pad(iomem_rdata[9]), .c2p(iomem_rdata_p[9]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_10 (.pad(iomem_rdata[10]), .c2p(iomem_rdata_p[10]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_11 (.pad(iomem_rdata[11]), .c2p(iomem_rdata_p[11]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_12 (.pad(iomem_rdata[12]), .c2p(iomem_rdata_p[12]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_13 (.pad(iomem_rdata[13]), .c2p(iomem_rdata_p[13]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_14 (.pad(iomem_rdata[14]), .c2p(iomem_rdata_p[14]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_15 (.pad(iomem_rdata[15]), .c2p(iomem_rdata_p[15]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_16 (.pad(iomem_rdata[16]), .c2p(iomem_rdata_p[16]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_17 (.pad(iomem_rdata[17]), .c2p(iomem_rdata_p[17]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_18 (.pad(iomem_rdata[18]), .c2p(iomem_rdata_p[18]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_19 (.pad(iomem_rdata[19]), .c2p(iomem_rdata_p[19]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_20 (.pad(iomem_rdata[20]), .c2p(iomem_rdata_p[20]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_21 (.pad(iomem_rdata[21]), .c2p(iomem_rdata_p[21]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_22 (.pad(iomem_rdata[22]), .c2p(iomem_rdata_p[22]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_23 (.pad(iomem_rdata[23]), .c2p(iomem_rdata_p[23]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_24 (.pad(iomem_rdata[24]), .c2p(iomem_rdata_p[24]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_25 (.pad(iomem_rdata[25]), .c2p(iomem_rdata_p[25]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_26 (.pad(iomem_rdata[26]), .c2p(iomem_rdata_p[26]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_27 (.pad(iomem_rdata[27]), .c2p(iomem_rdata_p[27]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_28 (.pad(iomem_rdata[28]), .c2p(iomem_rdata_p[28]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_29 (.pad(iomem_rdata[29]), .c2p(iomem_rdata_p[29]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_30 (.pad(iomem_rdata[30]), .c2p(iomem_rdata_p[30]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_rdata_31 (.pad(iomem_rdata[31]), .c2p(iomem_rdata_p[31]));

  // Interrupts
  sg13g2_IOPadIn sg13g2_IOPadIn_irq_5 (.pad(irq_5), .p2c(irq_5_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_irq_6 (.pad(irq_6), .p2c(irq_6_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_irq_7 (.pad(irq_7), .p2c(irq_7_p));

  // Serial
  sg13g2_IOPadIn sg13g2_IOPadIn_ser_rx (.pad(ser_rx), .p2c(ser_rx_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_ser_tx (.pad(ser_tx), .c2p(ser_tx_p));

  // Flash Interface
  sg13g2_IOPadIn sg13g2_IOPadIn_flash_io0_di (.pad(flash_io0_di), .p2c(flash_io0_di_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_flash_io1_di (.pad(flash_io1_di), .p2c(flash_io1_di_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_flash_io2_di (.pad(flash_io2_di), .p2c(flash_io2_di_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_flash_io3_di (.pad(flash_io3_di), .p2c(flash_io3_di_p));

  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_io0_oe (.pad(flash_io0_oe), .c2p(flash_io0_oe_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_io1_oe (.pad(flash_io1_oe), .c2p(flash_io1_oe_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_io2_oe (.pad(flash_io2_oe), .c2p(flash_io2_oe_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_io3_oe (.pad(flash_io3_oe), .c2p(flash_io3_oe_p));

  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_io0_do (.pad(flash_io0_do), .c2p(flash_io0_do_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_io1_do (.pad(flash_io1_do), .c2p(flash_io1_do_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_io2_do (.pad(flash_io2_do), .c2p(flash_io2_do_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_io3_do (.pad(flash_io3_do), .c2p(flash_io3_do_p));

  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_csb (.pad(flash_csb), .c2p(flash_csb_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_flash_clk (.pad(flash_clk), .c2p(flash_clk_p));

endmodule


