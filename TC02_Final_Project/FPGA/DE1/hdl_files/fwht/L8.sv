module L8(
    input clk,
    input rst,
    input logic [31:0] x0,
    input logic [31:0] x1,
    input logic [31:0] x2,
    input logic [31:0] x3,
    input logic [31:0] x4,
    input logic [31:0] x5,
    input logic [31:0] x6,
    input logic [31:0] x7,

    output logic [31:0] y0,
    output logic [31:0] y1,
    output logic [31:0] y2,
    output logic [31:0] y3,
    output logic [31:0] y4,
    output logic [31:0] y5,
    output logic [31:0] y6,
    output logic [31:0] y7
);

    reg [31:0] a0_r, a1_r, a2_r, a3_r, a4_r, a5_r, a6_r, a7_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            a0_r <= 32'h0;
            a1_r <= 32'h0;
            a2_r <= 32'h0;
            a3_r <= 32'h0;
            a4_r <= 32'h0;
            a5_r <= 32'h0;
            a6_r <= 32'h0;
            a7_r <= 32'h0;
        end
        else begin
            a0_r <= x0 + x4;
            a4_r <= x0 - x4;
            a1_r <= x1 + x5;
            a5_r <= x1 - x5;
            a2_r <= x2 + x6;
            a6_r <= x2 - x6;
            a3_r <= x3 + x7;
            a7_r <= x3 - x7;
        end
    end

    L4 l4_0 (
        .clk(clk),
        .rst(rst),
        .x0(a0_r),
        .x1(a1_r),
        .x2(a2_r),
        .x3(a3_r),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3)
    );

    L4 l4_1 (
        .clk(clk),
        .rst(rst),
        .x0(a4_r),
        .x1(a5_r),
        .x2(a6_r),
        .x3(a7_r),
        .y0(y4),
        .y1(y5),
        .y2(y6),
        .y3(y7)
    );

endmodule