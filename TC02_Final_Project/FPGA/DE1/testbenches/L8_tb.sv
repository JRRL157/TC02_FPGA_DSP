`timescale 1ns/1ps

module L8_tb();

    // Testbench signals
    logic [31:0] x [7:0];
    wire [31:0] y [7:0];
    logic [31:0] expected_y [7:0];

    logic clk;

    parameter CLK_PERIOD = 10ns; // 10ns period means 100 MHz clock (1 / 10ns = 100 MHz)
    parameter CLK_HALF_PERIOD = CLK_PERIOD / 2;

    always #CLK_HALF_PERIOD clk = ~clk;

    // File descriptors
    integer input_file_fd;
    integer output_file_fd;

    // Contador de testes
    int test_count = 0;
    int errors = 0;

    // Instantiate the FWHT module
    LN #(.N(8)) fwht_L8 (
        .clk(clk),
        .rst(1'b0),
        .x(x),
        .y(y)
    );

    initial begin
        clk = 0;

        input_file_fd = $fopen("../../../HPS/samples/input_samples_8.txt","r");

        if (input_file_fd == 0) begin
            $error("Erro: not possible to open input_samples_8.txt file!");
            $finish;
        end

        output_file_fd = $fopen("../../../HPS/samples/output_samples_8.txt","r");

        if (output_file_fd == 0) begin
            $error("Erro: not possible to open output_samples_8.txt file!");
            $fclose(output_file_fd);
            $finish;
        end

        while (!$feof(input_file_fd) && !$feof(output_file_fd)) begin

            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h\n", x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7]) == 8) begin
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h\n", expected_y[0], expected_y[1], expected_y[2], expected_y[3], expected_y[4], expected_y[5], expected_y[6], expected_y[7]) == 8) begin
                    test_count++;
                    #(2 * CLK_PERIOD);
                    $display("Actual output: y[0] = %h, y[1] = %h, y[2] = %h, y[3] = %h, y[4] = %h, y[5] = %h, y[6] = %h, y[7] = %h", y[0], y[1], y[2], y[3], y[4], y[5], y[6], y[7]);
                    $display("Expected output: y[0] = %h, y[1] = %h, y[2] = %h, y[3] = %h, y[4] = %h, y[5] = %h, y[6] = %h, y[7] = %h", expected_y[0], expected_y[1], expected_y[2], expected_y[3], expected_y[4], expected_y[5], expected_y[6], expected_y[7]);

                    if (y[0] !== expected_y[0] || y[1] !== expected_y[1] || y[2] !== expected_y[2] || y[3] !== expected_y[3] || y[4] !== expected_y[4] || y[5] !== expected_y[5] || y[6] !== expected_y[6] || y[7] !== expected_y[7]) begin
                        errors++;
                        $display("Error in test %0d!", test_count);
                    end 
                    else begin
                        $display("Test %0d passed.", test_count);
                    end
                end
            end
        end

    $fclose(input_file_fd);
    $fclose(output_file_fd);

    $display("All tests completed.");
    if (errors == 0) begin
        $display("All tests passed successfully!");
    end
    else begin
        $display("Total errors: %0d", errors);
    end

    $finish;
    end

endmodule
