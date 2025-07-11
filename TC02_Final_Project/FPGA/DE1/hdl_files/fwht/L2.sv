module L2(
    input  wire [31:0] x [1:0],
    output wire [31:0] y [1:0]
);
    assign y[0] = x[0] + x[1];
    assign y[1] = x[0] - x[1];

endmodule
