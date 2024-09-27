`include "Timescale.v"
module EFM_CHAIN #(
    parameter P_DATA_WIDTH = 6
)
( 
    input                    i_clk,
    input                    i_rst_n,

    input [P_DATA_WIDTH-1:0] i_level_data,
    input                    i_quantize1,
    input                    i_quantize2,
    input                    i_quantize3,

    output                   o_quantize1,
    output                   o_quantize2,
    output                   o_quantize3
);

wire [P_DATA_WIDTH-1:0] o_efm_data1;
wire [P_DATA_WIDTH-1:0] o_efm_data2;

EFM #(
	.P_DATA_WIDTH 	( P_DATA_WIDTH  ))
u0_EFM(
	.i_clk      	( i_clk       ),
	.i_rst_n    	( i_rst_n     ),
	.i_efm_data 	( i_level_data),
	.i_quantize 	( i_quantize1  ),
	.o_efm_data 	( o_efm_data1  ),
	.o_quantize 	( o_quantize1  )
);

EFM #(
	.P_DATA_WIDTH 	( P_DATA_WIDTH  ))
u1_EFM(
	.i_clk      	( i_clk       ),
	.i_rst_n    	( i_rst_n     ),
	.i_efm_data 	( o_efm_data1),
	.i_quantize 	( i_quantize2  ),
	.o_efm_data 	( o_efm_data2  ),
	.o_quantize 	( o_quantize2  )
);

EFM #(
	.P_DATA_WIDTH 	( P_DATA_WIDTH  ))
u2_EFM(
	.i_clk      	( i_clk       ),
	.i_rst_n    	( i_rst_n     ),
	.i_efm_data 	( o_efm_data2),
	.i_quantize 	( i_quantize3  ),
	.o_efm_data 	(              ),
	.o_quantize 	( o_quantize3  )
);

endmodule //moduleName
