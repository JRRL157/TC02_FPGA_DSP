module L4(
    input clk,
    input rst,
    input wire [31:0] x [3:0],
    output wire [31:0] y [3:0]
);
    reg [31:0] a_upper [1:0];
    reg [31:0] a_lower [1:0];
    wire [31:0] y_upper [1:0];
    wire [31:0] y_lower [1:0];

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

    assign y[0] = y_upper[0];
    assign y[1] = y_upper[1];
    assign y[2] = y_lower[0];
    assign y[3] = y_lower[1];

    L2 l2_upper(
        .x(a_upper),
        .y(y_upper)
    );

    L2 l2_lower(
        .x(a_lower),
        .y(y_lower)
    );

endmodule