module L16(
    input clk,
    input rst,
    input wire [31:0] x [15:0],
    output wire [31:0] y [15:0]
);
    reg [31:0] a_upper [8];
    reg [31:0] a_lower [8];
    wire [31:0] y_upper [7:0];
    wire [31:0] y_lower [7:0];

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 8; i++) begin
                a_upper[i] <= 32'h0;
                a_lower[i] <= 32'h0;
            end
        end
        else begin
            for(i = 0; i < 8; i++) begin
                a_upper[i] <= x[i] + x[i + 8];
                a_lower[i] <= x[i] - x[i + 8];
            end
        end
    end

    genvar gi;
    generate
        for (gi = 0; gi < 8; gi = gi + 1) begin: y_assign
            assign y[gi] = y_upper[gi];
            assign y[gi + 8] = y_lower[gi];
        end
    endgenerate

    L8 l8_upper(
        .clk(clk),
         .rst(rst),
        .x(a_upper),
        .y(y_upper)
    );

    L8 l8_lower(
        .clk(clk),
         .rst(rst),
        .x(a_lower),
        .y(y_lower)
    );

endmodule