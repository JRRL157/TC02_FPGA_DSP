module KEY_INC (
    input clk,
	input key_btn,
    input reset,     // Synchronous active-high reset
    output wire slow_clk,
	output reg [3:0] out_cnt);

	wire slow_w;

    clock_divider div0(.clk_in(clk), .rst(reset), .clk_out(slow_w));
	 
    always @(posedge slow_w) begin
		  out_cnt <= reset ? 4'b0 : !key_btn ? out_cnt + 1 : out_cnt;
    end

	 assign slow_clk = slow_w;
endmodule

module clock_divider (
    input wire clk_in,    
    input wire rst,       
    output reg clk_out    
);

    reg [23:0] counter;  

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else if (counter == 2499999) begin
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
		  //counter <= rst ? 24'b0 : counter == 9999999 ? 0 : counter <= counter + 1;
		  //clk_out <= rst ? 1'b0 : counter == 9999999 ? ~clk_out : clk_out;
    end

endmodule
