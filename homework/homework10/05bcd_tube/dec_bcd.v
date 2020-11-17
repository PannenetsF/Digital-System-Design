module dec_bcd (
    SW,
    HEX2,
    HEX1,
    HEX0
);
    
input [7:0] SW;
output [3:0] HEX0;
output [3:0] HEX1;
output [3:0] HEX2;

wire [3:0] HEX0_in, HEX1_in, HEX2_i;

bcd u(SW, HEX2_in, HEX1_in, HEX0_in);
dec_4 u_d(
    .SW({4'b0000, HEX2_in, HEX1_in, HEX0_in}),
    .HEX2(HEX2),
    .HEX1(HEX1),
    .HEX0(HEX0)
);

endmodule