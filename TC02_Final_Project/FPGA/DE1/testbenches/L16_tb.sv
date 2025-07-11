`timescale 1ns/1ps

module L16_tb();

    // Testbench signals for N=16
    logic [31:0] x [15:0];
    wire [31:0] y [15:0];
    logic [31:0] expected_y [15:0];

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

    // Instantiate the L16 module
    L16 fwht_L16 (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y)
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
                         x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15]) == 16) begin
                // Read 16 expected outputs
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",
                             expected_y[0], expected_y[1], expected_y[2], expected_y[3], expected_y[4], expected_y[5], expected_y[6], expected_y[7],
                             expected_y[8], expected_y[9], expected_y[10], expected_y[11], expected_y[12], expected_y[13], expected_y[14], expected_y[15]) == 16) begin
                    
                    test_count++;
                    #100; // Wait for the DUT to compute the result (adjust if needed)

                    $display("\n--- Test Case %0d ---", test_count);
                    has_error = 0;
                    for (i = 0; i < 16; i++) begin
                        if (y[i] !== expected_y[i]) begin
                            has_error = 1;
                            $display("Mismatch at y[%0d]: Expected %h, got %h", i, expected_y[i], y[i]);
                        end
                    end

                    // Check for errors
                    if (has_error) begin
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