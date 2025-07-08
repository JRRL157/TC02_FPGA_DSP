module L8(
    input clk,
    input rst,
    input logic [31:0] x [7:0],
    output logic [31:0] y [7:0]
);
    reg [31:0] a_upper [4];
    reg [31:0] a_lower [4];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4; i++) begin
                a_upper[i] <= 32'h0;
                a_lower[i] <= 32'h0;
            end
        end
        else begin
            for(i = 0; i < 4; i++) begin
                a_upper[i] <= x[i] + x[i + 4];
                a_lower[i] <= x[i] - x[i + 4];
            end
        end
    end
    
    L4 l4_upper(
        .clk(clk), .rst(rst),
        .x(a_upper),
        .y(y[3:0])
    );

    L4 l4_lower(
        .clk(clk), .rst(rst),
        .x(a_lower),
        .y(y[7:4])
    );

endmodule