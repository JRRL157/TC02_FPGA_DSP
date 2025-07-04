module L32(
    input clk,
    input rst,
    
    input logic [31:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15,
    input logic [31:0] x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31,
    
    output logic [31:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15,
    output logic [31:0] y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, y31
);

    // Registradores intermediários para o primeiro estágio (butterfly)
    reg [31:0] a0_r, a1_r, a2_r, a3_r, a4_r, a5_r, a6_r, a7_r, a8_r, a9_r, a10_r, a11_r, a12_r, a13_r, a14_r, a15_r;
    reg [31:0] a16_r, a17_r, a18_r, a19_r, a20_r, a21_r, a22_r, a23_r, a24_r, a25_r, a26_r, a27_r, a28_r, a29_r, a30_r, a31_r;

    // Lógica do primeiro estágio: Butterfly (soma e subtração)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reseta todos os registradores para zero
            a0_r <= 32'h0; a1_r <= 32'h0; a2_r <= 32'h0; a3_r <= 32'h0;
            a4_r <= 32'h0; a5_r <= 32'h0; a6_r <= 32'h0; a7_r <= 32'h0;
            a8_r <= 32'h0; a9_r <= 32'h0; a10_r <= 32'h0; a11_r <= 32'h0;
            a12_r <= 32'h0; a13_r <= 32'h0; a14_r <= 32'h0; a15_r <= 32'h0;
            a16_r <= 32'h0; a17_r <= 32'h0; a18_r <= 32'h0; a19_r <= 32'h0;
            a20_r <= 32'h0; a21_r <= 32'h0; a22_r <= 32'h0; a23_r <= 32'h0;
            a24_r <= 32'h0; a25_r <= 32'h0; a26_r <= 32'h0; a27_r <= 32'h0;
            a28_r <= 32'h0; a29_r <= 32'h0; a30_r <= 32'h0; a31_r <= 32'h0;
        end
        else begin            
            a0_r <= x0 + x16;   a16_r <= x0 - x16;
            a1_r <= x1 + x17;   a17_r <= x1 - x17;
            a2_r <= x2 + x18;   a18_r <= x2 - x18;
            a3_r <= x3 + x19;   a19_r <= x3 - x19;
            a4_r <= x4 + x20;   a20_r <= x4 - x20;
            a5_r <= x5 + x21;   a21_r <= x5 - x21;
            a6_r <= x6 + x22;   a22_r <= x6 - x22;
            a7_r <= x7 + x23;   a23_r <= x7 - x23;
            a8_r <= x8 + x24;   a24_r <= x8 - x24;
            a9_r <= x9 + x25;   a25_r <= x9 - x25;
            a10_r <= x10 + x26; a26_r <= x10 - x26;
            a11_r <= x11 + x27; a27_r <= x11 - x27;
            a12_r <= x12 + x28; a28_r <= x12 - x28;
            a13_r <= x13 + x29; a29_r <= x13 - x29;
            a14_r <= x14 + x30; a30_r <= x14 - x30;
            a15_r <= x15 + x31; a31_r <= x15 - x31;
        end
    end
    
    L16 l16_upper (
        .clk(clk),
        .rst(rst),
        .x0(a0_r),   .x1(a1_r),   .x2(a2_r),   .x3(a3_r),
        .x4(a4_r),   .x5(a5_r),   .x6(a6_r),   .x7(a7_r),
        .x8(a8_r),   .x9(a9_r),   .x10(a10_r), .x11(a11_r),
        .x12(a12_r), .x13(a13_r), .x14(a14_r), .x15(a15_r),

        .y0(y0),   .y1(y1),   .y2(y2),   .y3(y3),
        .y4(y4),   .y5(y5),   .y6(y6),   .y7(y7),
        .y8(y8),   .y9(y9),   .y10(y10), .y11(y11),
        .y12(y12), .y13(y13), .y14(y14), .y15(y15)
    );
    
    L16 l16_lower (
        .clk(clk),
        .rst(rst),
        .x0(a16_r), .x1(a17_r), .x2(a18_r), .x3(a19_r),
        .x4(a20_r), .x5(a21_r), .x6(a22_r), .x7(a23_r),
        .x8(a24_r), .x9(a25_r), .x10(a26_r), .x11(a27_r),
        .x12(a28_r), .x13(a29_r), .x14(a30_r), .x15(a31_r),

        .y0(y16), .y1(y17), .y2(y18), .y3(y19),
        .y4(y20), .y5(y21), .y6(y22), .y7(y23),
        .y8(y24), .y9(y25), .y10(y26), .y11(y27),
        .y12(y28), .y13(y29), .y14(y30), .y15(y31)
    );

endmodule