// `include "dec.v"
// `include "bcd.v"
// `include "tik.v"
// `include "cnt.v"

module clk #(
    parameter integer M = 5,  // 10M - > 5 Hz
    parameter integer R = 60
)  
(
    CLOCK_50,
    SW,
    HEX2,
    HEX1,
    HEX0
);


// ports
input CLOCK_50;
input [17:0] SW;
output [6:0] HEX2, HEX1, HEX0;

// assign reset 
wire reset;
assign reset = SW[17];

// for module 'tik'
wire tik;
tiks #(.M(1)) u_tik(.CLOCK_50(CLOCK_50), .reset(reset), .tik(tik));

// for module 'cnt'
wire [7:0] sum;
cnt #(.MAX(R), .BITS(8)) u_cnt(.reset(reset), .to_cnt(tik), .sum(sum));

// for module 'bcd'
wire [3:0] bcd_1, bcd_10, bcd_100;
bcd u_bcd(sum, bcd_100, bcd_10, bcd_1);

// for module 'dec'
dec u_100(bcd_100, HEX2);
dec u_10(bcd_10, HEX1);
dec u_1(bcd_1, HEX0);

endmodule