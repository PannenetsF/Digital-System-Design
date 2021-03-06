`include "cnt_rev.v"
`include "light.v"
`include "bcd.v"

module test (
);

reg clk, reset;
wire[3:0] light_ew_rgyl, light_sn_rgyl;
wire [7:0] cnt_ew, cnt_sn;
wire en;

traffic_light u_light(
    .clk(clk),
    .reset(reset),
    .light_ew_rgyl(light_ew_rgyl),
    .light_sn_rgyl(light_sn_rgyl),
    .on(en)
);


// ew
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

// sn
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



wire [3:0] bcd_ew_10, bcd_ew_1, bcd_sn_10, bcd_sn_1;

// assign LEDR[14:11] = light_ew_rgyl;
// assign LEDR[10:7] = light_sn_rgyl;

bcd u_bcd_ew(.bin(cnt_ew), .bcd_ten(bcd_ew_10), .bcd_one(bcd_ew_1));
bcd u_bcd_sn(.bin(cnt_sn), .bcd_ten(bcd_sn_10), .bcd_one(bcd_sn_1));

always #1 clk = ~clk;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    reset = 1;
    // en = 0;
    #2 reset = 0;
    // en = 1;
    #800;
    $finish;
end
    
endmodule