 `include "param.v"
// `include "tik.v"
// `include "shift.v"
// `include "seg_4.v"

module show (
    SW,
    LEDR,
    CLOCK_50,
    HEX3,
    HEX2,
    HEX1,
    HEX0
);

// io and clk/reset
input [17:17] SW;
input CLOCK_50;
output [10:7] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3;

wire clk, rst;
assign clk = CLOCK_50;
assign reset = SW[17];

// the clk of 2Hz
wire clk_2;
tiks #(.M(25000000), .BASE(50000000)) u_tik(.CLOCK_50(CLOCK_50), .reset(reset), .tik(clk_2));


// cyclic shift register
wire [43:0] reg_out; 
shift #(.N(11), .INIT({`H, `E, `L, `L, `O, `SP, `B, `U, `A, `A, `SP}))  u_shift(.clk(clk_2), .reset(reset), .out(reg_out));

// show the segments
wire [15:0] to_show;
assign to_show = reg_out[43:28];
seg_4 u_seg(to_show, HEX3, HEX2, HEX1, HEX0);

// light the leds 
assign LEDR[7] = (to_show[3:0] == (`H));
assign LEDR[8] = (to_show[7:4]  == (`H));
assign LEDR[9] = (to_show[11:8]  == (`H));
assign LEDR[10] = (to_show[15:12]  == (`H));

endmodule