`timescale 1ns/1ps

module L128_testbench();
    logic [31:0] x [127:0];
    wire [31:0] y [127:0];
    logic [31:0] expected_y [127:0];

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

    LN #(.N(128)) fwht_L128 (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y)
    );

    initial begin
        clk = 0;
        rst = 1;

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

        #(2 * CLK_PERIOD);
        rst = 0;
        #(2 * CLK_PERIOD);

        while (!$feof(input_file_fd) && !$feof(output_file_fd)) begin

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
                    #(6 * CLK_PERIOD);

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