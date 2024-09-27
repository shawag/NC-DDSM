`include "Timescale.v"
module OUTPUT_STAGE 
(
    input                    i_clk,
    input                    i_rst_n,

    input [3:0] i_network,

    output [3:0] o_frac
    
);

genvar i;
generate
    for(i=0; i<4; i=i+1) begin:frac_ff
        DELAY_UNIT #(
        	.P_DELAY_CYCLE 	( 1  ))
        u0_DELAY_UNIT_msb(
        	.i_clk   	( i_clk    ),
        	.i_rst_n 	( i_rst_n  ),
        	.i_in    	( i_network[i]     ),
        	.o_delay 	( o_frac[i]  )
        );
    end
endgenerate

endmodule