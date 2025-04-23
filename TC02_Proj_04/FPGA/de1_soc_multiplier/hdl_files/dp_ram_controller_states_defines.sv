`ifndef DP_RAM_CONTROLLER_DEFINES_V
`define DP_RAM_CONTROLLER_DEFINES_V

typedef enum logic [3:0] {
   ST_IDLE_RAM_CONTROLLER    = 4'b000, 
	ST_READ_INPUT = 4'b001, 
	ST_WAIT = 4'b010,
	ST_WRITE_OUTPUT = 4'b011,
	ST_SET_FINISH = 4'b100,
	ST_WAIT_SHUTDOWN = 4'b101,
	ST_CLEAR = 4'b110
} dp_ram_controller_states_t;

`endif