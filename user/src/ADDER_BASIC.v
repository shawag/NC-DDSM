`include "Timescale.v"
module ADDER_BASIC #(
    parameter P_DATA_WIDTH = 3
)(
    input [P_DATA_WIDTH-1:0] i_a ,
    input [P_DATA_WIDTH-1:0] i_b ,
    input                    i_cin ,  

    output [P_DATA_WIDTH-1:0]  o_sum ,
    output                     o_cout
);

assign {o_cout, o_sum} = i_a + i_b + i_cin;

endmodule