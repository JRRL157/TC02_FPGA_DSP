module L64(
    input clk,
    input rst,
    input wire [31:0] x [63:0],
    output wire [31:0] y [63:0]
);
    reg [31:0] a_upper [31:0];
    reg [31:0] a_lower [31:0];
    wire [31:0] y_upper [31:0];
    wire [31:0] y_lower [31:0];

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

    genvar gi;
    generate
        for (gi = 0; gi < 32; gi++) begin : y_assign
            assign y[gi] = y_upper[gi];
            assign y[gi + 32] = y_lower[gi];
        end
    endgenerate

    L32 l32_upper(
        .clk(clk), 
        .rst(rst),
        .x(a_upper),
        .y(y_upper)
    );

    L32 l32_lower(
        .clk(clk), .rst(rst),
        .x(a_lower),
        .y(y_lower)
    );

endmodule