`include "dec.v"
`include "bcd.v"
`include "clk.v"

module top (
    CLOCK_50,
    SW,
    HEX2,
    HEX1,
    HEX0
);


input CLOCK_50;
input [17:0] SW;

output [6:0] HEX2, HEX1, HEX0;

wire [3:0] bcd_100, bcd_10, bcd_1;
wire tik;2

clk #(.M(1)) u_clk(
    .CLOCK_50(CLOCK_50),
    .SW(SW),
    .tik(tik)
);

bcd u_bcd(tik, bcd_100, bcd_10, bcd_1);
dec u_100(bcd_100, HEX2);
dec u_10(bcd_10, HEX1);
dec u_1(bcd_1, HEX0);

    
endmodule