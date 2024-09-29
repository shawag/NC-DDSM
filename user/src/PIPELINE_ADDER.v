`include "Timescale.v"
module PIPELINE_ADDER #(
    parameter P_DATA_WIDTH = 6
)
(  
    input               i_clk   ,
    input               i_rst_n ,
    input [P_DATA_WIDTH-1:0] i_a     ,
    input [P_DATA_WIDTH-1:0] i_b     ,
    input               i_cin   ,
    output [P_DATA_WIDTH-1:0] o_sum  ,
    output               o_cout   
);

localparam P_HALF_DATA_WIDTH = P_DATA_WIDTH/2;

wire cout_low;
wire  [P_HALF_DATA_WIDTH-1:0] sum_high;
wire  [P_HALF_DATA_WIDTH-1:0] sum_low;

reg [P_HALF_DATA_WIDTH-1:0]   r_sum_low;
reg [P_HALF_DATA_WIDTH-1:0]   r_a_high;
reg [P_HALF_DATA_WIDTH-1:0]   r_b_high;

always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n) begin
        r_sum_low <=  {P_HALF_DATA_WIDTH{1'b0}};
        r_a_high   <= {P_HALF_DATA_WIDTH{1'b0}};
        r_b_high   <= {P_HALF_DATA_WIDTH{1'b0}};
    end
    else begin
        r_sum_low <= sum_low;
        r_a_high   <= i_a[(P_DATA_WIDTH)-1:P_HALF_DATA_WIDTH];
        r_b_high   <= i_b[(P_DATA_WIDTH)-1:P_HALF_DATA_WIDTH];
    end
end

assign o_sum = {sum_high, r_sum_low};

ADDER_BASIC #(
	.P_DATA_WIDTH 	( P_HALF_DATA_WIDTH ))
u0_ADDER_BASIC(
	.i_a    	( i_a[P_HALF_DATA_WIDTH-1:0]),
	.i_b    	( i_b[P_HALF_DATA_WIDTH-1:0]),
	.i_cin  	( i_cin   ),
	.o_sum  	( sum_low),
	.o_cout 	( cout_low  )
);

ADDER_BASIC #(
	.P_DATA_WIDTH 	( P_HALF_DATA_WIDTH ))
u1_ADDER_BASIC(
	.i_a    	( r_a_high),
	.i_b    	( r_b_high),
	.i_cin  	( cout_low ),
	.o_sum  	( sum_high),
    .o_cout 	( o_cout   )
);


endmodule