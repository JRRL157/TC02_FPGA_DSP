`timescale 1ns/1ps

module L16_tb();
    logic [31:0] x [15:0];
    wire [31:0] y [15:0];
    logic [31:0] expected_y [15:0];
    logic [31:0] expected_y1 [15:0];
    logic [31:0] expected_y2 [15:0];

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

    LN #(.N(16)) fwht_L16 (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y)
    );
    
    initial begin
        clk = 0;
        rst = 1;

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

        #(2 * CLK_PERIOD);
        rst = 0;
        #(2 * CLK_PERIOD);

        while (!$feof(input_file_fd) && !$feof(output_file_fd)) begin

            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h\n", x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7]) == 8) begin
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h\n", expected_y[0], expected_y[1], expected_y[2], expected_y[3], expected_y[4], expected_y[5], expected_y[6], expected_y[7]) == 8) begin
                    test_count++;
                    #CLK_PERIOD;
                end
            end
            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h\n", x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7]) == 8) begin
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h\n", expected_y1[0], expected_y1[1], expected_y1[2], expected_y1[3], expected_y1[4], expected_y1[5], expected_y1[6], expected_y1[7]) == 8) begin
                    test_count++;
                    #CLK_PERIOD;
                end
            end
            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h\n", x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7]) == 8) begin
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h\n", expected_y2[0], expected_y2[1], expected_y2[2], expected_y2[3], expected_y2[4], expected_y2[5], expected_y2[6], expected_y2[7]) == 8) begin
                    test_count++;
                    #CLK_PERIOD;
                end
            end

            if (test_count >= 3) begin
                    if (test_count % 3 == 0) begin
                        if (y[0] !== expected_y[0] || y[1] !== expected_y[1] || y[2] !== expected_y[2] || y[3] !== expected_y[3] || y[4] !== expected_y[4] || y[5] !== expected_y[5] || y[6] !== expected_y[6] || y[7] !== expected_y[7]) begin
                            errors++;
                            $display("Error in test %0d!", test_count-2);
                        end 
                        else begin
                            $display("Test %0d passed.", test_count-2);
                        end
                    end
                    else if (test_count % 3 == 1) begin
                        if (y[0] !== expected_y1[0] || y[1] !== expected_y1[1] || y[2] !== expected_y1[2] || y[3] !== expected_y1[3] || y[4] !== expected_y1[4] || y[5] !== expected_y1[5] || y[6] !== expected_y1[6] || y[7] !== expected_y1[7]) begin
                            errors++;
                            $display("Error in test %0d!", test_count-1);
                        end 
                        else begin
                            $display("Test %0d passed.", test_count-1);
                        end
                    end
                    else if (test_count % 3 == 2) begin
                        if (y[0] !== expected_y2[0] || y[1] !== expected_y2[1] || y[2] !== expected_y2[2] || y[3] !== expected_y2[3] || y[4] !== expected_y2[4] || y[5] !== expected_y2[5] || y[6] !== expected_y2[6] || y[7] !== expected_y2[7]) begin
                            errors++;
                            $display("Error in test %0d!", test_count);
                        end 
                        else begin
                            $display("Test %0d passed.", test_count);
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