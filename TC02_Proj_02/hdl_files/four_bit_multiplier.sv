module four_bit_multiplier(
    input wire clk,
    input wire rst,
    input wire ena,
    input wire [3:0] A,
    input wire [3:0] B,
    output reg [7:0] Y,
    output wire done,
	 output reg [3:0] state
);

    reg [2:0] curr_state;
    reg [7:0] A_reg, B_reg;
    reg [7:0] prod [3:0];
    
    controlador controlador_inst(
        .clk_i(clk),
        .rst_i(rst),
        .strt_cmpt_i(ena),
        .state_o(curr_state)
    );
    
    always @(curr_state) begin
        A_reg = 8'b0;
		  B_reg = 8'b0;
		  Y = 8'b0;
		  prod = '{default: 8'd0};
		  done = 1'b0;
		  case(curr_state)
            ST_IDLE: begin
                A_reg = {4'b0, A};
                B_reg = {4'b0, B};
                done = 1'b0;
            end
            ST_COMPUTE_PROD0: begin
                prod[0] = B_reg[0] ? A_reg : 8'b0;
                done = 1'b0;
            end
            ST_COMPUTE_PROD1:
            begin
                prod[1] = B_reg[1] ? A_reg : 8'b0;
                done = 1'b0;
            end
            ST_COMPUTE_PROD2:
            begin
                prod[2] = B_reg[2] ? A_reg : 8'b0;
                done = 1'b0;
            end
            ST_COMPUTE_PROD3:
            begin
                prod[3] = B_reg[3] ? A_reg : 8'b0;
                done = 1'b0;
            end
            ST_END:
            begin
                Y = prod[0] + (prod[1] << 1) + (prod[2] << 2) + (prod[3] << 3);
					 done <= 1'b1;
            end
        endcase
    end
	 
	 assign state = {1'b0, curr_state};
endmodule
