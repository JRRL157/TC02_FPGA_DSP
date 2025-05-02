`include "./hdl_files/multiplier_states_defines.sv"

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

	 wire [2:0] next_state;
	 reg [7:0] next_prod [3:0];
	 reg next_done;
	 reg [7:0] next_Y;

    controlador controlador_inst(
        .clk_i(clk),
        .rst_i(rst),
        .strt_cmpt_i(ena),
        .state_o(curr_state)
    );

	 always @(posedge clk) begin
		if (!rst) begin
			A_reg <= 8'b0;
			B_reg <= 8'b0;
			prod[0] <= 8'b0;
			prod[1] <= 8'b0;
			prod[2] <= 8'b0;
			prod[3] <= 8'b0;
			Y <= 8'b0;
			done <= 1'b0;
		end
		else
		begin
			A_reg <= {4'b0, A};
			B_reg <= {4'b0, B};
			prod[0] <= next_prod[0];
			prod[1] <= next_prod[1];
			prod[2] <= next_prod[2];
			prod[3] <= next_prod[3];
			Y <= next_Y;
			done <= next_done;
		end
	 end

    always @(*) begin
        next_state = curr_state;
        next_prod[0] = prod[0];
        next_prod[1] = prod[1];
        next_prod[2] = prod[2];
        next_prod[3] = prod[3];
        next_Y = Y;
        next_done = done;
		  case(curr_state)
            ST_IDLE: begin
                next_done = 1'b0;
					 next_Y = 8'b0;
					 next_prod[0] = 8'd0;
					 next_prod[1] = 8'd0;
					 next_prod[2] = 8'd0;
					 next_prod[3] = 8'd0;
					 next_state = ena ? ST_COMPUTE_PROD0 : ST_IDLE;
            end
            ST_COMPUTE_PROD0: begin
                next_prod[0] = B_reg[0] ? A_reg : 8'b0;
                next_done = 1'b0;
					 next_Y = 8'b0;
					 next_state = ST_COMPUTE_PROD1;
            end
            ST_COMPUTE_PROD1:
            begin
                next_prod[1] = B_reg[1] ? A_reg : 8'b0;
                next_done = 1'b0;
					 next_Y = 8'b0;
					 next_state = ST_COMPUTE_PROD2;
            end
            ST_COMPUTE_PROD2:
            begin
                next_prod[2] = B_reg[2] ? A_reg : 8'b0;
                next_done = 1'b0;
					 next_Y = 8'b0;
					 next_state = ST_COMPUTE_PROD3;
            end
            ST_COMPUTE_PROD3:
            begin
                next_prod[3] = B_reg[3] ? A_reg : 8'b0;
                next_done = 1'b0;
					 next_Y = 8'b0;
					 next_state = ST_END;
            end
            ST_END:
            begin                
					 next_done = 1'b1;
					 next_Y = next_prod[0] + (next_prod[1] << 1) + (next_prod[2] << 2) + (next_prod[3] << 3);
					 next_state = ST_IDLE;
            end
				default:
				begin
					next_done = 1'b0;
					next_Y = 8'b0;
				end
        endcase
    end

	 assign state = {1'b0, curr_state};
endmodule
