`include "Timescale.v"
module EFM #(
    parameter P_DATA_WIDTH = 6
)
(
    input                       i_clk       ,
    input                       i_rst_n     ,
    input [P_DATA_WIDTH-1:0]    i_efm_data       ,
    input                       i_quantize     ,
    output [P_DATA_WIDTH-1:0]   o_efm_data      ,
    output                      o_quantize    
);
reg ro_quantize;
wire w_quantize;
assign o_quantize = ro_quantize;
reg [P_DATA_WIDTH-1:0] r_efm_data;

always @(posedge i_clk or negedge i_rst_n) begin
    if(~i_rst_n)
        r_efm_data  <= {P_DATA_WIDTH{1'b0}};
    else
        r_efm_data  <= o_efm_data; 
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(~i_rst_n)
        ro_quantize <= 1'b0;
    else
        ro_quantize <= w_quantize;
end

PIPELINE_ADDER #(
	.P_DATA_WIDTH 	( P_DATA_WIDTH  ))
u_PIPELINE_ADDER(
	.i_clk   	( i_clk           ),
	.i_rst_n 	( i_rst_n         ),
	.i_a     	( i_efm_data      ),
	.i_b     	( r_efm_data      ),
	.i_cin   	( i_quantize      ),
	.o_sum   	( o_efm_data      ),
	.o_cout  	( w_quantize      )
);


endmodule //EFM
