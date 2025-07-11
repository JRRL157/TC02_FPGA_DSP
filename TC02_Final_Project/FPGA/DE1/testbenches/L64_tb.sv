`timescale 1ns/1ps

module L64_testbench();

    logic [31:0] x [63:0];
    wire [31:0] y [63:0];
    logic [31:0] expected_y[63:0];

    logic clk;
    logic rst; // Reset signal
    integer i;
    reg has_error;

    parameter CLK_PERIOD = 10ns; // 10ns period -> 100 MHz clock
    parameter CLK_HALF_PERIOD = CLK_PERIOD / 2;

    // Clock generator
    always #CLK_HALF_PERIOD clk = ~clk;

    // File descriptors
    integer input_file_fd;
    integer output_file_fd;

    // Test counters
    int test_count = 0;
    int errors = 0;

    // Instantiate the L64 module
    L64 fwht_L64 (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y)
    );
    
    initial begin
        clk = 0;
        rst = 1;

        // Open sample files
        input_file_fd = $fopen("../../../HPS/samples/input_samples_64.txt","r");
        if (input_file_fd == 0) begin
            $error("Error: could not open input_samples_64.txt!");
            $finish;
        end

        output_file_fd = $fopen("../../../HPS/samples/output_samples_64.txt","r");
        if (output_file_fd == 0) begin
            $error("Error: could not open output_samples_64.txt!");
            $fclose(input_file_fd);
            $finish;
        end

        // Apply reset for a few cycles
        #(2 * CLK_PERIOD);
        rst = 0; // De-assert reset
        #(2 * CLK_PERIOD);

        // --- Test Loop ---
        while (!$feof(input_file_fd) && !$feof(output_file_fd)) begin
            // Read 64 inputs
            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n", 
                         x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15],
                         x[16], x[17], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25], x[26], x[27], x[28], x[29], x[30], x[31],
                         x[32], x[33], x[34], x[35], x[36], x[37], x[38], x[39], x[40], x[41], x[42], x[43], x[44], x[45], x[46], x[47],
                         x[48], x[49], x[50], x[51], x[52], x[53], x[54], x[55], x[56], x[57], x[58], x[59], x[60], x[61], x[62], x[63]) == 64) begin
                // Read 64 expected outputs
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",
                             expected_y[0], expected_y[1], expected_y[2], expected_y[3], expected_y[4], expected_y[5], expected_y[6], expected_y[7],
                             expected_y[8], expected_y[9], expected_y[10], expected_y[11], expected_y[12], expected_y[13], expected_y[14], expected_y[15],
                             expected_y[16], expected_y[17], expected_y[18], expected_y[19], expected_y[20], expected_y[21], expected_y[22], expected_y[23],
                             expected_y[24], expected_y[25], expected_y[26], expected_y[27], expected_y[28], expected_y[29], expected_y[30], expected_y[31],
                             expected_y[32], expected_y[33], expected_y[34], expected_y[35], expected_y[36], expected_y[37], expected_y[38], expected_y[39],
                             expected_y[40], expected_y[41], expected_y[42], expected_y[43], expected_y[44], expected_y[45], expected_y[46], expected_y[47],
                             expected_y[48], expected_y[49], expected_y[50], expected_y[51], expected_y[52], expected_y[53], expected_y[54], expected_y[55],
                             expected_y[56], expected_y[57], expected_y[58], expected_y[59], expected_y[60], expected_y[61], expected_y[62], expected_y[63]) == 64) begin
                    
                    test_count++;
                    #100;

                    $display("\n--- Test Case %0d ---", test_count);

                    has_error = 0;
                    for (i = 0; i < 64; i = i + 1) begin
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

        // --- Simulation Summary ---
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