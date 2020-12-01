// `include "cnt_rev.v"
// `include "light.v"
// `include "bcd.v"
// `include "seg_4.v"
// `include "param.v"
// `include "tik.v"


module top (
    CLOCK_50,
    SW,
    LEDR,
    HEX5,
    HEX4,
    HEX1,
    HEX0
);

/* 
 * user ports define 
 */

input CLOCK_50;
input [17:17] SW;
output [14:7] LEDR;
output [6:0] HEX5, HEX4, HEX1, HEX0;

/* 
 * clock and reset
 */

wire clk, reset;
// assign clk = CLOCK_50;
assign reset = SW[17];
tiks #(4, 50000000) u_clk(
    CLOCK_50, 
    reset,
    clk
);



/* 
 * the traffic lights' instantiation
 * NOTE: a port 'en' added to indicate that the lights is working.
 */
 
wire en;
wire [3:0] light_ew_rgyl, light_sn_rgyl;

traffic_light u_light(
    .clk(clk),
    .reset(reset),
    .light_ew_rgyl(light_ew_rgyl),
    .light_sn_rgyl(light_sn_rgyl),
    .on(en)
);


/* 
 * the timers' instantiation 
 * NOTE: the time has been set as parameters.
 */

wire [7:0] cnt_ew, cnt_sn;

cnt_rev #(
    .r_t(60),
    .y_t(5),
    .y_n_t(5),
    .g_t(40),
    .l_t(15),
    .init_state(`cnt_red),
    .init_time(60-3)
) u_cnt_ew(
    .clk(clk),
    .reset(reset),
    .en(en),
    .cnt(cnt_ew)
);

cnt_rev #(
    .r_t(70),
    .y_t(5),
    .y_n_t(5),
    .g_t(30),
    .l_t(15),
    .init_state(`cnt_green),
    .init_time(30-1)
) u_cnt_sn(
    .clk(clk),
    .reset(reset),
    .en(en),
    .cnt(cnt_sn)
);

/*
 * assignment of the port of the top
 * BCD, DEC_show are used.
 */

wire [3:0] bcd_ew_10, bcd_ew_1, bcd_sn_10, bcd_sn_1;

assign LEDR[14:11] = light_ew_rgyl;
assign LEDR[10:7] = light_sn_rgyl;

bcd u_bcd_ew(.bin(cnt_ew), .bcd_ten(bcd_ew_10), .bcd_one(bcd_ew_1));
bcd u_bcd_sn(.bin(cnt_sn), .bcd_ten(bcd_sn_10), .bcd_one(bcd_sn_1));

seg_4 u_seg(
    .SW({bcd_ew_10, bcd_ew_1, bcd_sn_10, bcd_sn_1}),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX4),
    .HEX3(HEX5)
);

    
endmodule