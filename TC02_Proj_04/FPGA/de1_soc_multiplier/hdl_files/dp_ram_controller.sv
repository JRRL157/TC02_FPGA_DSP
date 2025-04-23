`include "./hdl_files/dp_ram_controller_states_defines.sv"

module dp_ram_controller(
	input CLK, RESET,
	output [3:0] ADDR,
	output WRITE_F,
	output [31:0] WRITE_DATA,
	input [31:0] READ_DATA,
	output [3:0] BYTE_ENABLE,
	output [3:0] A, B,
	input done,
	input [7:0] Y
);

	parameter CONTROL = 2'b00, DATA_IN = 2'b01, DATA_OUT = 2'b10, STATUS = 2'b11;
	reg [3:0] state, next_state;

	always @(*) begin
		case (state)
			ST_IDLE_RAM_CONTROLLER: 
			begin			
				next_state = READ_DATA[0] == 1'b1 ? ST_WAIT_READ : ST_IDLE_RAM_CONTROLLER;
			end
			ST_WAIT_READ:
			begin
				next_state = ST_READ_INPUT;
			end
			ST_READ_INPUT:
			begin
				next_state = ST_WAIT_OPERATION;
			end
			ST_WAIT_OPERATION:
			begin
				next_state = done == 1'b1 ? ST_WRITE_OUTPUT : ST_WAIT_OPERATION;
			end
			ST_WRITE_OUTPUT:
			begin
				next_state = ST_SET_FINISH;
			end
			ST_SET_FINISH:
			begin
				next_state = ST_WAIT_SHUTDOWN;
			end
			ST_WAIT_SHUTDOWN:
			begin
				next_state = READ_DATA[9] == 1'b0 ? ST_WAIT_SHUTDOWN : ST_CLEAR;
			end
			ST_CLEAR:
			begin
				next_state = ST_IDLE_RAM_CONTROLLER;
			end
		endcase
	end
	
	always @(posedge CLK) begin		
		state <= RESET == 1'b0 ? ST_IDLE_RAM_CONTROLLER : next_state;
	end

	always @(state) begin
		case(state)
			ST_IDLE_RAM_CONTROLLER: begin
				A = 4'd0;
				B = 4'd0;
				WRITE_F = 1'b0;
			end 
			ST_WAIT_READ: begin
				A = 4'd0;
				B = 4'd0;
				WRITE_F = 1'b0;
				ADDR = ST_READ_INPUT;
			end
			ST_READ_INPUT: begin
				A = READ_DATA[4:1];
				B = READ_DATA[8:5];
				WRITE_F = 1'b0;
			end
			ST_WAIT_OPERATION: begin
				WRITE_F = 1'b1;
				ADDR = DATA_OUT;
				WRITE_DATA[7:0] = 8'hXX;
			end
			ST_WRITE_OUTPUT: begin
				WRITE_DATA = Y;
			end
			ST_WAIT_FINISH: begin
				ADDR = STATUS;
				WRITE_F = 1'b1;
			end
			ST_SET_FINISH: begin
				WRITE_DATA = 1;
				ADDR = STATUS;
				WRITE_DATA = 1;
			end
			ST_WAIT_SHUTDOWN: begin
				WRITE_F = 1'b0;
			end
			ST_CLEAR: begin
				WRITE_F = 1'b0;
			end
		endcase
	end

endmodule
