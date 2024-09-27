`include "Timescale.v"
module ADDER_4_NCNET (
    input  [3:0]    i_add1,
    input  [3:0]    i_add2,
    input  [3:0]    i_miuns,

    output [3:0]    o_sum
);

wire [3:0] w_sum;
wire [3:0] w_miuns;


COMPLEMENT_TRANS #(
	.P_DATA_WIDTH 	( 4  ))
u_COMPLEMENT_TRANS(
	.i_num            	( i_miuns  ),
	.o_num_complement 	( w_miuns  )
);


ADDER_BASIC #(
	.P_DATA_WIDTH 	( 4  ))
u0_ADDER_BASIC(
	.i_a    	( i_add1     ),
	.i_b    	( i_add2     ),
	.i_cin  	( 1'b0   ),
	.o_sum  	( w_sum   ),
	.o_cout 	(         )
);

ADDER_BASIC #(
	.P_DATA_WIDTH 	( 4  ))
u1_ADDER_BASIC(
	.i_a    	( w_sum     ),
	.i_b    	( w_miuns   ),
	.i_cin  	( 1'b0   ),
	.o_sum  	( o_sum   ),
	.o_cout 	(         )
);

    
endmodule //ADDER_4_NCNET
