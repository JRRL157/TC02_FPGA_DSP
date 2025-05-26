`include "./hdl_files/multiplier_states_defines.sv"

module four_bit_multiplier(
    input wire clk,
    input wire rst,
    input wire ena,
    input wire [3:0] A,
    input wire [3:0] B,
    output wire [7:0] Y,
    output wire done,
	 output wire [2:0] state
);
	wire [7:0] A_i_w, A_o_w, B_i_w, B_o_w;
	wire done_i_w;
	wire [7:0] Y_i_w;

	registrador #(.DATA_WIDTH(8)) reg_A_inst(
		.clk_i   (clk),
		.rst_i   (rst),
		.enable_i (1'b1),
		.data_i  (A_i_w),
		.data_o  (A_o_w)
   );
	registrador #(.DATA_WIDTH(8)) reg_B_inst(
		.clk_i   (clk),
		.rst_i   (rst),
		.enable_i (1'b1),
		.data_i  (B_i_w),
		.data_o  (B_o_w)
   );
	registrador #(.DATA_WIDTH(8)) reg_Y_inst(
		.clk_i   (clk),
		.rst_i   (rst),
		.enable_i (1'b1),
		.data_i  (Y_i_w),
		.data_o  (Y)
   );
	registrador #(.DATA_WIDTH(1)) reg_done_inst(
		.clk_i   (clk),
		.rst_i   (rst),
		.enable_i (1'b1),
		.data_i  (done_i_w),
		.data_o  (done)
   );
	reg [7:0] prod [3:0];
	reg [7:0] next_prod [3:0]; 

    controlador controlador_inst(
        .clk_i(clk),
        .rst_i(rst),
        .strt_cmpt_i(ena),
        .state_o(state)
    );

	 always @(posedge clk) begin
		if (!rst) begin
			prod[0] <= 8'b0;
			prod[1] <= 8'b0;
			prod[2] <= 8'b0;
			prod[3] <= 8'b0;
		end
		else
		begin
			prod[0] <= next_prod[0];
			prod[1] <= next_prod[1];
			prod[2] <= next_prod[2];
			prod[3] <= next_prod[3];
		end
	 end

    always @(*) begin        
        next_prod[0] = prod[0];
        next_prod[1] = prod[1];
        next_prod[2] = prod[2];
        next_prod[3] = prod[3];
		  A_i_w = {4'b0, A};
		  B_i_w = {4'b0, B};
		  case(state)
            ST_IDLE: begin                
					 done_i_w = 1'b0;
					 Y_i_w = 8'b0;
					 next_prod[0] = 8'd0;
					 next_prod[1] = 8'd0;
					 next_prod[2] = 8'd0;
					 next_prod[3] = 8'd0;
					 //state_i_w = ena ? ST_COMPUTE_PROD0 : ST_IDLE;
            end
            ST_COMPUTE_PROD0: begin
                next_prod[0] = B_o_w[0] ? A_o_w : 8'b0;
                done_i_w = 1'b0;
					 Y_i_w = 8'b0;
					 //state_i_w = ST_COMPUTE_PROD1;
            end
            ST_COMPUTE_PROD1:
            begin
                next_prod[1] = B_o_w[1] ? A_o_w : 8'b0;
                done_i_w = 1'b0;
					 Y_i_w = 8'b0;
					 //state_i_w = ST_COMPUTE_PROD2;
            end
            ST_COMPUTE_PROD2:
            begin
                next_prod[2] = B_o_w[2] ? A_o_w : 8'b0;
                done_i_w = 1'b0;
					 Y_i_w = 8'b0;
					 //state_i_w = ST_COMPUTE_PROD3;
            end
            ST_COMPUTE_PROD3:
            begin
                next_prod[3] = B_o_w[3] ? A_o_w : 8'b0;
                done_i_w = 1'b0;
					 Y_i_w = 8'b0;
					 //state_i_w = ST_END;
            end
            ST_END:
            begin
					 done_i_w = 1'b1;
					 Y_i_w = next_prod[0] + (next_prod[1] << 1) + (next_prod[2] << 2) + (next_prod[3] << 3);
					 //state_i_w = ST_IDLE;
            end
				default:
				begin
					done_i_w = 1'b0;
					Y_i_w = 8'b1;
				end
        endcase
    end

	//assign state = state_o_w;

endmodule
