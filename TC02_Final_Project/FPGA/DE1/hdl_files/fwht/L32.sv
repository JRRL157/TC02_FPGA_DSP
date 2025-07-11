module L32(
    input clk,
    input rst,
    input logic [31:0] x [31:0],
    output logic [31:0] y [31:0]
);
    reg [31:0] a_upper [15:0];
    reg [31:0] a_lower [15:0];
    wire [31:0] y_upper [15:0];
    wire [31:0] y_lower [15:0];

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

    genvar gi;
    generate
        for (gi = 0; gi < 16; gi++) begin : y_assign
            assign y[gi] = y_upper[gi];
            assign y[gi + 16] = y_lower[gi];
        end
    endgenerate
    
    L16 l16_upper(
        .clk(clk),
        .rst(rst),
        .x(a_upper),
        .y(y_upper)
    );

    L16 l16_lower(
        .clk(clk),
        .rst(rst),
        .x(a_lower),
        .y(y_lower)
    );

endmodule