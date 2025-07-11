module L8(
    input clk,
    input rst,
    input wire [31:0] x [7:0],
    output wire [31:0] y [7:0]
);
    reg [31:0] a_upper [3:0];
    reg [31:0] a_lower [3:0];
    wire [31:0] y_upper [3:0];
    wire [31:0] y_lower [3:0];

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

    genvar gi;
    generate
        for (gi = 0; gi < 4; gi = gi + 1) begin : y_assign
            assign y[gi] = y_upper[gi];
            assign y[gi + 4] = y_lower[gi];
        end
    endgenerate

    L4 l4_upper(
        .clk(clk),
        .rst(rst),
        .x(a_upper),
        .y(y_upper)
    );

    L4 l4_lower(
        .clk(clk),
        .rst(rst),
        .x(a_lower),
        .y(y_lower)
    );

endmodule