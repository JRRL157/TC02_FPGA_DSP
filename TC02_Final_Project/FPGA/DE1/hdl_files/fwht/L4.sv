module L4(
    input clk,
    input rst,
    input logic [31:0] x [3:0],
    output logic [31:0] y [3:0]
);
    reg [31:0] a_upper [1:0];
    reg [31:0] a_lower [1:0];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 2; i++) begin
                a_upper[i] <= 32'h0;
                a_lower[i] <= 32'h0;
            end
        end
        else begin
            for(i = 0; i < 2; i++) begin
                a_upper[i] <= x[i] + x[i + 2];
                a_lower[i] <= x[i] - x[i + 2];
            end
        end
    end
    
    L2 l2_upper(
        .x(a_upper),
        .y(y[1:0])
    );

    L2 l2_lower(
        .x(a_lower),
        .y(y[3:2])
    );

endmodule