`include "./hdl_files/custom_dpram_defines.sv"

module custom_dpram
    #(
        parameter  BUS_WIDTH  = 1,
        parameter  DATA_WIDTH = 32,
        parameter  BE_WIDTH   = 4
    )
    (
    //common signal
    input       clk_i,
    input       rst_i,
    //Wishbone Slave interface
    //Wishbone interface:
    input  [BUS_WIDTH-1:0]  adr_i,  //Address In
    input  [DATA_WIDTH-1:0] data_i, //Data In
    output [DATA_WIDTH-1:0] data_o, //Data Out
    input  we_i,                    //Write Enable In
    input  [BE_WIDTH-1:  0] sel_i,  //Select input array
    input  stb_i,                   //Strobe In
    output ack_o,                   //Acknowledged Out
    //mult_4bits interface
    //output dpram_estado_t state_o,
    output [3:0] A_o,
    output [3:0] B_o,
    output       enable_o,
    input  [7:0] Y_i,
    input        fim_i
);

registrador                      //Instanciando uma entidade;
	#(
	.DATA_WIDTH(1)               //parametro que controla o tamanho do registrador;
	)
	 reg_Control_inst
    (
    .clk_i   (clk_i),       //clok da placa;
    .rst_i   (rst_i),       //veja que o reset e ativo em zero;
	.enable_i (1'b1),
    .data_i  (ctrl_in_w),    
    .data_o  (ctrl_out_w) 
);

registrador                      //Instanciando uma entidade;
	#(
	.DATA_WIDTH(8)               //parametro que controla o tamanho do registrador;
	)
	 reg_AB_inst
    (
    .clk_i   (clk_i),       //clok da placa;
    .rst_i   (rst_i),       //veja que o reset e ativo em zero;
	.enable_i (1'b1),
    .data_i  (AB_in_w),    
    .data_o  (AB_out_w) 
); 


wire ctrl_in_w, ctrl_out_w;
wire [7:0] AB_in_w, AB_out_w;

always @(*) begin
    casez ({we_i, sel_i})
        {1'b1, `CDPRAM_SEL_CONTROL}: ctrl_in_w = data_i[0];
        {1'b1, `CDPRAM_SEL_DATA_IN}: AB_in_w = data_i[17:8];
        {1'b0, 4'bzzzz}: 
        begin
            ctrl_in_w = ctrl_out_w;
            AB_in_w = AB_out_w;
        end
    endcase
end

assign A_o = AB_out_w[3:0];
assign B_o = AB_out_w[7:4];
assign enable_o = ctrl_out_w;
assign data_o = {7'd0, fim_i, Y_i, AB_out_w, 7'd0, ctrl_out_w};

endmodule
