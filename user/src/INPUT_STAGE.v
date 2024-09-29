`include "Timescale.v"
module INPUT_STAGE #(
    parameter P_INPUT_WIDTH = 6
)
(
    input                    i_clk,
    input                    i_rst_n,

    input [P_INPUT_WIDTH-1:0] i_msb,
    input [P_INPUT_WIDTH-1:0] i_isb1,
    input [P_INPUT_WIDTH-1:0] i_isb2,
    input [P_INPUT_WIDTH-1:0] i_lsb,

    output [P_INPUT_WIDTH-1:0] o_msb,
    output [P_INPUT_WIDTH-1:0] o_isb1,
    output [P_INPUT_WIDTH-1:0] o_isb2,
    output [P_INPUT_WIDTH-1:0] o_lsb    
    
);



genvar i;
generate
    for(i=0; i<P_INPUT_WIDTH; i=i+1) begin:msb_delay
        DELAY_UNIT #(
        	.P_DELAY_CYCLE 	( 4  ))
        u0_DELAY_UNIT_msb(
        	.i_clk   	( i_clk    ),
        	.i_rst_n 	( i_rst_n  ),
        	.i_in    	( i_msb[i]     ),
        	.o_delay 	( o_msb[i]  )
        );
    end
endgenerate

generate
    for(i=0; i<P_INPUT_WIDTH; i=i+1) begin:isb1_delay
        DELAY_UNIT #(
        	.P_DELAY_CYCLE 	( 3  ))
        u1_DELAY_UNIT_isb1(
        	.i_clk   	( i_clk    ),
        	.i_rst_n 	( i_rst_n  ),
        	.i_in    	( i_isb1[i]     ),
        	.o_delay 	( o_isb1[i]  )
        );
    end
endgenerate

generate
    for(i=0; i<P_INPUT_WIDTH; i=i+1) begin:isb2_delay
        DELAY_UNIT #(
        	.P_DELAY_CYCLE 	( 2  ))
        u2_DELAY_UNIT_isb2(
        	.i_clk   	( i_clk    ),
        	.i_rst_n 	( i_rst_n  ),
        	.i_in    	( i_isb2[i]     ),
        	.o_delay 	( o_isb2[i]  )
        );
    end
endgenerate

generate
    for(i=0; i<P_INPUT_WIDTH; i=i+1) begin:lsb_delay
        DELAY_UNIT #(
        	.P_DELAY_CYCLE 	( 1  ))
        u2_DELAY_UNIT_isb2(
        	.i_clk   	( i_clk    ),
        	.i_rst_n 	( i_rst_n  ),
        	.i_in    	( i_lsb[i]     ),
        	.o_delay 	( o_lsb[i]  )
        );
    end
endgenerate

endmodule