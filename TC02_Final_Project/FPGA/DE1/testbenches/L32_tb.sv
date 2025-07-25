`timescale 1ns/1ps

module L32_tb();
    parameter L = 32;
    logic [31:0] x [L-1:0];
    wire [31:0] y [L-1:0];

    logic clk;
    logic rst;
    integer i,j,k;
    reg has_error;

    parameter CLK_PERIOD = 10ns; // 10ns period -> 100 MHz clock
    parameter CLK_HALF_PERIOD = CLK_PERIOD / 2;

    always #CLK_HALF_PERIOD clk = ~clk;

    integer input_file_fd;
    integer output_file_fd;

    int test_count = 0;
    int errors = 0;

    LN #(.N(L)) fwht_L32 (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y)
    );

    parameter LATENCY_IDX = 4;
    logic [31:0] expected_y_buffer [LATENCY_IDX][L-1:0];
    logic [31:0] temp_y [L-1:0];

    initial begin
        clk = 0;
        rst = 1; 
        #CLK_PERIOD;
        rst = 0;
        #CLK_PERIOD;
        test_count = 0;

        input_file_fd = $fopen("../../../HPS/samples/input_samples_32.txt","r");
        if (input_file_fd == 0) begin
            $error("Error: could not open input_samples_32.txt!");
            $finish;
        end

        output_file_fd = $fopen("../../../HPS/samples/output_samples_32.txt","r");
        if (output_file_fd == 0) begin
            $error("Error: could not open output_samples_32.txt!");
            $fclose(input_file_fd);
            $finish;
        end

        // --- Test Loop ---
        while (!$feof(input_file_fd) && !$feof(output_file_fd)) begin

            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n", 
                         x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15],
                         x[16], x[17], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25], x[26], x[27], x[28], x[29], x[30], x[31]) == 32) begin

                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",
                             temp_y[0], temp_y[1], temp_y[2], temp_y[3], temp_y[4], temp_y[5], temp_y[6], temp_y[7],
                             temp_y[8], temp_y[9], temp_y[10], temp_y[11], temp_y[12], temp_y[13], temp_y[14], temp_y[15],
                             temp_y[16], temp_y[17], temp_y[18], temp_y[19], temp_y[20], temp_y[21], temp_y[22], temp_y[23],
                             temp_y[24], temp_y[25], temp_y[26], temp_y[27], temp_y[28], temp_y[29], temp_y[30], temp_y[31]) == 32) begin

                    for (k = LATENCY_IDX-1; k >= 0; k--) begin
                        for (j = 0; j < L; j++) begin
                            expected_y_buffer[k][j] = k == 0 ? temp_y[j] : expected_y_buffer[k-1][j];
                        end
                    end

                    test_count++;
                    #CLK_PERIOD;

                    if (test_count >= LATENCY_IDX) begin
                        has_error = 0;
                        for (i = 0; i < L; i++) begin
                            if (y[i] !== expected_y_buffer[LATENCY_IDX-1][i]) begin
                                has_error = 1;
                                $display("Error at test %0d, index %0d: Expected %h, got %h", test_count-LATENCY_IDX, i, expected_y_buffer[LATENCY_IDX-1][i], y[i]);
                            end
                        end

                        if (has_error) begin
                            errors++;
                            $display("Error in test %0d!", test_count-LATENCY_IDX);
                        end
                        else begin
                            $display("Test %0d passed.", test_count-LATENCY_IDX);
                        end
                    end

                end

            end
        end

        $fclose(input_file_fd);
        $fclose(output_file_fd);

        $display("\n--- All tests completed ---");
        if (errors == 0) begin
            $display("Success: All %0d tests passed!", test_count);
        end
        else begin
            $display("Failure: %0d out of %0d tests failed.", errors, test_count);
        end

        $finish;
    end
endmodule