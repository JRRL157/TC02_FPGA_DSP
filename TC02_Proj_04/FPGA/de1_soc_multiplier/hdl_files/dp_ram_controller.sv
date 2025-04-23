`include "./hdl_files/dp_ram_controller_states_defines.sv"

module dp_ram_controller(
	input CLK, WRITE_F, RESET,
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
				next_state <= 
			end
			ST_READ_INPUT
		endcase
	end
	
	always @(posedge CLK) begin		
		state <= ~RESET ? ST_IDLE_RAM_CONTROLLER : next_state;
	end

endmodule
