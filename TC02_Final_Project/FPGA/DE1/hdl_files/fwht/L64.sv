module L64(
    input clk,
    input rst,

    input logic [31:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15,
    input logic [31:0] x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31,
    input logic [31:0] x32, x33, x34, x35, x36, x37, x38, x39, x40, x41, x42, x43, x44, x45, x46, x47,
    input logic [31:0] x48, x49, x50, x51, x52, x53, x54, x55, x56, x57, x58, x59, x60, x61, x62, x63,

    output logic [31:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15,
    output logic [31:0] y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, y31,
    output logic [31:0] y32, y33, y34, y35, y36, y37, y38, y39, y40, y41, y42, y43, y44, y45, y46, y47,
    output logic [31:0] y48, y49, y50, y51, y52, y53, y54, y55, y56, y57, y58, y59, y60, y61, y62, y63
);

    reg [31:0] a_upper[32];
    reg [31:0] a_lower[32];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 32; i++) begin
                a_upper[i] <= 32'h0;
                a_lower[i] <= 32'h0;
            end
        end
        else begin            
            a_upper[0]  <= x0 + x32;   a_upper[1]  <= x1 + x33;
            a_upper[2]  <= x2 + x34;   a_upper[3]  <= x3 + x35;
            a_upper[4]  <= x4 + x36;   a_upper[5]  <= x5 + x37;
            a_upper[6]  <= x6 + x38;   a_upper[7]  <= x7 + x39;
            a_upper[8]  <= x8 + x40;   a_upper[9]  <= x9 + x41;
            a_upper[10] <= x10 + x42;  a_upper[11] <= x11 + x43;
            a_upper[12] <= x12 + x44;  a_upper[13] <= x13 + x45;
            a_upper[14] <= x14 + x46;  a_upper[15] <= x15 + x47;
            a_upper[16] <= x16 + x48;  a_upper[17] <= x17 + x49;
            a_upper[18] <= x18 + x50;  a_upper[19] <= x19 + x51;
            a_upper[20] <= x20 + x52;  a_upper[21] <= x21 + x53;
            a_upper[22] <= x22 + x54;  a_upper[23] <= x23 + x55;
            a_upper[24] <= x24 + x56;  a_upper[25] <= x25 + x57;
            a_upper[26] <= x26 + x58;  a_upper[27] <= x27 + x59;
            a_upper[28] <= x28 + x60;  a_upper[29] <= x29 + x61;
            a_upper[30] <= x30 + x62;  a_upper[31] <= x31 + x63;
            
            a_lower[0]  <= x0 - x32;   a_lower[1]  <= x1 - x33;
            a_lower[2]  <= x2 - x34;   a_lower[3]  <= x3 - x35;
            a_lower[4]  <= x4 - x36;   a_lower[5]  <= x5 - x37;
            a_lower[6]  <= x6 - x38;   a_lower[7]  <= x7 - x39;
            a_lower[8]  <= x8 - x40;   a_lower[9]  <= x9 - x41;
            a_lower[10] <= x10 - x42;  a_lower[11] <= x11 - x43;
            a_lower[12] <= x12 - x44;  a_lower[13] <= x13 - x45;
            a_lower[14] <= x14 - x46;  a_lower[15] <= x15 - x47;
            a_lower[16] <= x16 - x48;  a_lower[17] <= x17 - x49;
            a_lower[18] <= x18 - x50;  a_lower[19] <= x19 - x51;
            a_lower[20] <= x20 - x52;  a_lower[21] <= x21 - x53;
            a_lower[22] <= x22 - x54;  a_lower[23] <= x23 - x55;
            a_lower[24] <= x24 - x56;  a_lower[25] <= x25 - x57;
            a_lower[26] <= x26 - x58;  a_lower[27] <= x27 - x59;
            a_lower[28] <= x28 - x60;  a_lower[29] <= x29 - x61;
            a_lower[30] <= x30 - x62;  a_lower[31] <= x31 - x63;
        end
    end

    L32 l32_upper (
        .clk(clk),
        .rst(rst),
        .x0(a_upper[0]),   .x1(a_upper[1]),   .x2(a_upper[2]),   .x3(a_upper[3]),
        .x4(a_upper[4]),   .x5(a_upper[5]),   .x6(a_upper[6]),   .x7(a_upper[7]),
        .x8(a_upper[8]),   .x9(a_upper[9]),   .x10(a_upper[10]), .x11(a_upper[11]),
        .x12(a_upper[12]), .x13(a_upper[13]), .x14(a_upper[14]), .x15(a_upper[15]),
        .x16(a_upper[16]), .x17(a_upper[17]), .x18(a_upper[18]), .x19(a_upper[19]),
        .x20(a_upper[20]), .x21(a_upper[21]), .x22(a_upper[22]), .x23(a_upper[23]),
        .x24(a_upper[24]), .x25(a_upper[25]), .x26(a_upper[26]), .x27(a_upper[27]),
        .x28(a_upper[28]), .x29(a_upper[29]), .x30(a_upper[30]), .x31(a_upper[31]),

        .y0(y0),   .y1(y1),   .y2(y2),   .y3(y3),   .y4(y4),   .y5(y5),   .y6(y6),   .y7(y7),
        .y8(y8),   .y9(y9),   .y10(y10), .y11(y11), .y12(y12), .y13(y13), .y14(y14), .y15(y15),
        .y16(y16), .y17(y17), .y18(y18), .y19(y19), .y20(y20), .y21(y21), .y22(y22), .y23(y23),
        .y24(y24), .y25(y25), .y26(y26), .y27(y27), .y28(y28), .y29(y29), .y30(y30), .y31(y31)
    );

    L32 l32_lower (
        .clk(clk),
        .rst(rst),
        .x0(a_lower[0]),   .x1(a_lower[1]),   .x2(a_lower[2]),   .x3(a_lower[3]),
        .x4(a_lower[4]),   .x5(a_lower[5]),   .x6(a_lower[6]),   .x7(a_lower[7]),
        .x8(a_lower[8]),   .x9(a_lower[9]),   .x10(a_lower[10]), .x11(a_lower[11]),
        .x12(a_lower[12]), .x13(a_lower[13]), .x14(a_lower[14]), .x15(a_lower[15]),
        .x16(a_lower[16]), .x17(a_lower[17]), .x18(a_lower[18]), .x19(a_lower[19]),
        .x20(a_lower[20]), .x21(a_lower[21]), .x22(a_lower[22]), .x23(a_lower[23]),
        .x24(a_lower[24]), .x25(a_lower[25]), .x26(a_lower[26]), .x27(a_lower[27]),
        .x28(a_lower[28]), .x29(a_lower[29]), .x30(a_lower[30]), .x31(a_lower[31]),

        .y0(y32), .y1(y33), .y2(y34), .y3(y35), .y4(y36), .y5(y37), .y6(y38), .y7(y39),
        .y8(y40), .y9(y41), .y10(y42),.y11(y43), .y12(y44), .y13(y45), .y14(y46), .y15(y47),
        .y16(y48),.y17(y49), .y18(y50),.y19(y51), .y20(y52), .y21(y53), .y22(y54), .y23(y55),
        .y24(y56),.y25(y57), .y26(y58),.y27(y59), .y28(y60), .y29(y61), .y30(y62), .y31(y63)
    );

endmodule