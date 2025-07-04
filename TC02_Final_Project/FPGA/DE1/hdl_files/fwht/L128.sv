module L128(
    input clk,
    input rst,

    input logic [31:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15,
    input logic [31:0] x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31,
    input logic [31:0] x32, x33, x34, x35, x36, x37, x38, x39, x40, x41, x42, x43, x44, x45, x46, x47,
    input logic [31:0] x48, x49, x50, x51, x52, x53, x54, x55, x56, x57, x58, x59, x60, x61, x62, x63,
    input logic [31:0] x64, x65, x66, x67, x68, x69, x70, x71, x72, x73, x74, x75, x76, x77, x78, x79,
    input logic [31:0] x80, x81, x82, x83, x84, x85, x86, x87, x88, x89, x90, x91, x92, x93, x94, x95,
    input logic [31:0] x96, x97, x98, x99, x100, x101, x102, x103, x104, x105, x106, x107, x108, x109, x110, x111,
    input logic [31:0] x112, x113, x114, x115, x116, x117, x118, x119, x120, x121, x122, x123, x124, x125, x126, x127,

    output logic [31:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15,
    output logic [31:0] y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, y31,
    output logic [31:0] y32, y33, y34, y35, y36, y37, y38, y39, y40, y41, y42, y43, y44, y45, y46, y47,
    output logic [31:0] y48, y49, y50, y51, y52, y53, y54, y55, y56, y57, y58, y59, y60, y61, y62, y63,
    output logic [31:0] y64, y65, y66, y67, y68, y69, y70, y71, y72, y73, y74, y75, y76, y77, y78, y79,
    output logic [31:0] y80, y81, y82, y83, y84, y85, y86, y87, y88, y89, y90, y91, y92, y93, y94, y95,
    output logic [31:0] y96, y97, y98, y99, y100, y101, y102, y103, y104, y105, y106, y107, y108, y109, y110, y111,
    output logic [31:0] y112, y113, y114, y115, y116, y117, y118, y119, y120, y121, y122, y123, y124, y125, y126, y127
);
    reg [31:0] a_upper[64];
    reg [31:0] a_lower[64];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 64; i = i + 1) begin
                a_upper[i] <= 32'h0;
                a_lower[i] <= 32'h0;
            end
        end
        else begin
            a_upper[0] <= x0 + x64;     a_lower[0] <= x0 - x64;
            a_upper[1] <= x1 + x65;     a_lower[1] <= x1 - x65;
            a_upper[2] <= x2 + x66;     a_lower[2] <= x2 - x66;
            a_upper[3] <= x3 + x67;     a_lower[3] <= x3 - x67;
            a_upper[4] <= x4 + x68;     a_lower[4] <= x4 - x68;
            a_upper[5] <= x5 + x69;     a_lower[5] <= x5 - x69;
            a_upper[6] <= x6 + x70;     a_lower[6] <= x6 - x70;
            a_upper[7] <= x7 + x71;     a_lower[7] <= x7 - x71;
            a_upper[8] <= x8 + x72;     a_lower[8] <= x8 - x72;
            a_upper[9] <= x9 + x73;     a_lower[9] <= x9 - x73;
            a_upper[10] <= x10 + x74;   a_lower[10] <= x10 - x74;
            a_upper[11] <= x11 + x75;   a_lower[11] <= x11 - x75;
            a_upper[12] <= x12 + x76;   a_lower[12] <= x12 - x76;
            a_upper[13] <= x13 + x77;   a_lower[13] <= x13 - x77;
            a_upper[14] <= x14 + x78;   a_lower[14] <= x14 - x78;
            a_upper[15] <= x15 + x79;   a_lower[15] <= x15 - x79;
            a_upper[16] <= x16 + x80;   a_lower[16] <= x16 - x80;
            a_upper[17] <= x17 + x81;   a_lower[17] <= x17 - x81;
            a_upper[18] <= x18 + x82;   a_lower[18] <= x18 - x82;
            a_upper[19] <= x19 + x83;   a_lower[19] <= x19 - x83;
            a_upper[20] <= x20 + x84;   a_lower[20] <= x20 - x84;
            a_upper[21] <= x21 + x85;   a_lower[21] <= x21 - x85;
            a_upper[22] <= x22 + x86;   a_lower[22] <= x22 - x86;
            a_upper[23] <= x23 + x87;   a_lower[23] <= x23 - x87;
            a_upper[24] <= x24 + x88;   a_lower[24] <= x24 - x88;
            a_upper[25] <= x25 + x89;   a_lower[25] <= x25 - x89;
            a_upper[26] <= x26 + x90;   a_lower[26] <= x26 - x90;
            a_upper[27] <= x27 + x91;   a_lower[27] <= x27 - x91;
            a_upper[28] <= x28 + x92;   a_lower[28] <= x28 - x92;
            a_upper[29] <= x29 + x93;   a_lower[29] <= x29 - x93;
            a_upper[30] <= x30 + x94;   a_lower[30] <= x30 - x94;
            a_upper[31] <= x31 + x95;   a_lower[31] <= x31 - x95;
            a_upper[32] <= x32 + x96;   a_lower[32] <= x32 - x96;
            a_upper[33] <= x33 + x97;   a_lower[33] <= x33 - x97;
            a_upper[34] <= x34 + x98;   a_lower[34] <= x34 - x98;
            a_upper[35] <= x35 + x99;   a_lower[35] <= x35 - x99;
            a_upper[36] <= x36 + x100;  a_lower[36] <= x36 - x100;
            a_upper[37] <= x37 + x101;  a_lower[37] <= x37 - x101;
            a_upper[38] <= x38 + x102;  a_lower[38] <= x38 - x102;
            a_upper[39] <= x39 + x103;  a_lower[39] <= x39 - x103;
            a_upper[40] <= x40 + x104;  a_lower[40] <= x40 - x104;
            a_upper[41] <= x41 + x105;  a_lower[41] <= x41 - x105;
            a_upper[42] <= x42 + x106;  a_lower[42] <= x42 - x106;
            a_upper[43] <= x43 + x107;  a_lower[43] <= x43 - x107;
            a_upper[44] <= x44 + x108;  a_lower[44] <= x44 - x108;
            a_upper[45] <= x45 + x109;  a_lower[45] <= x45 - x109;
            a_upper[46] <= x46 + x110;  a_lower[46] <= x46 - x110;
            a_upper[47] <= x47 + x111;  a_lower[47] <= x47 - x111;
            a_upper[48] <= x48 + x112;  a_lower[48] <= x48 - x112;
            a_upper[49] <= x49 + x113;  a_lower[49] <= x49 - x113;
            a_upper[50] <= x50 + x114;  a_lower[50] <= x50 - x114;
            a_upper[51] <= x51 + x115;  a_lower[51] <= x51 - x115;
            a_upper[52] <= x52 + x116;  a_lower[52] <= x52 - x116;
            a_upper[53] <= x53 + x117;  a_lower[53] <= x53 - x117;
            a_upper[54] <= x54 + x118;  a_lower[54] <= x54 - x118;
            a_upper[55] <= x55 + x119;  a_lower[55] <= x55 - x119;
            a_upper[56] <= x56 + x120;  a_lower[56] <= x56 - x120;
            a_upper[57] <= x57 + x121;  a_lower[57] <= x57 - x121;
            a_upper[58] <= x58 + x122;  a_lower[58] <= x58 - x122;
            a_upper[59] <= x59 + x123;  a_lower[59] <= x59 - x123;
            a_upper[60] <= x60 + x124;  a_lower[60] <= x60 - x124;
            a_upper[61] <= x61 + x125;  a_lower[61] <= x61 - x125;
            a_upper[62] <= x62 + x126;  a_lower[62] <= x62 - x126;
            a_upper[63] <= x63 + x127;  a_lower[63] <= x63 - x127;
        end
    end

    L64 l64_upper (
        .clk(clk), .rst(rst),
        .x0(a_upper[0]), .x1(a_upper[1]), .x2(a_upper[2]), .x3(a_upper[3]), .x4(a_upper[4]), .x5(a_upper[5]), .x6(a_upper[6]), .x7(a_upper[7]), .x8(a_upper[8]), .x9(a_upper[9]), .x10(a_upper[10]), .x11(a_upper[11]), .x12(a_upper[12]), .x13(a_upper[13]), .x14(a_upper[14]), .x15(a_upper[15]), .x16(a_upper[16]), .x17(a_upper[17]), .x18(a_upper[18]), .x19(a_upper[19]), .x20(a_upper[20]), .x21(a_upper[21]), .x22(a_upper[22]), .x23(a_upper[23]), .x24(a_upper[24]), .x25(a_upper[25]), .x26(a_upper[26]), .x27(a_upper[27]), .x28(a_upper[28]), .x29(a_upper[29]), .x30(a_upper[30]), .x31(a_upper[31]), .x32(a_upper[32]), .x33(a_upper[33]), .x34(a_upper[34]), .x35(a_upper[35]), .x36(a_upper[36]), .x37(a_upper[37]), .x38(a_upper[38]), .x39(a_upper[39]), .x40(a_upper[40]), .x41(a_upper[41]), .x42(a_upper[42]), .x43(a_upper[43]), .x44(a_upper[44]), .x45(a_upper[45]), .x46(a_upper[46]), .x47(a_upper[47]), .x48(a_upper[48]), .x49(a_upper[49]), .x50(a_upper[50]), .x51(a_upper[51]), .x52(a_upper[52]), .x53(a_upper[53]), .x54(a_upper[54]), .x55(a_upper[55]), .x56(a_upper[56]), .x57(a_upper[57]), .x58(a_upper[58]), .x59(a_upper[59]), .x60(a_upper[60]), .x61(a_upper[61]), .x62(a_upper[62]), .x63(a_upper[63]),
        .y0(y0), .y1(y1), .y2(y2), .y3(y3), .y4(y4), .y5(y5), .y6(y6), .y7(y7), .y8(y8), .y9(y9), .y10(y10), .y11(y11), .y12(y12), .y13(y13), .y14(y14), .y15(y15), .y16(y16), .y17(y17), .y18(y18), .y19(y19), .y20(y20), .y21(y21), .y22(y22), .y23(y23), .y24(y24), .y25(y25), .y26(y26), .y27(y27), .y28(y28), .y29(y29), .y30(y30), .y31(y31), .y32(y32), .y33(y33), .y34(y34), .y35(y35), .y36(y36), .y37(y37), .y38(y38), .y39(y39), .y40(y40), .y41(y41), .y42(y42), .y43(y43), .y44(y44), .y45(y45), .y46(y46), .y47(y47), .y48(y48), .y49(y49), .y50(y50), .y51(y51), .y52(y52), .y53(y53), .y54(y54), .y55(y55), .y56(y56), .y57(y57), .y58(y58), .y59(y59), .y60(y60), .y61(y61), .y62(y62), .y63(y63)
    );

    L64 l64_lower (
        .clk(clk), .rst(rst),
        .x0(a_lower[0]), .x1(a_lower[1]), .x2(a_lower[2]), .x3(a_lower[3]), .x4(a_lower[4]), .x5(a_lower[5]), .x6(a_lower[6]), .x7(a_lower[7]), .x8(a_lower[8]), .x9(a_lower[9]), .x10(a_lower[10]), .x11(a_lower[11]), .x12(a_lower[12]), .x13(a_lower[13]), .x14(a_lower[14]), .x15(a_lower[15]), .x16(a_lower[16]), .x17(a_lower[17]), .x18(a_lower[18]), .x19(a_lower[19]), .x20(a_lower[20]), .x21(a_lower[21]), .x22(a_lower[22]), .x23(a_lower[23]), .x24(a_lower[24]), .x25(a_lower[25]), .x26(a_lower[26]), .x27(a_lower[27]), .x28(a_lower[28]), .x29(a_lower[29]), .x30(a_lower[30]), .x31(a_lower[31]), .x32(a_lower[32]), .x33(a_lower[33]), .x34(a_lower[34]), .x35(a_lower[35]), .x36(a_lower[36]), .x37(a_lower[37]), .x38(a_lower[38]), .x39(a_lower[39]), .x40(a_lower[40]), .x41(a_lower[41]), .x42(a_lower[42]), .x43(a_lower[43]), .x44(a_lower[44]), .x45(a_lower[45]), .x46(a_lower[46]), .x47(a_lower[47]), .x48(a_lower[48]), .x49(a_lower[49]), .x50(a_lower[50]), .x51(a_lower[51]), .x52(a_lower[52]), .x53(a_lower[53]), .x54(a_lower[54]), .x55(a_lower[55]), .x56(a_lower[56]), .x57(a_lower[57]), .x58(a_lower[58]), .x59(a_lower[59]), .x60(a_lower[60]), .x61(a_lower[61]), .x62(a_lower[62]), .x63(a_lower[63]),
        .y0(y64), .y1(y65), .y2(y66), .y3(y67), .y4(y68), .y5(y69), .y6(y70), .y7(y71), .y8(y72), .y9(y73), .y10(y74), .y11(y75), .y12(y76), .y13(y77), .y14(y78), .y15(y79), .y16(y80), .y17(y81), .y18(y82), .y19(y83), .y20(y84), .y21(y85), .y22(y86), .y23(y87), .y24(y88), .y25(y89), .y26(y90), .y27(y91), .y28(y92), .y29(y93), .y30(y94), .y31(y95), .y32(y96), .y33(y97), .y34(y98), .y35(y99), .y36(y100), .y37(y101), .y38(y102), .y39(y103), .y40(y104), .y41(y105), .y42(y106), .y43(y107), .y44(y108), .y45(y109), .y46(y110), .y47(y111), .y48(y112), .y49(y113), .y50(y114), .y51(y115), .y52(y116), .y53(y117), .y54(y118), .y55(y119), .y56(y120), .y57(y121), .y58(y122), .y59(y123), .y60(y124), .y61(y125), .y62(y126), .y63(y127)
    );

endmodule