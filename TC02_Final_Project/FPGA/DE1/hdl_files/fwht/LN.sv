module LN #(parameter N=8)(
    input clk,
    input rst,
    input wire [31:0] x [N-1:0],
    output wire [31:0] y [N-1:0]
);
    reg [31:0] a_upper [N/2 -1:0];
    reg [31:0] a_lower [N/2 -1:0];
    wire [31:0] y_upper [N/2 -1:0];
    wire [31:0] y_lower [N/2 -1:0];

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < N/2; i++) begin
                a_upper[i] <= 32'h0;
                a_lower[i] <= 32'h0;
            end
        end
        else begin
            for(i = 0; i < N/2; i++) begin
                a_upper[i] <= x[i] + x[i + N/2];
                a_lower[i] <= x[i] - x[i + N/2];
            end
        end
    end

    genvar gi;
    generate
        for (gi = 0; gi < N/2; gi = gi + 1) begin : y_assign
            assign y[gi] = y_upper[gi];
            assign y[gi + N/2] = y_lower[gi];
        end
    endgenerate

    generate
        if (N == 4) begin
            L2 l2_upper(
                .x(a_upper),
                .y(y_upper)
            );

            L2 l2_lower(
                .x(a_lower),
                .y(y_lower)
            );
        end 
        else begin
            LN #(.N(N/2)) half_upper(
                .clk(clk),
                .rst(rst),
                .x(a_upper),
                .y(y_upper)
            );

            LN #(.N(N/2)) half_lower(
                .clk(clk),
                .rst(rst),
                .x(a_lower),
                .y(y_lower)
            );
        end
    endgenerate

endmodule
