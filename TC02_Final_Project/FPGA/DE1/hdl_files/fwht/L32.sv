module L32(
    input clk,
    input rst,
    input logic [31:0] x [31:0],
    output logic [31:0] y [31:0]
);
    reg [31:0] a_upper [16];
    reg [31:0] a_lower [16];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 16; i++) begin
                a_upper[i] <= 32'h0;
                a_lower[i] <= 32'h0;
            end
        end
        else begin
            for(i = 0; i < 16; i++) begin
                a_upper[i] <= x[i] + x[i + 16];
                a_lower[i] <= x[i] - x[i + 16];
            end
        end
    end
    
    L16 l16_upper(
        .clk(clk), .rst(rst),
        .x(a_upper),
        .y(y[15:0])
    );

    L16 l16_lower(
        .clk(clk), .rst(rst),
        .x(a_lower),
        .y(y[31:16])
    );

endmodule