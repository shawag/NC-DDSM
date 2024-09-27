`include "Timescale.v"
module NC_NETWORK (
    input      i_clk,
    input      i_rst_n,

    input       i_quantize1,
    input       i_quantize2,
    input       i_quantize3,
    
    output [3:0]    o_network
);

wire    w_quantize1_2d;
wire    w_quantize2_1d;
wire  [3:0] w_add1;

reg     r_quantize3;

reg [3:0]   r_add1;


DELAY_UNIT #(
	.P_DELAY_CYCLE 	( 2  ))
u0_DELAY_UNIT(
	.i_clk   	( i_clk    ),
	.i_rst_n 	( i_rst_n  ),
	.i_in    	( i_quantize1     ),
	.o_delay 	( w_quantize1_2d  )
);

DELAY_UNIT #(
	.P_DELAY_CYCLE 	( 1  ))
u1_DELAY_UNIT(
	.i_clk   	( i_clk    ),
	.i_rst_n 	( i_rst_n  ),
	.i_in    	( i_quantize2     ),
	.o_delay 	( w_quantize2_1d  )
);


always @ (posedge i_clk or negedge i_rst_n) begin
    if(~i_rst_n)
        r_quantize3 <= 1'b0;
    else
        r_quantize3 <= i_quantize3;
end

always @ (posedge i_clk or negedge i_rst_n) begin
    if(~i_rst_n)
        r_add1 <= 4'd0;
    else
        r_add1 <= w_add1;
end

// outports wire
wire [3:0] 	o_sum;

ADDER_4_NCNET u0_ADDER_4_NCNET(
	.i_add1  	( {{3{1'b0}}, i_quantize3}),
	.i_add2  	( {{3{1'b0}}, w_quantize2_1d }),
	.i_miuns 	( {{3{1'b0}}, r_quantize3}  ),
	.o_sum   	( w_add1    )
);

ADDER_4_NCNET u1_ADDER_4_NCNET(
	.i_add1  	( w_add1),
	.i_add2  	( {{3{1'b0}}, w_quantize1_2d }),
	.i_miuns 	( r_add1  ),
	.o_sum   	( o_network    )
);

    
endmodule //NC_NETWORK`
