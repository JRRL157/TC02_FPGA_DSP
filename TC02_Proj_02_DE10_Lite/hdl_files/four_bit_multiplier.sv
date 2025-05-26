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
	wire [7:0] prod_i_w;
	wire [7:0] prod_o_w;

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
	
	registrador #(.DATA_WIDTH(8)) reg_prod_inst(
		.clk_i   (clk),
		.rst_i   (rst),
		.enable_i (1'b1),
		.data_i  (prod_i_w),
		.data_o  (prod_o_w)
   );

	controlador controlador_inst(
	  .clk_i(clk),
	  .rst_i(rst),
	  .strt_cmpt_i(ena),
	  .state_o(state)
	);

	always @(*) begin
	  prod_i_w = prod_o_w;
	  A_i_w = {4'b0, A};
	  B_i_w = {4'b0, B};
	  case(state)
			ST_IDLE: begin                
				 done_i_w = 1'b0;
				 Y_i_w = 8'b0;
				 prod_i_w = 8'd0;
			end
			ST_COMPUTE_PROD0: begin
				 prod_i_w= B_o_w[0] ? A_o_w + prod_o_w : prod_o_w;				 
				 done_i_w = 1'b0;
				 Y_i_w = 8'b0;
			end
			ST_COMPUTE_PROD1:
			begin
				 prod_i_w = B_o_w[1] ? (A_o_w << 1) + prod_o_w : prod_o_w;
				 done_i_w = 1'b0;
				 Y_i_w = 8'b0;
			end
			ST_COMPUTE_PROD2:
			begin
				 prod_i_w = B_o_w[2] ? (A_o_w << 2) + prod_o_w : prod_o_w;
				 done_i_w = 1'b0;
				 Y_i_w = 8'b0;
			end
			ST_COMPUTE_PROD3:
			begin
				 prod_i_w = B_o_w[3] ? (A_o_w << 3) + prod_o_w : prod_o_w;
				 done_i_w = 1'b0;
				 Y_i_w = 8'b0;
			end
			ST_END:
			begin
				 done_i_w = 1'b1;
				 Y_i_w = prod_o_w;
			end
			default:
			begin
				done_i_w = 1'b0;
				Y_i_w = 8'b1;
			end
	  endcase
	end

endmodule
