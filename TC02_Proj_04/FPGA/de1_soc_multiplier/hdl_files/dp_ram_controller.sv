`include "./hdl_files/dp_ram_controller_states_defines.sv"

module dp_ram_controller(
	input CLK, WRITE_F, RESET, done
	input [3:0] ADDR,
	output [31:0] READ_DATA,
	input [31:0] WRITE_DATA
);

	parameter CONTROL = 2'b00, DATA_IN = 2'b01, DATA_OUT = 2'b10, STATUS = 2'b11;
	reg [3:0] state, next_state;
	
	always @(*) begin
		case (state)
			ST_IDLE_RAM_CONTROLLER: 
			begin			
				next_state <= READ_DATA[0] == 1'b1 ? ST_READ_INPUT : ST_IDLE_RAM_CONTROLLER;
			end
			ST_READ_INPUT:
			begin
				next_state <= ST_WAIT;
			end
			ST_WAIT_OPERATION:
			begin
				next_state <= done == 1'b1 ? ST_WRITE_OUTPUT : ST_WAIT;
			end
			ST_WRITE_OUTPUT:
			begin
				next_state <= ST_SET_FINISH;
			end
			ST_SET_FINISH:
			begin
				next_state <= ST_WAIT_SHUTDOWN;
			end
			ST_WAIT_SHUTDOWN:
			begin
				next_state <= READ_DATA[9] == 1'b0 ? ST_WAIT_SHUTDOWN : ST_CLEAR;
			end			
			ST_CLEAR:
			begin
				next_state <= ST_IDLE_RAM_CONTROLLER;
			end
		endcase
	end
	
	always @(posedge CLK) begin		
		state <= ~RESET ? ST_IDLE_RAM_CONTROLLER : next_state;
	end

endmodule
