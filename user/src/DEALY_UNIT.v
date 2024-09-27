`include "Timescale.v"
module DELAY_UNIT #(
    parameter P_DELAY_CYCLE = 2
)
(
    input      i_clk,
    input      i_rst_n,

    input    i_in,
    output   o_delay
);


reg [P_DELAY_CYCLE-1:0] ro_delay;
assign o_delay = ro_delay[P_DELAY_CYCLE-1];

always @(posedge i_clk or negedge i_rst_n) begin
    if(~i_rst_n)
        ro_delay <= 1'b0;
    else if(P_DELAY_CYCLE >= 2)
        ro_delay <= {ro_delay[P_DELAY_CYCLE-2:0], i_in};
    else
        ro_delay <= i_in;

end
    
endmodule //DELAY_UNIT
