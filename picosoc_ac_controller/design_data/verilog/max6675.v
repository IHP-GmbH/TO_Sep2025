// =============================================================================
// MAX6675 memory-mapped interface for PicoSoC "iomem" bus
//   BASE+0x0 : CTRL/STATUS  [R: {..,ready,busy},  W: start (any write)]
//   BASE+0x4 : DATA         [R: {16'h0, word16}]
//
// Notes:
//  - MAX6675 data is valid when sampled on the RISING edge of SCK (mode 0).
//  - This RTL uses a one-cycle 'ready' pulse after each 16-bit read.
//  - Pure Verilog-2001 (no SystemVerilog typedefs).
// =============================================================================
module max6675 #(
    parameter integer CLK_HZ   = 50_000_000,
    parameter integer SCK_HZ   = 1_000_000,     // keep <= 4.3 MHz
    parameter [31:0] BASE_ADDR = 32'h0300_0000
)(
    input  wire        clk,
    input  wire        resetn,

    // ---------------- PicoSoC iomem bus ----------------
    input  wire        iomem_valid,
    output reg         iomem_ready,
    input  wire [31:0] iomem_addr,
    input  wire [31:0] iomem_wdata,
    input  wire [3:0]  iomem_wstrb,
    output reg  [31:0] iomem_rdata,

    // ---------------- MAX6675 pins ---------------------
    output wire        cs_n,
    output wire        sck,
    input  wire        so
);
    // Address decode (word-aligned window)
    wire sel      = iomem_valid && (iomem_addr[31:3] == BASE_ADDR[31:3]);
    wire sel_ctrl = sel && (iomem_addr[2:0] == 3'b000);
    wire sel_data = sel && (iomem_addr[2:0] == 3'b100);

    // Start on any write to CTRL
    wire start = sel_ctrl && |iomem_wstrb;

    // Reader instance
    wire        busy, ready;
    wire [15:0] word16;

    max6675_reader #(
        .CLK_HZ(CLK_HZ),
        .SCK_HZ(SCK_HZ)
    ) u_reader (
        .clk   (clk),
        .rst   (!resetn),
        .start (start),
        .busy  (busy),
        .cs_n  (cs_n),
        .sck   (sck),
        .miso  (so),
        .data  (word16),
        .ready (ready)
    );

    // Single-cycle ready/return path
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            iomem_ready <= 1'b0;
            iomem_rdata <= 32'h0000_0000;
        end else begin
            iomem_ready <= sel;   // peripheral returns in one cycle
            if (sel_ctrl)      iomem_rdata <= {30'b0, ready, busy};
            else if (sel_data) iomem_rdata <= {16'h0000, word16};
            else               iomem_rdata <= 32'h0000_0000;
        end
    end
endmodule


// =============================================================================
// Tiny read-only shifter for MAX6675 (16 clocks, sample on RISING edge)
// Pure Verilog-2001.
// =============================================================================
module max6675_reader #(
    parameter integer CLK_HZ = 50_000_000,
    parameter integer SCK_HZ = 1_000_000
)(
    input  wire clk,
    input  wire rst,      // active high
    input  wire start,    // pulse to begin a read
    output reg  busy,
    output reg  cs_n,
    output reg  sck,
    input  wire miso,
    output reg  [15:0] data,
    output reg  ready
);
    // Clock divider for SCK (two toggles per full SCK period)
    localparam integer DIV = (CLK_HZ/(2*SCK_HZ)) < 1 ? 1 : (CLK_HZ/(2*SCK_HZ));

    // Verilog-2001 clog2 helper (Yosys-friendly)
    function integer clog2;
        input integer value;
        integer i;
        begin
            clog2 = 0;
            for (i = value-1; i > 0; i = i >> 1)
                clog2 = clog2 + 1;
        end
    endfunction

    // Width of divider counter (at least 1)
    localparam integer DIVW = (clog2(DIV) < 1) ? 1 : clog2(DIV);

    reg [DIVW-1:0] divcnt;
    reg [5:0]      bitcnt;

    // State machine encodings (Verilog-2001)
    localparam [1:0] ST_IDLE  = 2'd0;
    localparam [1:0] ST_SHIFT = 2'd1;
    localparam [1:0] ST_DONE  = 2'd2;
    reg [1:0] st;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            st     <= ST_IDLE;
            cs_n   <= 1'b1;
            sck    <= 1'b0;
            busy   <= 1'b0;
            ready  <= 1'b0;
            data   <= 16'h0000;
            divcnt <= {DIVW{1'b0}};
            bitcnt <= 6'd0;
        end else begin
            ready <= 1'b0; // default

            case (st)
            ST_IDLE: begin
                cs_n <= 1'b1;
                sck  <= 1'b0;
                busy <= 1'b0;
                if (start) begin
                    busy   <= 1'b1;
                    cs_n   <= 1'b0;      // assert CS to start shift
                    bitcnt <= 6'd0;
                    divcnt <= {DIVW{1'b0}};
                    data   <= 16'h0000;
                    st     <= ST_SHIFT;
                end
            end

            ST_SHIFT: begin
                if (divcnt == DIV-1) begin
                    divcnt <= {DIVW{1'b0}};
                    // toggle SCK
                    sck <= ~sck;

                    // sample on RISING edge (old sck==0)
                    if (sck == 1'b0) begin
                        data   <= {data[14:0], miso};
                        bitcnt <= bitcnt + 1'b1;
                        if (bitcnt == 6'd15) begin
                            sck  <= 1'b0;
                            cs_n <= 1'b1;  // deassert CS to end frame
                            st   <= ST_DONE;
                        end
                    end
                end else begin
                    divcnt <= divcnt + {{(DIVW-1){1'b0}}, 1'b1};
                end
            end

            ST_DONE: begin
                busy  <= 1'b0;
                ready <= 1'b1;  // one-cycle pulse
                st    <= ST_IDLE; // CS high triggers next internal conversion
            end

            default: st <= ST_IDLE;
            endcase
        end
    end
endmodule

