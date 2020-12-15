// `include "ctrl.v"
// `include "tik.v"
// `include "display_time.v"
// `include "display_alarm.v"
`include "param.v"

`ifdef DEBUG
`define FREQ 25000000
`else
`define FREQ 2
`endif 

module top #(
    parameter integer max_h = 12,
    parameter integer max_m = 23,
    parameter integer max_s = 41
) 
(
    CLOCK_50,
    KEY,
    SW,
    LEDR,
    HEX7,
    HEX6,
    HEX5,
    HEX4,
    HEX3,
    HEX2,
    HEX1,
    HEX0
);

input CLOCK_50;
input [7:0] KEY;
input [17:0] SW;
output [17:0] LEDR;
output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;


wire reset, en, clk;
assign reset = SW[0];
assign en = SW[1];

wire mod_choose, bit_choose, val_add, val_sub, val_set, clear;
assign mod_choose = ~KEY[0];
assign bit_choose = ~KEY[1];
assign val_add = ~KEY[2];
assign val_sub = ~KEY[3];
assign val_set = SW[2];
assign clear = SW[3];



tik #(.M(`FREQ), .BASE(50000000)) u_tik (
    .CLOCK_50(CLOCK_50),
    .reset(reset),
    .tik(clk)
);

/*
 * The core
 */

wire alarm_on, alarming;
wire [3:0] led;
wire [5:0] out_h, out_m, out_s;
assign {LEDR[17:16], LEDR[13:12]} = led;
ctrl #(.max_h(max_h), .max_m(max_m), .max_s(max_s)) 
    u_ctrl(
        .clk(clk),
        .reset(reset),
        .en(en),
        .alarm_on(alarm_on),
        .alarming(alarming),
        .mod_choose(mod_choose),
        .bit_choose(bit_choose),
        .val_add(val_add),
        .val_sub(val_sub),
        .val_set(val_set),
        .clear(clear),
        .out_h(out_h),
        .out_m(out_m),
        .out_s(out_s),
        .led(led),
        .debug_bit_now(LEDR[3]),
        .debug_mod_now(LEDR[2:1])
    );

/*
 * The display
 */

display_time u_display_time (
    .clk(clk),
    .reset(reset),
    .en(en),
    .h(out_h),
    .m(out_m),
    .s(out_s),
    .HEX7(HEX7),
    .HEX6(HEX6),
    .HEX5(HEX5),
    .HEX4(HEX4),
    .HEX3(HEX3),
    .HEX2(HEX2)
);

/*
 * The status of alarm
 */

display_alarm u_alarm_on (
    .clk(clk),
    .reset(reset),
    .en(alarm_on),
    .HEX(HEX0)
);

display_alarm u_alarming (
    .clk(clk),
    .reset(reset),
    .en(alarming),
    .HEX(HEX1)
);



endmodule