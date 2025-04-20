`include "./hdl_files/multiplier_states_defines.sv"

module controlador
(
    input          clk_i,
    input          rst_i,
    input          strt_cmpt_i,
    output [ 2:0]  state_o
);

// INTERNAL SIGNALS ################################

multiplier_states_t  state, next_state;

// INTERNAL LOGIC ##################################

// Output logic
assign state_o = state;

//#################### SEQUENTIAL LOGIC

    // state update and reset
    always @(posedge clk_i, negedge rst_i) 
	 begin
        if (rst_i == 1'b0)
            state <= ST_IDLE;
        else
            state <= next_state;
    end

    // transiction logic
    always @(strt_cmpt_i,state) begin
        case (state)
            ST_IDLE:
            begin
                if(strt_cmpt_i)
                begin
                    next_state   <=  ST_COMPUTE_PROD0;
                end
                else
                begin
                    next_state   <=  ST_IDLE;
                end
            end    
            ST_COMPUTE_PROD0:
            begin   
                next_state     <= ST_COMPUTE_PROD1 ;
            end
            
            ST_COMPUTE_PROD1:
            begin   
                next_state     <= ST_COMPUTE_PROD2 ;
            end

            ST_COMPUTE_PROD2:
            begin   
                next_state     <= ST_COMPUTE_PROD3 ;
            end

            ST_COMPUTE_PROD3:
            begin   
                next_state     <= ST_END ;
            end

            ST_END:
                if(strt_cmpt_i)
                begin
                    next_state   <=  ST_END;
                end
                else
                begin
                    next_state   <=  ST_IDLE;
                end
            default: 
            begin
                next_state     <= ST_IDLE;
            end
        endcase
    end

endmodule