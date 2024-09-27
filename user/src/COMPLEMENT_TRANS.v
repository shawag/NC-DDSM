`include "Timescale.v"
module COMPLEMENT_TRANS #(
    parameter P_DATA_WIDTH = 4
)
(
    input    [P_DATA_WIDTH-1:0] i_num,
    output   [P_DATA_WIDTH-1:0] o_num_complement
);

assign o_num_complement = ~i_num + {{(P_DATA_WIDTH-1){1'b0}},1'b1};


endmodule