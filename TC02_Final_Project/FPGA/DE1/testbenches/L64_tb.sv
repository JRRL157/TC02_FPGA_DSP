`timescale 1ns/1ps

module L64_testbench();

    logic [31:0] x[64];
    logic [31:0] y[64];
    logic [31:0] expected_y[64];

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
        // Connect all 64 inputs
        .x0(x[0]),   .x1(x[1]),   .x2(x[2]),   .x3(x[3]),   .x4(x[4]),   .x5(x[5]),   .x6(x[6]),   .x7(x[7]),
        .x8(x[8]),   .x9(x[9]),   .x10(x[10]), .x11(x[11]), .x12(x[12]), .x13(x[13]), .x14(x[14]), .x15(x[15]),
        .x16(x[16]), .x17(x[17]), .x18(x[18]), .x19(x[19]), .x20(x[20]), .x21(x[21]), .x22(x[22]), .x23(x[23]),
        .x24(x[24]), .x25(x[25]), .x26(x[26]), .x27(x[27]), .x28(x[28]), .x29(x[29]), .x30(x[30]), .x31(x[31]),
        .x32(x[32]), .x33(x[33]), .x34(x[34]), .x35(x[35]), .x36(x[36]), .x37(x[37]), .x38(x[38]), .x39(x[39]),
        .x40(x[40]), .x41(x[41]), .x42(x[42]), .x43(x[43]), .x44(x[44]), .x45(x[45]), .x46(x[46]), .x47(x[47]),
        .x48(x[48]), .x49(x[49]), .x50(x[50]), .x51(x[51]), .x52(x[52]), .x53(x[53]), .x54(x[54]), .x55(x[55]),
        .x56(x[56]), .x57(x[57]), .x58(x[58]), .x59(x[59]), .x60(x[60]), .x61(x[61]), .x62(x[62]), .x63(x[63]),

        // Connect all 64 outputs
        .y0(y[0]),   .y1(y[1]),   .y2(y[2]),   .y3(y[3]),   .y4(y[4]),   .y5(y[5]),   .y6(y[6]),   .y7(y[7]),
        .y8(y[8]),   .y9(y[9]),   .y10(y[10]), .y11(y[11]), .y12(y[12]), .y13(y[13]), .y14(y[14]), .y15(y[15]),
        .y16(y[16]), .y17(y[17]), .y18(y[18]), .y19(y[19]), .y20(y[20]), .y21(y[21]), .y22(y[22]), .y23(y[23]),
        .y24(y[24]), .y25(y[25]), .y26(y[26]), .y27(y[27]), .y28(y[28]), .y29(y[29]), .y30(y[30]), .y31(y[31]),
        .y32(y[32]), .y33(y[33]), .y34(y[34]), .y35(y[35]), .y36(y[36]), .y37(y[37]), .y38(y[38]), .y39(y[39]),
        .y40(y[40]), .y41(y[41]), .y42(y[42]), .y43(y[43]), .y44(y[44]), .y45(y[45]), .y46(y[46]), .y47(y[47]),
        .y48(y[48]), .y49(y[49]), .y50(y[50]), .y51(y[51]), .y52(y[52]), .y53(y[53]), .y54(y[54]), .y55(y[55]),
        .y56(y[56]), .y57(y[57]), .y58(y[58]), .y59(y[59]), .y60(y[60]), .y61(y[61]), .y62(y[62]), .y63(y[63])
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