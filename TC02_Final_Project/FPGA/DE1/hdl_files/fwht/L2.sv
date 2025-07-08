module L2(
    input  logic [31:0] x [1:0],
    output logic [31:0] y [1:0]
);
    assign y[0] = x[0] + x[1];
    assign y[1] = x[0] - x[1];

endmodule
