`include "./hdl_files/dp_ram_controller_states_defines.sv"

module dp_ram_controller(
	input CLK,
	input rst,
	output [3:0] ADDR,
	output WRITE_F,
	output [31:0] WRITE_DATA,
	input [31:0] READ_DATA,
	output [3:0] BYTE_ENABLE,
	output [3:0] A, B,
	input done,
	input [7:0] Y,
	output ena,
	output [3:0] state_o
);

	parameter CONTROL = 4'h0, DATA_IN = 4'h1, DATA_OUT = 4'h2, STATUS = 4'h3;
	reg [3:0] state, next_state;
	reg [25:0] cnt;
	wire crlt0_w;

	always @(crlt0_w, done, state) begin
		case (state)
			ST_IDLE_RAM_CONTROLLER: begin			
				next_state <= crlt0_w ? ST_READ_INPUT : ST_IDLE_RAM_CONTROLLER;
			end
			ST_READ_INPUT: begin
				next_state <= cnt == 50_000_000 ? ST_CALC_PROD : ST_READ_INPUT;
			end
			ST_CALC_PROD: begin
				next_state <= cnt == 50_000_000 ? ST_WAIT_CALC : ST_CALC_PROD;
			end
			ST_WAIT_CALC: begin
				next_state <= done == 1'b1 ? ST_WRITE_OUTPUT : ST_WAIT_CALC;
			end
			ST_WRITE_OUTPUT: begin
				next_state <= cnt == 50_000_000 ? ST_WAIT_FINISH : ST_WRITE_OUTPUT;
			end
			ST_WAIT_FINISH: begin
				next_state <= ST_SET_FINISH;
			end
			ST_SET_FINISH: begin
				next_state <= ST_WAIT_SHUTDOWN;
			end
			ST_WAIT_SHUTDOWN: begin
				next_state <= crlt0_w ? ST_WAIT_SHUTDOWN : ST_CLEAR;
			end
			ST_CLEAR: begin
				next_state <= ST_IDLE_RAM_CONTROLLER;
			end
			default: begin
				next_state <= ST_IDLE_RAM_CONTROLLER;
			end
		endcase
	end

	always @(posedge CLK, negedge rst) begin
		if(rst == 1'b0) begin
			state <= ST_IDLE_RAM_CONTROLLER;
			cnt <= 26'h0;
		end
		else begin
			state <= next_state;
			cnt <= cnt < 50_000_000 ? cnt + 1 : 26'h0;
		end
	end

	always @(*) begin
		case(state)
			ST_IDLE_RAM_CONTROLLER: begin
            A = 4'hX;  
            B = 4'hX;
				WRITE_DATA= 32'hXXXX;
				WRITE_F = 1'b0;
				ADDR = CONTROL;
				ena = 1'b0;
			end 
			ST_READ_INPUT: begin
				A = READ_DATA[3:0];
				B = READ_DATA[7:4];
				ADDR = DATA_IN;
				WRITE_DATA= 32'hXXX;
				WRITE_F = 1'b0;
				ena = 1'b0;
			end
			ST_CALC_PROD: begin
				A = READ_DATA[3:0];
				B = READ_DATA[7:4];
				ADDR = DATA_IN;
				WRITE_DATA= 32'hXXXX;
				WRITE_F = 1'b0;
				ena = 1'b1;
			end
			ST_WAIT_CALC: begin
				A = 4'hX;
				B = 4'hX;
				ADDR = DATA_OUT;
				WRITE_DATA= {24'h0,Y};
				WRITE_F = 1'b0;
				ena = 1'b1;
			end
			ST_WRITE_OUTPUT: begin
				A = 4'hX;
				B = 4'hX;
				ADDR = DATA_OUT;
				WRITE_DATA= {24'h0,Y};
				WRITE_F = 1'b1;
				ena = 1'b1;
			end
			ST_WAIT_FINISH: begin
				A = 4'hX;  
            B = 4'hX;
				ADDR = STATUS;
				WRITE_F = 1'b0;
				WRITE_DATA = 32'h1;
				ena = 1'b1;
			end
			ST_SET_FINISH: begin
				A = 4'hX;  
            B = 4'hX;
				WRITE_F = 1'b1;
				ADDR = STATUS;
				WRITE_DATA = 32'h1;
				ena = 1'b1;
			end
			ST_WAIT_SHUTDOWN: begin
				A = 4'hX;
            B = 4'hX;
				ADDR = CONTROL;
				WRITE_F = 1'b0;
				WRITE_DATA= 32'hXXXX;
				ena = READ_DATA[0];
			end
			ST_CLEAR: begin
				A = 4'hX;  
            B = 4'hX;
				ADDR = STATUS;
				WRITE_F = 1'b1;
				WRITE_DATA= 32'h0;
				ena = 1'b0;
			end
			default: begin
				WRITE_F = 1'b0;
				WRITE_DATA = 32'hXXXX;
				ADDR = CONTROL;
				A = 4'hX;
				B = 4'hX;
				ena = 1'b0;
			end
		endcase
	end

	assign state_o = state;
	assign crlt0_w = (state == ST_IDLE_RAM_CONTROLLER) ? READ_DATA[0] : (state == ST_WAIT_SHUTDOWN) ? READ_DATA[0] : ena;
	assign BYTE_ENABLE = 4'b1111;
endmodule
