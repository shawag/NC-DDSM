`include "Timescale.v"
module NC_MASH_TOP #(
    parameter P_DATA_WIDTH = 6
)
(
    input      i_clk,
    input      i_rst_n,

    input [P_DATA_WIDTH-1:0] i_msb,
    input [P_DATA_WIDTH-1:0] i_isb1,
    input [P_DATA_WIDTH-1:0] i_isb2,
    input [P_DATA_WIDTH-1:0] i_lsb,

    output [3:0] o_frac
    
);

wire [P_DATA_WIDTH-1:0] w_msb;
wire [P_DATA_WIDTH-1:0] w_isb1;
wire [P_DATA_WIDTH-1:0] w_isb2;
wire [P_DATA_WIDTH-1:0] w_lsb;

wire                    w_quantize1;
wire                    w_quantize2;
wire                    w_quantize3;

wire [3:0]              w_network;


INPUT_STAGE #(
	.P_INPUT_WIDTH 	( P_DATA_WIDTH  ))
u_INPUT_STAGE(
	.i_clk   	( i_clk    ),
	.i_rst_n 	( i_rst_n  ),
	.i_msb   	( i_msb    ),
	.i_isb1  	( i_isb1   ),
	.i_isb2  	( i_isb2   ),
	.i_lsb   	( i_lsb    ),
	.o_msb   	( w_msb    ),
	.o_isb1  	( w_isb1   ),
	.o_isb2  	( w_isb2   ),
	.o_lsb   	( w_lsb    )
);


NC_MASH #(
	.P_DATA_WIDTH 	( P_DATA_WIDTH  ))
u_NC_MASH(
	.i_clk         	( i_clk          ),
	.i_rst_n       	( i_rst_n        ),
	.i_level1_data 	( w_msb          ),
	.i_level2_data 	( w_isb1         ),
	.i_level3_data 	( w_isb2         ),
	.i_level4_data 	( w_lsb          ),
	.o_quantize1   	( w_quantize1    ),
	.o_quantize2   	( w_quantize2    ),
	.o_quantize3   	( w_quantize3    )
);



NC_NETWORK u_NC_NETWORK(
	.i_clk       	( i_clk        ),
	.i_rst_n     	( i_rst_n      ),
	.i_quantize1 	( w_quantize1  ),
	.i_quantize2 	( w_quantize2  ),
	.i_quantize3 	( w_quantize3  ),
	.o_network   	( w_network    )
);



OUTPUT_STAGE u_OUTPUT_STAGE(
	.i_clk     	( i_clk      ),
	.i_rst_n   	( i_rst_n    ),
	.i_network 	( w_network  ),
	.o_frac    	( o_frac     )
);

   
endmodule //NC_MASH_TOP
