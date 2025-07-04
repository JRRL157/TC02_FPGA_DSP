module L16(
    input clk,
    input rst,
    input logic [31:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15,
    output logic [31:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15    
);

    reg [31:0] a0_r, a1_r, a2_r, a3_r, a4_r, a5_r, a6_r, a7_r, a8_r, a9_r, a10_r, a11_r, a12_r, a13_r, a14_r, a15_r;

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
            a8_r <= 32'h0;
            a9_r <= 32'h0;
            a10_r <= 32'h0;
            a11_r <= 32'h0;
            a12_r <= 32'h0;
            a13_r <= 32'h0;
            a14_r <= 32'h0;
            a15_r <= 32'h0;
        end
        else begin
            a0_r <= x0 + x8;
            a8_r <= x0 - x8;            
            a1_r <= x1 + x9;
            a9_r <= x1 - x9;
            a2_r <= x2 + x10;
            a10_r <= x2 - x10;
            a3_r <= x3 + x11;
            a11_r <= x3 - x11;
            a4_r <= x4 + x12;
            a12_r <= x4 - x12;
            a5_r <= x5 + x13;
            a13_r <= x5 - x13;
            a6_r <= x6 + x14;
            a14_r <= x6 - x14;
            a7_r <= x7 + x15;
            a15_r <= x7 - x15;
        end
    end

    L8 l4_0 (
        .clk(clk),
        .rst(rst),
        .x0(a0_r),
        .x1(a1_r),
        .x2(a2_r),
        .x3(a3_r),
        .x4(a4_r),
        .x5(a5_r),
        .x6(a6_r),
        .x7(a7_r),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3),
        .y4(y4),
        .y5(y5),
        .y6(y6),
        .y7(y7)
    );

    L8 l4_1 (
        .clk(clk),
        .rst(rst),
        .x0(a8_r),
        .x1(a9_r),
        .x2(a10_r),
        .x3(a11_r),
        .x4(a12_r),
        .x5(a13_r),
        .x6(a14_r),
        .x7(a15_r),
        .y0(y8),
        .y1(y9),
        .y2(y10),
        .y3(y11),
        .y4(y12),
        .y5(y13),
        .y6(y14),
        .y7(y15)
    );

endmodule