`timescale 1ns/1ps

module L8_tb();

    // Testbench signals
    logic [31:0] x0;
    logic [31:0] x1;
    logic [31:0] x2;
    logic [31:0] x3;
    logic [31:0] x4;
    logic [31:0] x5;
    logic [31:0] x6;
    logic [31:0] x7;

    logic [31:0] y0;
    logic [31:0] y1;
    logic [31:0] y2;
    logic [31:0] y3;
    logic [31:0] y4;
    logic [31:0] y5;
    logic [31:0] y6;
    logic [31:0] y7;

    logic [31:0] expected_y0;
    logic [31:0] expected_y1;
    logic [31:0] expected_y2;
    logic [31:0] expected_y3;
    logic [31:0] expected_y4;
    logic [31:0] expected_y5;
    logic [31:0] expected_y6;
    logic [31:0] expected_y7;

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
    L8 fwht_L8 (
        .clk(clk),
        .rst(1'b0),
        .x0(x0),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .x4(x4),
        .x5(x5),
        .x6(x6),
        .x7(x7),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3),
        .y4(y4),
        .y5(y5),
        .y6(y6),
        .y7(y7)
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

            if ($fscanf(input_file_fd, "%h %h %h %h %h %h %h %h\n", x0, x1, x2, x3, x4, x5, x6, x7) == 8) begin
                if ($fscanf(output_file_fd, "%h %h %h %h %h %h %h %h\n", expected_y0, expected_y1, expected_y2, expected_y3, expected_y4, expected_y5, expected_y6, expected_y7) == 8) begin
                    test_count++;
                    #100;
                    $display("Actual output: y0 = %h, y1 = %h, y2 = %h, y3 = %h, y4 = %h, y5 = %h, y6 = %h, y7 = %h", y0, y1, y2, y3, y4, y5, y6, y7);
                    $display("Expected output: y0 = %h, y1 = %h, y2 = %h, y3 = %h, y4 = %h, y5 = %h, y6 = %h, y7 = %h", expected_y0, expected_y1, expected_y2, expected_y3, expected_y4, expected_y5, expected_y6, expected_y7);

                    if (y0 !== expected_y0 || y1 !== expected_y1 || y2 !== expected_y2 || y3 !== expected_y3 || y4 !== expected_y4 || y5 !== expected_y5 || y6 !== expected_y6 || y7 !== expected_y7) begin
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
