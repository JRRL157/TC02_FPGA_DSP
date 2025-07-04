`ifndef MULTIPLIER_DEFINES_V
`define MULTIPLIER_DEFINES_V

typedef enum logic [2:0] {
   ST_IDLE    = 3'b000, 
	ST_COMPUTE_PROD0 = 3'b001, 
	ST_COMPUTE_PROD1 = 3'b010,
	ST_COMPUTE_PROD2 = 3'b011,
	ST_COMPUTE_PROD3 = 3'b100,
	ST_END     = 3'b101
} multiplier_states_t;


`endif