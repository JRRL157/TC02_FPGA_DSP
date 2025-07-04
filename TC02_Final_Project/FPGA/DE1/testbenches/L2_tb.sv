`timescale 1ns/1ps

module L2_tb();

    // Testbench signals
    logic [31:0] x0;
    logic [31:0] x1;
    logic [31:0] y0;
    logic [31:0] y1;
    logic [31:0] expected_y0;
    logic [31:0] expected_y1;

    // File descriptors
    integer input_file_fd;
    integer output_file_fd;

    // Contador de testes
    int test_count = 0;
    int errors = 0;

    // Instantiate the FWHT module
    L2 fwht_L2 (
        .x0(x0),
        .x1(x1),
        .y0(y0),
        .y1(y1)
    );
    
    initial begin
        input_file_fd = $fopen("../../../HPS/samples/input_samples_2.txt","r");

        if (input_file_fd == 0) begin
            $error("Erro: not possible to open input_samples_2.txt file!");
            $finish;
        end

        output_file_fd = $fopen("../../../HPS/samples/output_samples_2.txt","r");

        if (output_file_fd == 0) begin
            $error("Erro: not possible to open output_samples_2.txt file!");
            $fclose(output_file_fd);
            $finish;
        end

        while (!$feof(input_file_fd) && !$feof(output_file_fd)) begin

            if ($fscanf(input_file_fd, "%h %h\n", x0, x1) == 2) begin
                if ($fscanf(output_file_fd, "%h %h\n", expected_y0, expected_y1) == 2) begin
                    test_count++;
                    #100;
                    $display("Actual output: y0 = %h, y1 = %h", y0, y1);
                    $display("Expected output: y0 = %h, y1 = %h",expected_y0, expected_y1);

                    if (y0 !== expected_y0 || y1 !== expected_y1) begin
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
