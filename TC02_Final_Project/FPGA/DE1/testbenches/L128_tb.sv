`timescale 1ns/1ps

module L128_testbench();

    logic [31:0] x[128];
    logic [31:0] y[128];
    logic [31:0] expected_y[128];

    logic clk;
    logic rst; 
    integer i;
    reg has_error;

    parameter CLK_PERIOD = 10ns;
    parameter CLK_HALF_PERIOD = CLK_PERIOD / 2;

    always #CLK_HALF_PERIOD clk = ~clk;

    integer input_file_fd;
    integer output_file_fd;

    int test_count = 0;
    int errors = 0;

    // Instancia o módulo L128
    L128 fwht_L128 (
        .clk(clk),
        .rst(rst),
        // Conecta todas as 128 entradas
        .x0(x[0]),   .x1(x[1]),   .x2(x[2]),   .x3(x[3]),   .x4(x[4]),   .x5(x[5]),   .x6(x[6]),   .x7(x[7]),
        .x8(x[8]),   .x9(x[9]),   .x10(x[10]), .x11(x[11]), .x12(x[12]), .x13(x[13]), .x14(x[14]), .x15(x[15]),
        .x16(x[16]), .x17(x[17]), .x18(x[18]), .x19(x[19]), .x20(x[20]), .x21(x[21]), .x22(x[22]), .x23(x[23]),
        .x24(x[24]), .x25(x[25]), .x26(x[26]), .x27(x[27]), .x28(x[28]), .x29(x[29]), .x30(x[30]), .x31(x[31]),
        .x32(x[32]), .x33(x[33]), .x34(x[34]), .x35(x[35]), .x36(x[36]), .x37(x[37]), .x38(x[38]), .x39(x[39]),
        .x40(x[40]), .x41(x[41]), .x42(x[42]), .x43(x[43]), .x44(x[44]), .x45(x[45]), .x46(x[46]), .x47(x[47]),
        .x48(x[48]), .x49(x[49]), .x50(x[50]), .x51(x[51]), .x52(x[52]), .x53(x[53]), .x54(x[54]), .x55(x[55]),
        .x56(x[56]), .x57(x[57]), .x58(x[58]), .x59(x[59]), .x60(x[60]), .x61(x[61]), .x62(x[62]), .x63(x[63]),
        .x64(x[64]), .x65(x[65]), .x66(x[66]), .x67(x[67]), .x68(x[68]), .x69(x[69]), .x70(x[70]), .x71(x[71]),
        .x72(x[72]), .x73(x[73]), .x74(x[74]), .x75(x[75]), .x76(x[76]), .x77(x[77]), .x78(x[78]), .x79(x[79]),
        .x80(x[80]), .x81(x[81]), .x82(x[82]), .x83(x[83]), .x84(x[84]), .x85(x[85]), .x86(x[86]), .x87(x[87]),
        .x88(x[88]), .x89(x[89]), .x90(x[90]), .x91(x[91]), .x92(x[92]), .x93(x[93]), .x94(x[94]), .x95(x[95]),
        .x96(x[96]), .x97(x[97]), .x98(x[98]), .x99(x[99]), .x100(x[100]),.x101(x[101]),.x102(x[102]),.x103(x[103]),
        .x104(x[104]),.x105(x[105]),.x106(x[106]),.x107(x[107]),.x108(x[108]),.x109(x[109]),.x110(x[110]),.x111(x[111]),
        .x112(x[112]),.x113(x[113]),.x114(x[114]),.x115(x[115]),.x116(x[116]),.x117(x[117]),.x118(x[118]),.x119(x[119]),
        .x120(x[120]),.x121(x[121]),.x122(x[122]),.x123(x[123]),.x124(x[124]),.x125(x[125]),.x126(x[126]),.x127(x[127]),

        // Conecta todas as 128 saídas
        .y0(y[0]),   .y1(y[1]),   .y2(y[2]),   .y3(y[3]),   .y4(y[4]),   .y5(y[5]),   .y6(y[6]),   .y7(y[7]),
        .y8(y[8]),   .y9(y[9]),   .y10(y[10]), .y11(y[11]), .y12(y[12]), .y13(y[13]), .y14(y[14]), .y15(y[15]),
        .y16(y[16]), .y17(y[17]), .y18(y[18]), .y19(y[19]), .y20(y[20]), .y21(y[21]), .y22(y[22]), .y23(y[23]),
        .y24(y[24]), .y25(y[25]), .y26(y[26]), .y27(y[27]), .y28(y[28]), .y29(y[29]), .y30(y[30]), .y31(y[31]),
        .y32(y[32]), .y33(y[33]), .y34(y[34]), .y35(y[35]), .y36(y[36]), .y37(y[37]), .y38(y[38]), .y39(y[39]),
        .y40(y[40]), .y41(y[41]), .y42(y[42]), .y43(y[43]), .y44(y[44]), .y45(y[45]), .y46(y[46]), .y47(y[47]),
        .y48(y[48]), .y49(y[49]), .y50(y[50]), .y51(y[51]), .y52(y[52]), .y53(y[53]), .y54(y[54]), .y55(y[55]),
        .y56(y[56]), .y57(y[57]), .y58(y[58]), .y59(y[59]), .y60(y[60]), .y61(y[61]), .y62(y[62]), .y63(y[63]),
        .y64(y[64]), .y65(y[65]), .y66(y[66]), .y67(y[67]), .y68(y[68]), .y69(y[69]), .y70(y[70]), .y71(y[71]),
        .y72(y[72]), .y73(y[73]), .y74(y[74]), .y75(y[75]), .y76(y[76]), .y77(y[77]), .y78(y[78]), .y79(y[79]),
        .y80(y[80]), .y81(y[81]), .y82(y[82]), .y83(y[83]), .y84(y[84]), .y85(y[85]), .y86(y[86]), .y87(y[87]),
        .y88(y[88]), .y89(y[89]), .y90(y[90]), .y91(y[91]), .y92(y[92]), .y93(y[93]), .y94(y[94]), .y95(y[95]),
        .y96(y[96]), .y97(y[97]), .y98(y[98]), .y99(y[99]), .y100(y[100]),.y101(y[101]),.y102(y[102]),.y103(y[103]),
        .y104(y[104]),.y105(y[105]),.y106(y[106]),.y107(y[107]),.y108(y[108]),.y109(y[109]),.y110(y[110]),.y111(y[111]),
        .y112(y[112]),.y113(y[113]),.y114(y[114]),.y115(y[115]),.y116(y[116]),.y117(y[117]),.y118(y[118]),.y119(y[119]),
        .y120(y[120]),.y121(y[121]),.y122(y[122]),.y123(y[123]),.y124(y[124]),.y125(y[125]),.y126(y[126]),.y127(y[127])
    );
    
    initial begin
        clk = 0;
        rst = 1;

        // Abre os arquivos de amostra
        input_file_fd = $fopen("../../../HPS/samples/input_samples_128.txt","r");
        if (input_file_fd == 0) begin
            $error("Erro: nao foi possivel abrir o arquivo input_samples_128.txt!");
            $finish;
        end

        output_file_fd = $fopen("../../../HPS/samples/output_samples_128.txt","r");
        if (output_file_fd == 0) begin
            $error("Erro: nao foi possivel abrir o arquivo output_samples_128.txt!");
            $fclose(input_file_fd);
            $finish;
        end

        // Aplica o reset por alguns ciclos
        #(2 * CLK_PERIOD);
        rst = 0; // Desativa o reset
        #(2 * CLK_PERIOD);

        // --- Loop de Teste ---
        while (!$feof(input_file_fd) && !$feof(output_file_fd)) begin
            // Lê 128 entradas e 128 saídas esperadas
            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n", 
                         x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15],
                         x[16], x[17], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25], x[26], x[27], x[28], x[29], x[30], x[31],
                         x[32], x[33], x[34], x[35], x[36], x[37], x[38], x[39], x[40], x[41], x[42], x[43], x[44], x[45], x[46], x[47],
                         x[48], x[49], x[50], x[51], x[52], x[53], x[54], x[55], x[56], x[57], x[58], x[59], x[60], x[61], x[62], x[63],
                         x[64], x[65], x[66], x[67], x[68], x[69], x[70], x[71], x[72], x[73], x[74], x[75], x[76], x[77], x[78], x[79],
                         x[80], x[81], x[82], x[83], x[84], x[85], x[86], x[87], x[88], x[89], x[90], x[91], x[92], x[93], x[94], x[95],
                         x[96], x[97], x[98], x[99], x[100], x[101], x[102], x[103], x[104], x[105], x[106], x[107], x[108], x[109], x[110], x[111],
                         x[112], x[113], x[114], x[115], x[116], x[117], x[118], x[119], x[120], x[121], x[122], x[123], x[124], x[125], x[126], x[127]) == 128) begin
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",
                             expected_y[0], expected_y[1], expected_y[2], expected_y[3], expected_y[4], expected_y[5], expected_y[6], expected_y[7],
                             expected_y[8], expected_y[9], expected_y[10], expected_y[11], expected_y[12], expected_y[13], expected_y[14], expected_y[15],
                             expected_y[16], expected_y[17], expected_y[18], expected_y[19], expected_y[20], expected_y[21], expected_y[22], expected_y[23],
                             expected_y[24], expected_y[25], expected_y[26], expected_y[27], expected_y[28], expected_y[29], expected_y[30], expected_y[31],
                             expected_y[32], expected_y[33], expected_y[34], expected_y[35], expected_y[36], expected_y[37], expected_y[38], expected_y[39],
                             expected_y[40], expected_y[41], expected_y[42], expected_y[43], expected_y[44], expected_y[45], expected_y[46], expected_y[47],
                             expected_y[48], expected_y[49], expected_y[50], expected_y[51], expected_y[52], expected_y[53], expected_y[54], expected_y[55],
                             expected_y[56], expected_y[57], expected_y[58], expected_y[59], expected_y[60], expected_y[61], expected_y[62], expected_y[63],
                             expected_y[64], expected_y[65], expected_y[66], expected_y[67], expected_y[68], expected_y[69], expected_y[70], expected_y[71],
                             expected_y[72], expected_y[73], expected_y[74], expected_y[75], expected_y[76], expected_y[77], expected_y[78], expected_y[79],
                             expected_y[80], expected_y[81], expected_y[82], expected_y[83], expected_y[84], expected_y[85], expected_y[86], expected_y[87],
                             expected_y[88], expected_y[89], expected_y[90], expected_y[91], expected_y[92], expected_y[93], expected_y[94], expected_y[95],
                             expected_y[96], expected_y[97], expected_y[98], expected_y[99], expected_y[100], expected_y[101], expected_y[102], expected_y[103],
                             expected_y[104], expected_y[105], expected_y[106], expected_y[107], expected_y[108], expected_y[109], expected_y[110], expected_y[111],
                             expected_y[112], expected_y[113], expected_y[114], expected_y[115], expected_y[116], expected_y[117], expected_y[118], expected_y[119],
                             expected_y[120], expected_y[121], expected_y[122], expected_y[123], expected_y[124], expected_y[125], expected_y[126], expected_y[127]) == 128) begin
                    
                    test_count++;
                    #200;

                    $display("\n--- Test Case %0d ---", test_count);

                    has_error = 0;
                    for (i = 0; i < 128; i = i + 1) begin
                        if (y[i] !== expected_y[i]) begin
                            has_error = 1;
                            $display("Mismatch at index %0d: Actual = %h, Expected = %h", i, y[i], expected_y[i]);
                        end
                    end

                    if (has_error) begin
                        errors++;
                        $display("-> Error in test %0d!", test_count);
                    end 
                    else begin
                        $display("-> Test %0d passed.", test_count);
                    end
                end
            end
        end

        $fclose(input_file_fd);
        $fclose(output_file_fd);

        $display("\n--- All tests completed ---");
        if (errors == 0) begin
            $display("Success: All %0d tests passed!", test_count);
        end else begin
            $display("Failure: %0d out of %0d tests failed.", errors, test_count);
        end

        $finish;
    end
endmodule