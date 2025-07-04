module L4(
    input clk,
    input rst,
    input logic [31:0] x0,
    input logic [31:0] x1,
    input logic [31:0] x2,
    input logic [31:0] x3,
    output logic [31:0] y0,
    output logic [31:0] y1,
    output logic [31:0] y2,
    output logic [31:0] y3
);

    reg [31:0] a0_reg, a1_reg, a2_reg, a3_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            a0_reg <= 32'h0;
            a2_reg <= 32'h0;
            a1_reg <= 32'h0;
            a3_reg <= 32'h0;
        end
        else begin
            a0_reg <= x0 + x2;
            a2_reg <= x0 - x2;
            a1_reg <= x1 + x3;
            a3_reg <= x1 - x3;
        end
    end

    L2 l2_0 (
        .x0(a0_reg),
        .x1(a1_reg),
        .y0(y0),
        .y1(y1)
    );

    L2 l2_1 (
        .x0(a2_reg),
        .x1(a3_reg),
        .y0(y2),
        .y1(y3)
    );

endmodule