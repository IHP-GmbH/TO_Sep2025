// top_less_pads.v - Full top-level wrapper with all IO pad instantiations

`timescale 1ns / 1ps

module top_less_pads (
    input clk,
    input resetn,

    output        iomem_valid,
    input         iomem_ready,
    output [3:0]  iomem_wstrb,

    input  irq_5,
    input  irq_6,
    input  irq_7,

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
    output flash_clk,
    
    output cs_n,
    output sck,
    input  so,
    
    output [3:0] comp_drive
);

  
  wire [31:0] iomem_addr;
  wire [31:0] iomem_wdata;
  wire [31:0] iomem_rdata;
  
  // Internal nets
  wire clk_p, resetn_p;
  wire iomem_valid_p, iomem_ready_p;
  wire [3:0]  iomem_wstrb_p;
  wire [31:0] iomem_addr_p, iomem_wdata_p, iomem_rdata_p;
  wire irq_5_p, irq_6_p, irq_7_p;
  wire flash_io0_di_p, flash_io1_di_p, flash_io2_di_p, flash_io3_di_p;
  wire flash_io0_oe_p, flash_io1_oe_p, flash_io2_oe_p, flash_io3_oe_p;
  wire flash_io0_do_p, flash_io1_do_p, flash_io2_do_p, flash_io3_do_p;
  wire flash_csb_p, flash_clk_p;
  wire cs_n_p, sck_p, so_p;
  
  wire [3:0] comp_drive_p;

  // Pad instantiations
  sg13g2_IOPadIn sg13g2_IOPadIn_clk (.pad(clk), .p2c(clk_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_resetn (.pad(resetn), .p2c(resetn_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_irq_5 (.pad(irq_5), .p2c(irq_5_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_irq_6 (.pad(irq_6), .p2c(irq_6_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_irq_7 (.pad(irq_7), .p2c(irq_7_p));


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
  
  // iomem_wstrb pads (4-bit)
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wstrb_0 (.pad(iomem_wstrb[0]), .c2p(iomem_wstrb_p[0]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wstrb_1 (.pad(iomem_wstrb[1]), .c2p(iomem_wstrb_p[1]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wstrb_2 (.pad(iomem_wstrb[2]), .c2p(iomem_wstrb_p[2]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_iomem_wstrb_3 (.pad(iomem_wstrb[3]), .c2p(iomem_wstrb_p[3]));

  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_sck (.pad(sck), .c2p(sck_p));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_cs_n (.pad(cs_n), .c2p(cs_n_p));
  sg13g2_IOPadIn sg13g2_IOPadIn_so (.pad(so), .p2c(so_p));
  
  // 4 bit digital pin pads
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_comp_drive_0 (.pad(comp_drive[0]), .c2p(comp_drive_p[0]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_comp_drive_1 (.pad(comp_drive[1]), .c2p(comp_drive_p[1]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_comp_drive_2 (.pad(comp_drive[2]), .c2p(comp_drive_p[2]));
  sg13g2_IOPadOut16mA sg13g2_IOPadOut16mA_comp_drive_3 (.pad(comp_drive[3]), .c2p(comp_drive_p[3]));

  // Core instantiation
  picosoc picosoc (
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
    .flash_clk(flash_clk_p),
    .cs_n(cs_n_p),
    .sck(sck_p),
    .so(so_p),
    .comp_drive(comp_drive_p)
  );

endmodule
