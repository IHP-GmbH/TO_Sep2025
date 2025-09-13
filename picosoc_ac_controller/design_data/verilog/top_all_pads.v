// picosoc_with_pads.v - Full top-level wrapper with all IO pad instantiations

`timescale 1ns / 1ps

module top_all_pads (
    input clk,
    input resetn,

    output        iomem_valid,
    input         iomem_ready,
    output [3:0]  iomem_wstrb,
    output [31:0] iomem_addr,
    output [31:0] iomem_wdata,
    input  [31:0] iomem_rdata,

    input  irq_5,
    input  irq_6,
    input  irq_7,

    input  ser_rx,
    output ser_tx,

    input  flash_io0_di,
    input  flash_io1_di,
    input  flash_io2_di,
    input  flash_io3_di,
    output flash_io0_oe,
    output flash_io1_oe,
    output flash_io2_oe,
    output flash_io3_oe,
    output flash_io0_do,
    output flash_io1_do,
    output flash_io2_do,
    output flash_io3_do,
    output flash_csb,
    output flash_clk
);

  // Internal nets
  wire clk_p, resetn_p;
  wire iomem_valid_p, iomem_ready_p;
  wire [3:0]  iomem_wstrb_p;
  wire [31:0] iomem_addr_p, iomem_wdata_p, iomem_rdata_p;
  wire irq_5_p, irq_6_p, irq_7_p;
  wire ser_rx_p, ser_tx_p;
  wire flash_io0_di_p, flash_io1_di_p, flash_io2_di_p, flash_io3_di_p;
  wire flash_io0_oe_p, flash_io1_oe_p, flash_io2_oe_p, flash_io3_oe_p;
  wire flash_io0_do_p, flash_io1_do_p, flash_io2_do_p, flash_io3_do_p;
  wire flash_csb_p, flash_clk_p;

  // Pad instantiations
  sg13g2_IOPadIn sg13g2_IOPadIn_clk (.pad(clk), .p2c(clk_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_resetn (.pad(resetn), .p2c(resetn_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_irq_5 (.pad(irq_5), .p2c(irq_5_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_irq_6 (.pad(irq_6), .p2c(irq_6_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_irq_7 (.pad(irq_7), .p2c(irq_7_p));

  sg13g2_IOPadIn sg13g2_IOPadIn_ser_rx (.pad(ser_rx), .p2c(ser_rx_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_ser_tx (.pad(ser_tx), .c2p(ser_tx_p));

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

  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_valid (.pad(iomem_valid), .c2p(iomem_valid_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_iomem_ready (.pad(iomem_ready), .p2c(iomem_ready_p));

// =============================================
// MANUAL PAD INSTANTIATION - FULLY UNROLLED
// =============================================

// iomem_wstrb pads (4-bit)
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wstrb_0 (.pad(iomem_wstrb[0]), .c2p(iomem_wstrb_p[0]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wstrb_1 (.pad(iomem_wstrb[1]), .c2p(iomem_wstrb_p[1]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wstrb_2 (.pad(iomem_wstrb[2]), .c2p(iomem_wstrb_p[2]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wstrb_3 (.pad(iomem_wstrb[3]), .c2p(iomem_wstrb_p[3]));

// iomem_addr pads (32-bit)
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_0 (.pad(iomem_addr[0]), .c2p(iomem_addr_p[0]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_1 (.pad(iomem_addr[1]), .c2p(iomem_addr_p[1]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_2 (.pad(iomem_addr[2]), .c2p(iomem_addr_p[2]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_3 (.pad(iomem_addr[3]), .c2p(iomem_addr_p[3]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_4 (.pad(iomem_addr[4]), .c2p(iomem_addr_p[4]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_5 (.pad(iomem_addr[5]), .c2p(iomem_addr_p[5]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_6 (.pad(iomem_addr[6]), .c2p(iomem_addr_p[6]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_7 (.pad(iomem_addr[7]), .c2p(iomem_addr_p[7]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_8 (.pad(iomem_addr[8]), .c2p(iomem_addr_p[8]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_9 (.pad(iomem_addr[9]), .c2p(iomem_addr_p[9]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_10 (.pad(iomem_addr[10]), .c2p(iomem_addr_p[10]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_11 (.pad(iomem_addr[11]), .c2p(iomem_addr_p[11]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_12 (.pad(iomem_addr[12]), .c2p(iomem_addr_p[12]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_13 (.pad(iomem_addr[13]), .c2p(iomem_addr_p[13]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_14 (.pad(iomem_addr[14]), .c2p(iomem_addr_p[14]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_15 (.pad(iomem_addr[15]), .c2p(iomem_addr_p[15]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_16 (.pad(iomem_addr[16]), .c2p(iomem_addr_p[16]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_17 (.pad(iomem_addr[17]), .c2p(iomem_addr_p[17]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_18 (.pad(iomem_addr[18]), .c2p(iomem_addr_p[18]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_19 (.pad(iomem_addr[19]), .c2p(iomem_addr_p[19]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_20 (.pad(iomem_addr[20]), .c2p(iomem_addr_p[20]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_21 (.pad(iomem_addr[21]), .c2p(iomem_addr_p[21]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_22 (.pad(iomem_addr[22]), .c2p(iomem_addr_p[22]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_23 (.pad(iomem_addr[23]), .c2p(iomem_addr_p[23]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_24 (.pad(iomem_addr[24]), .c2p(iomem_addr_p[24]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_25 (.pad(iomem_addr[25]), .c2p(iomem_addr_p[25]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_26 (.pad(iomem_addr[26]), .c2p(iomem_addr_p[26]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_27 (.pad(iomem_addr[27]), .c2p(iomem_addr_p[27]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_28 (.pad(iomem_addr[28]), .c2p(iomem_addr_p[28]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_29 (.pad(iomem_addr[29]), .c2p(iomem_addr_p[29]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_30 (.pad(iomem_addr[30]), .c2p(iomem_addr_p[30]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_addr_31 (.pad(iomem_addr[31]), .c2p(iomem_addr_p[31]));

// iomem_wdata pads (32-bit)
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_0 (.pad(iomem_wdata[0]), .c2p(iomem_wdata_p[0]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_1 (.pad(iomem_wdata[1]), .c2p(iomem_wdata_p[1]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_2 (.pad(iomem_wdata[2]), .c2p(iomem_wdata_p[2]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_3 (.pad(iomem_wdata[3]), .c2p(iomem_wdata_p[3]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_4 (.pad(iomem_wdata[4]), .c2p(iomem_wdata_p[4]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_5 (.pad(iomem_wdata[5]), .c2p(iomem_wdata_p[5]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_6 (.pad(iomem_wdata[6]), .c2p(iomem_wdata_p[6]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_7 (.pad(iomem_wdata[7]), .c2p(iomem_wdata_p[7]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_8 (.pad(iomem_wdata[8]), .c2p(iomem_wdata_p[8]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_9 (.pad(iomem_wdata[9]), .c2p(iomem_wdata_p[9]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_10 (.pad(iomem_wdata[10]), .c2p(iomem_wdata_p[10]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_11 (.pad(iomem_wdata[11]), .c2p(iomem_wdata_p[11]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_12 (.pad(iomem_wdata[12]), .c2p(iomem_wdata_p[12]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_13 (.pad(iomem_wdata[13]), .c2p(iomem_wdata_p[13]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_14 (.pad(iomem_wdata[14]), .c2p(iomem_wdata_p[14]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_15 (.pad(iomem_wdata[15]), .c2p(iomem_wdata_p[15]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_16 (.pad(iomem_wdata[16]), .c2p(iomem_wdata_p[16]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_17 (.pad(iomem_wdata[17]), .c2p(iomem_wdata_p[17]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_18 (.pad(iomem_wdata[18]), .c2p(iomem_wdata_p[18]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_19 (.pad(iomem_wdata[19]), .c2p(iomem_wdata_p[19]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_20 (.pad(iomem_wdata[20]), .c2p(iomem_wdata_p[20]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_21 (.pad(iomem_wdata[21]), .c2p(iomem_wdata_p[21]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_22 (.pad(iomem_wdata[22]), .c2p(iomem_wdata_p[22]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_23 (.pad(iomem_wdata[23]), .c2p(iomem_wdata_p[23]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_24 (.pad(iomem_wdata[24]), .c2p(iomem_wdata_p[24]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_25 (.pad(iomem_wdata[25]), .c2p(iomem_wdata_p[25]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_26 (.pad(iomem_wdata[26]), .c2p(iomem_wdata_p[26]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_27 (.pad(iomem_wdata[27]), .c2p(iomem_wdata_p[27]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_28 (.pad(iomem_wdata[28]), .c2p(iomem_wdata_p[28]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_29 (.pad(iomem_wdata[29]), .c2p(iomem_wdata_p[29]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_30 (.pad(iomem_wdata[30]), .c2p(iomem_wdata_p[30]));
sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wdata_31 (.pad(iomem_wdata[31]), .c2p(iomem_wdata_p[31]));

// iomem_rdata pads (32-bit)
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_0 (.pad(iomem_rdata[0]), .p2c(iomem_rdata_p[0]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_1 (.pad(iomem_rdata[1]), .p2c(iomem_rdata_p[1]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_2 (.pad(iomem_rdata[2]), .p2c(iomem_rdata_p[2]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_3 (.pad(iomem_rdata[3]), .p2c(iomem_rdata_p[3]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_4 (.pad(iomem_rdata[4]), .p2c(iomem_rdata_p[4]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_5 (.pad(iomem_rdata[5]), .p2c(iomem_rdata_p[5]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_6 (.pad(iomem_rdata[6]), .p2c(iomem_rdata_p[6]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_7 (.pad(iomem_rdata[7]), .p2c(iomem_rdata_p[7]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_8 (.pad(iomem_rdata[8]), .p2c(iomem_rdata_p[8]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_9 (.pad(iomem_rdata[9]), .p2c(iomem_rdata_p[9]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_10 (.pad(iomem_rdata[10]), .p2c(iomem_rdata_p[10]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_11 (.pad(iomem_rdata[11]), .p2c(iomem_rdata_p[11]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_12 (.pad(iomem_rdata[12]), .p2c(iomem_rdata_p[12]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_13 (.pad(iomem_rdata[13]), .p2c(iomem_rdata_p[13]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_14 (.pad(iomem_rdata[14]), .p2c(iomem_rdata_p[14]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_15 (.pad(iomem_rdata[15]), .p2c(iomem_rdata_p[15]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_16 (.pad(iomem_rdata[16]), .p2c(iomem_rdata_p[16]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_17 (.pad(iomem_rdata[17]), .p2c(iomem_rdata_p[17]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_18 (.pad(iomem_rdata[18]), .p2c(iomem_rdata_p[18]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_19 (.pad(iomem_rdata[19]), .p2c(iomem_rdata_p[19]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_20 (.pad(iomem_rdata[20]), .p2c(iomem_rdata_p[20]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_21 (.pad(iomem_rdata[21]), .p2c(iomem_rdata_p[21]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_22 (.pad(iomem_rdata[22]), .p2c(iomem_rdata_p[22]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_23 (.pad(iomem_rdata[23]), .p2c(iomem_rdata_p[23]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_24 (.pad(iomem_rdata[24]), .p2c(iomem_rdata_p[24]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_25 (.pad(iomem_rdata[25]), .p2c(iomem_rdata_p[25]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_26 (.pad(iomem_rdata[26]), .p2c(iomem_rdata_p[26]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_27 (.pad(iomem_rdata[27]), .p2c(iomem_rdata_p[27]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_28 (.pad(iomem_rdata[28]), .p2c(iomem_rdata_p[28]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_29 (.pad(iomem_rdata[29]), .p2c(iomem_rdata_p[29]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_30 (.pad(iomem_rdata[30]), .p2c(iomem_rdata_p[30]));
sg13g2_IOPadIn sg13g2_IOPadIn_iomem_rdata_31 (.pad(iomem_rdata[31]), .p2c(iomem_rdata_p[31]));

  // Core instantiation
  picosoc uut (
    .clk(clk_p),
    .resetn(resetn_p),
    .iomem_valid(iomem_valid_p),
    .iomem_ready(iomem_ready_p),
    .iomem_wstrb(iomem_wstrb_p),
    .iomem_addr(iomem_addr_p),
    .iomem_wdata(iomem_wdata_p),
    .iomem_rdata(iomem_rdata_p),
    .irq_5(irq_5_p),
    .irq_6(irq_6_p),
    .irq_7(irq_7_p),
    .ser_rx(ser_rx_p),
    .ser_tx(ser_tx_p),
    .flash_io0_di(flash_io0_di_p),
    .flash_io1_di(flash_io1_di_p),
    .flash_io2_di(flash_io2_di_p),
    .flash_io3_di(flash_io3_di_p),
    .flash_io0_oe(flash_io0_oe_p),
    .flash_io1_oe(flash_io1_oe_p),
    .flash_io2_oe(flash_io2_oe_p),
    .flash_io3_oe(flash_io3_oe_p),
    .flash_io0_do(flash_io0_do_p),
    .flash_io1_do(flash_io1_do_p),
    .flash_io2_do(flash_io2_do_p),
    .flash_io3_do(flash_io3_do_p),
    .flash_csb(flash_csb_p),
    .flash_clk(flash_clk_p)
  );

endmodule

