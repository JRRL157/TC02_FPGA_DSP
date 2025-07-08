module L64(
    input clk,
    input rst,
    input logic [31:0] x [63:0],
    output logic [31:0] y [63:0]
);
    reg [31:0] a_upper[32];
    reg [31:0] a_lower[32];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 32; i++) begin
                a_upper[i] <= 32'h0;
                a_lower[i] <= 32'h0;
            end
        end
        else begin            
            for (i = 0; i < 32; i++) begin
                a_upper[i] <= x[i] + x[i + 32];
                a_lower[i] <= x[i] - x[i + 32];
            end
        end
    end

    L32 l32_upper(
        .clk(clk), .rst(rst),
        .x(a_upper),
        .y(y[31:0])
    );

    L32 l32_lower(
        .clk(clk), .rst(rst),
        .x(a_lower),
        .y(y[63:32])
    );

endmodule