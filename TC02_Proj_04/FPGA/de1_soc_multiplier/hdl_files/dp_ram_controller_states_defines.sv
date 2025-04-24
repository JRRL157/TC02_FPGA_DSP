`ifndef DP_RAM_CONTROLLER_DEFINES_V
`define DP_RAM_CONTROLLER_DEFINES_V

typedef enum logic [3:0] {
   ST_IDLE_RAM_CONTROLLER = 4'd0, 
	ST_WAIT_READ = 4'd1,
	ST_READ_INPUT = 4'd2, 
	ST_WAIT_OPERATION = 4'd3,
	ST_WRITE_OUTPUT = 4'd4,
	ST_WAIT_FINISH = 4'd5,
	ST_SET_FINISH = 4'd6,
	ST_WAIT_SHUTDOWN = 4'd7,
	ST_CLEAR = 4'd8
} dp_ram_controller_states_t;

`endif