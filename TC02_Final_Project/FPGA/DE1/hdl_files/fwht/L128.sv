module L128(
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] x [127:0],
    output logic [31:0] y [127:0]
);
    reg [31:0] a_upper[64];
    reg [31:0] a_lower[64];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 64; i = i + 1) begin
                a_upper[i] <= 32'h0;
                a_lower[i] <= 32'h0;
            end
        end
        else begin
            for (i = 0; i < 64; i++) begin
                a_upper[i] <= x[i] + x[i + 64];
                a_lower[i] <= x[i] - x[i + 64];
            end
        end
    end

    L64 l64_upper(
        .clk(clk), .rst(rst),
        .x(a_upper),
        .y(y[63:0])
    );

    L64 l64_lower(
        .clk(clk), .rst(rst),
        .x(a_lower),
        .y(y[127:64])
    );

endmodule