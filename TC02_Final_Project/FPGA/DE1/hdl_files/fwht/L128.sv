module L128(
    input       clk,
    input       rst,
    input  wire [31:0] x [127:0],
    output wire [31:0] y [127:0]
);
    reg [31:0] a_upper [63:0];
    reg [31:0] a_lower [63:0];
    wire [31:0] y_upper [63:0];
    wire [31:0] y_lower [63:0];

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

    genvar gi;
    generate
        for (gi = 0; gi < 64; gi++) begin : y_assign
            assign y[gi] = y_upper[gi];
            assign y[gi + 64] = y_lower[gi];
        end
    endgenerate

    L64 l64_upper(
        .clk(clk),
        .rst(rst),
        .x(a_upper),
        .y(y_upper)
    );

    L64 l64_lower(
        .clk(clk),
        .rst(rst),
        .x(a_lower),
        .y(y_lower)
    );

endmodule