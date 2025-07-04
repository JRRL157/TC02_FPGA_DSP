`timescale 1ns/1ps

module L16_tb();

    // Testbench signals for N=16
    logic [31:0] x0, x1, x2, x3, x4, x5, x6, x7;
    logic [31:0] x8, x9, x10, x11, x12, x13, x14, x15;

    logic [31:0] y0, y1, y2, y3, y4, y5, y6, y7;
    logic [31:0] y8, y9, y10, y11, y12, y13, y14, y15;

    logic [31:0] expected_y0, expected_y1, expected_y2, expected_y3;
    logic [31:0] expected_y4, expected_y5, expected_y6, expected_y7;
    logic [31:0] expected_y8, expected_y9, expected_y10, expected_y11;
    logic [31:0] expected_y12, expected_y13, expected_y14, expected_y15;

    logic clk;
    logic rst; // Reset signal

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

    // Instantiate the L16 module
    L16 fwht_L16 (
        .clk(clk),
        .rst(rst),
        .x0(x0),   .x1(x1),   .x2(x2),   .x3(x3),
        .x4(x4),   .x5(x5),   .x6(x6),   .x7(x7),
        .x8(x8),   .x9(x9),   .x10(x10), .x11(x11),
        .x12(x12), .x13(x13), .x14(x14), .x15(x15),

        .y0(y0),   .y1(y1),   .y2(y2),   .y3(y3),
        .y4(y4),   .y5(y5),   .y6(y6),   .y7(y7),
        .y8(y8),   .y9(y9),   .y10(y10), .y11(y11),
        .y12(y12), .y13(y13), .y14(y14), .y15(y15)
    );
    
    initial begin
        // --- Initialization and Reset ---
        clk = 0;
        rst = 1; // Assert reset

        // Open sample files
        input_file_fd = $fopen("../../../HPS/samples/input_samples_16.txt","r");
        if (input_file_fd == 0) begin
            $error("Error: could not open input_samples_16.txt!");
            $finish;
        end

        output_file_fd = $fopen("../../../HPS/samples/output_samples_16.txt","r");
        if (output_file_fd == 0) begin
            $error("Error: could not open output_samples_16.txt!");
            $fclose(input_file_fd);
            $finish;
        end

        // Apply reset for a few cycles
        #(2 * CLK_PERIOD);
        rst = 0; // De-assert reset
        #(2 * CLK_PERIOD);

        // --- Test Loop ---
        while (!$feof(input_file_fd) && !$feof(output_file_fd)) begin
            // Read 16 inputs
            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n", 
                         x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15) == 16) begin
                // Read 16 expected outputs
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",
                             expected_y0, expected_y1, expected_y2, expected_y3, expected_y4, expected_y5, expected_y6, expected_y7,
                             expected_y8, expected_y9, expected_y10, expected_y11, expected_y12, expected_y13, expected_y14, expected_y15) == 16) begin
                    
                    test_count++;
                    #1000; // Wait for the DUT to compute the result (adjust if needed)

                    $display("\n--- Test Case %0d ---", test_count);
                    $display("Actual outputs:   y0-y7:   %h %h %h %h %h %h %h %h", y0, y1, y2, y3, y4, y5, y6, y7);
                    $display("                    y8-y15:  %h %h %h %h %h %h %h %h", y8, y9, y10, y11, y12, y13, y14, y15);
                    $display("Expected outputs: y0-y7:   %h %h %h %h %h %h %h %h", expected_y0, expected_y1, expected_y2, expected_y3, expected_y4, expected_y5, expected_y6, expected_y7);
                    $display("                    y8-y15:  %h %h %h %h %h %h %h %h", expected_y8, expected_y9, expected_y10, expected_y11, expected_y12, expected_y13, expected_y14, expected_y15);

                    // Check for errors
                    if (y0 !== expected_y0 || y1 !== expected_y1 || y2 !== expected_y2 || y3 !== expected_y3 ||
                        y4 !== expected_y4 || y5 !== expected_y5 || y6 !== expected_y6 || y7 !== expected_y7 ||
                        y8 !== expected_y8 || y9 !== expected_y9 || y10 !== expected_y10 || y11 !== expected_y11 ||
                        y12 !== expected_y12 || y13 !== expected_y13 || y14 !== expected_y14 || y15 !== expected_y15) begin
                        errors++;
                        $display("-> Error in test %0d!", test_count);
                    end else begin
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