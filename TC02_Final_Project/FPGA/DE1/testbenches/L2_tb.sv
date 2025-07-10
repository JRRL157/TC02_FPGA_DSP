`timescale 1ns/1ps

module L2_tb();

    // Testbench signals
    logic [31:0] x [0:1];
    wire [31:0] y [1:0]; //THIS NEEDS TO BE A WIRE, NOT A LOGIC DUE TO AN ICARUS VERILOG LIMITATION WITH UNPACKED ARRAYS!
    logic [31:0] expected_y [0:1];

    // File descriptors
    integer input_file_fd;
    integer output_file_fd;

    // Contador de testes
    int test_count = 0;
    int errors = 0;

    // Instantiate the L2 module
    L2 fwht_L2 (
        .x(x),
        .y(y)
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

            if ($fscanf(input_file_fd, "%h %h\n", x[0], x[1]) == 2) begin
                if ($fscanf(output_file_fd, "%h %h\n", expected_y[0], expected_y[1]) == 2) begin
                    test_count++;
                    #100;
                    $display("Input: x[0] = %h, x[1] = %h", x[0], x[1]);
                    $display("Actual output: y[0] = %h, y[1] = %h", y[0], y[1]);
                    $display("Expected output: y[0] = %h, y[1] = %h",expected_y[0], expected_y[1]);

                    if (y[0] !== expected_y[0] || y[1] !== expected_y[1]) begin
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
