`timescale 1ns/1ps

module L32_tb();

    // Testbench signals for N=32
    logic [31:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15;
    logic [31:0] x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31;

    logic [31:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15;
    logic [31:0] y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, y31;

    logic [31:0] expected_y0, expected_y1, expected_y2, expected_y3, expected_y4, expected_y5, expected_y6, expected_y7;
    logic [31:0] expected_y8, expected_y9, expected_y10, expected_y11, expected_y12, expected_y13, expected_y14, expected_y15;
    logic [31:0] expected_y16, expected_y17, expected_y18, expected_y19, expected_y20, expected_y21, expected_y22, expected_y23;
    logic [31:0] expected_y24, expected_y25, expected_y26, expected_y27, expected_y28, expected_y29, expected_y30, expected_y31;

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

    // Instantiate the L32 module
    L32 fwht_L32 (
        .clk(clk),
        .rst(rst),
        .x0(x0),   .x1(x1),   .x2(x2),   .x3(x3),   .x4(x4),   .x5(x5),   .x6(x6),   .x7(x7),
        .x8(x8),   .x9(x9),   .x10(x10), .x11(x11), .x12(x12), .x13(x13), .x14(x14), .x15(x15),
        .x16(x16), .x17(x17), .x18(x18), .x19(x19), .x20(x20), .x21(x21), .x22(x22), .x23(x23),
        .x24(x24), .x25(x25), .x26(x26), .x27(x27), .x28(x28), .x29(x29), .x30(x30), .x31(x31),

        .y0(y0),   .y1(y1),   .y2(y2),   .y3(y3),   .y4(y4),   .y5(y5),   .y6(y6),   .y7(y7),
        .y8(y8),   .y9(y9),   .y10(y10), .y11(y11), .y12(y12), .y13(y13), .y14(y14), .y15(y15),
        .y16(y16), .y17(y17), .y18(y18), .y19(y19), .y20(y20), .y21(y21), .y22(y22), .y23(y23),
        .y24(y24), .y25(y25), .y26(y26), .y27(y27), .y28(y28), .y29(y29), .y30(y30), .y31(y31)
    );
    
    initial begin
        // --- Initialization and Reset ---
        clk = 0;
        rst = 1; // Assert reset

        // Open sample files
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

        // Apply reset for a few cycles
        #(2 * CLK_PERIOD);
        rst = 0; // De-assert reset
        #(2 * CLK_PERIOD);

        // --- Test Loop ---
        while (!$feof(input_file_fd) && !$feof(output_file_fd)) begin
            // Read 32 inputs
            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n", 
                         x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15,
                         x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31) == 32) begin
                // Read 32 expected outputs
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",
                             expected_y0, expected_y1, expected_y2, expected_y3, expected_y4, expected_y5, expected_y6, expected_y7,
                             expected_y8, expected_y9, expected_y10, expected_y11, expected_y12, expected_y13, expected_y14, expected_y15,
                             expected_y16, expected_y17, expected_y18, expected_y19, expected_y20, expected_y21, expected_y22, expected_y23,
                             expected_y24, expected_y25, expected_y26, expected_y27, expected_y28, expected_y29, expected_y30, expected_y31) == 32) begin
                    
                    test_count++;
                    #100; // Wait for the DUT to compute the result (adjust if latency is higher for L32)

                    $display("\n--- Test Case %0d ---", test_count);
                    // Display results in groups for readability
                    $display("Actual outputs:   y0-y7:   %h %h %h %h %h %h %h %h", y0, y1, y2, y3, y4, y5, y6, y7);
                    $display("                    y8-y15:  %h %h %h %h %h %h %h %h", y8, y9, y10, y11, y12, y13, y14, y15);
                    $display("                    y16-y23: %h %h %h %h %h %h %h %h", y16, y17, y18, y19, y20, y21, y22, y23);
                    $display("                    y24-y31: %h %h %h %h %h %h %h %h", y24, y25, y26, y27, y28, y29, y30, y31);
                    $display("Expected outputs: y0-y7:   %h %h %h %h %h %h %h %h", expected_y0, expected_y1, expected_y2, expected_y3, expected_y4, expected_y5, expected_y6, expected_y7);
                    $display("                    y8-y15:  %h %h %h %h %h %h %h %h", expected_y8, expected_y9, expected_y10, expected_y11, expected_y12, expected_y13, expected_y14, expected_y15);
                    $display("                    y16-y23: %h %h %h %h %h %h %h %h", expected_y16, expected_y17, expected_y18, expected_y19, expected_y20, expected_y21, expected_y22, expected_y23);
                    $display("                    y24-y31: %h %h %h %h %h %h %h %h", expected_y24, expected_y25, expected_y26, expected_y27, expected_y28, expected_y29, expected_y30, expected_y31);

                    // Check for errors
                    if (y0 !== expected_y0 || y1 !== expected_y1 || y2 !== expected_y2 || y3 !== expected_y3 ||
                        y4 !== expected_y4 || y5 !== expected_y5 || y6 !== expected_y6 || y7 !== expected_y7 ||
                        y8 !== expected_y8 || y9 !== expected_y9 || y10 !== expected_y10 || y11 !== expected_y11 ||
                        y12 !== expected_y12 || y13 !== expected_y13 || y14 !== expected_y14 || y15 !== expected_y15 ||
                        y16 !== expected_y16 || y17 !== expected_y17 || y18 !== expected_y18 || y19 !== expected_y19 ||
                        y20 !== expected_y20 || y21 !== expected_y21 || y22 !== expected_y22 || y23 !== expected_y23 ||
                        y24 !== expected_y24 || y25 !== expected_y25 || y26 !== expected_y26 || y27 !== expected_y27 ||
                        y28 !== expected_y28 || y29 !== expected_y29 || y30 !== expected_y30 || y31 !== expected_y31) begin
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