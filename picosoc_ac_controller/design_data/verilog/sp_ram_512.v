module sp_ram_512 (
    input         clk,
    input  [31:0] addr,     // Byte address
    input  [31:0] wdata,
    output [31:0] rdata,
    input         wen,
    input  [3:0]  wstrb
);

  // Internals
  wire        mem_en  = 1'b1;
  wire        write_en = wen && (|wstrb);
  wire        read_en  = !wen;

  wire [8:0]  word_addr = addr[10:2];  // 512 x 32-bit = 2 KB, 9-bit address
  wire [31:0] bm_mask = {
    {8{wstrb[3]}},
    {8{wstrb[2]}},
    {8{wstrb[1]}},
    {8{wstrb[0]}}
  };

  RM_IHPSG13_1P_512x32_c2_bm_bist sram_inst (
    .A_CLK        (clk),
    .A_MEN        (mem_en),
    .A_WEN        (write_en),
    .A_REN        (read_en),
    .A_ADDR       (word_addr),
    .A_DIN        (wdata),
    .A_DOUT       (rdata),
    .A_DLY        (1'b0),
    .A_BM         (bm_mask),

    // Disable BIST
    .A_BIST_CLK   (1'b0),
    .A_BIST_EN    (1'b0),
    .A_BIST_MEN   (1'b0),
    .A_BIST_WEN   (1'b0),
    .A_BIST_REN   (1'b0),
    .A_BIST_ADDR  (9'b0),
    .A_BIST_DIN   (32'b0),
    .A_BIST_BM    (32'b0)
  );

endmodule

