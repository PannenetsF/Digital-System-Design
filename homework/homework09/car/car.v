module car_led(clk, reset, emergency, left , right, brake, led_left, led_light);

/*
 * Assume that: (a,b,c) -> reg[0,1,2]
 */

// the special status of led on both side
`define all_on 3'b111
`define all_off 3'b000 

`define go_straight 0
`define go_left 1
`define go_right 2
`define go_staright_brake 
`define go_left_brake 3
`define go_right_brake 4
`define go_emergency 5

input clk, reset;
input emergency;
input left, right, brake;
output [2:0] led_left, led_right;

wire straight;
reg [2:0] led_left_reg, led_right_reg;

assign straight = (left == 0) && (right == 0);
assign led_left = led_left_reg;
assign led_right = led_right_reg;

reg [3:0] right_cnt, left_cnt;




endmodule