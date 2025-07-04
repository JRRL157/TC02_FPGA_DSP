module L2(
    input  logic [31:0] x0,
    input  logic [31:0] x1,
    output logic [31:0] y0,
    output logic [31:0] y1
);
    assign y0 = x0 + x1;
    assign y1 = x0 - x1;

endmodule
