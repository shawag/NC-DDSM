`include "Timescale.v"
module NC_MASH #(
    parameter P_DATA_WIDTH = 6
)
(
    input                    i_clk,
    input                    i_rst_n,

    input [P_DATA_WIDTH-1:0] i_level1_data,
    input [P_DATA_WIDTH-1:0] i_level2_data,
    input [P_DATA_WIDTH-1:0] i_level3_data,
    input [P_DATA_WIDTH-1:0] i_level4_data,
   
    output                   o_quantize1,
    output                   o_quantize2,
    output                   o_quantize3
);
wire w_quantize21;
wire w_quantize22;
wire w_quantize23;

wire w_quantize31;
wire w_quantize32;
wire w_quantize33;

wire w_quantize41;
wire w_quantize42;
wire w_quantize43;


EFM_CHAIN #(
	.P_DATA_WIDTH 	( P_DATA_WIDTH  ))
u0_EFM_CHAIN(
	.i_clk        	( i_clk         ),
	.i_rst_n      	( i_rst_n       ),
	.i_level_data 	( i_level1_data  ),
	.i_quantize1  	( w_quantize21   ),
	.i_quantize2  	( w_quantize22   ),
	.i_quantize3  	( w_quantize23   ),
	.o_quantize1  	( o_quantize1   ),
	.o_quantize2  	( o_quantize2   ),
	.o_quantize3  	( o_quantize3   )
);

EFM_CHAIN #(
	.P_DATA_WIDTH 	( P_DATA_WIDTH  ))
u1_EFM_CHAIN(
	.i_clk        	( i_clk         ),
	.i_rst_n      	( i_rst_n       ),
	.i_level_data 	( i_level2_data  ),
	.i_quantize1  	( w_quantize31   ),
	.i_quantize2  	( w_quantize32   ),
	.i_quantize3  	( w_quantize33   ),
	.o_quantize1  	( w_quantize21   ),
	.o_quantize2  	( w_quantize22   ),
	.o_quantize3  	( w_quantize23   )
);

EFM_CHAIN #(
	.P_DATA_WIDTH 	( P_DATA_WIDTH  ))
u2_EFM_CHAIN(
	.i_clk        	( i_clk         ),
	.i_rst_n      	( i_rst_n       ),
	.i_level_data 	( i_level3_data  ),
	.i_quantize1  	( w_quantize41   ),
	.i_quantize2  	( w_quantize42   ),
	.i_quantize3  	( w_quantize43   ),
	.o_quantize1  	( w_quantize31   ),
	.o_quantize2  	( w_quantize32   ),
	.o_quantize3  	( w_quantize33   )
);

EFM_CHAIN #(
	.P_DATA_WIDTH 	( P_DATA_WIDTH  ))
u3_EFM_CHAIN(
	.i_clk        	( i_clk         ),
	.i_rst_n      	( i_rst_n       ),
	.i_level_data 	( i_level4_data  ),
	.i_quantize1  	( 1'b0   ),
	.i_quantize2  	( 1'b0   ),
	.i_quantize3  	( 1'b0   ),
	.o_quantize1  	( w_quantize41   ),
	.o_quantize2  	( w_quantize42   ),
	.o_quantize3  	( w_quantize43   )
);

endmodule