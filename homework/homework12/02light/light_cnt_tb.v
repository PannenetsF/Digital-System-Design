`include "cnt_rev.v"
`include "light.v"

module test (
);

reg clk, reset, en;
wire[3:0] light_ew_rgyl, light_sn_rgyl;
wire [7:0] cnt;

traffic_light u_light(
    .clk(clk),
    .reset(reset),
    .light_ew_rgyl(light_ew_rgyl),
    .light_sn_rgyl(light_sn_rgyl)
);

cnt_rev #(
    .r_t(60),
    .y_t(5),
    .g_t(40),
    .l_t(15)
) u_cnt(
    .clk(clk),
    .reset(reset),
    .en(en),
    .light_rgyl(light_ew_rgyl),
    .cnt(cnt)
);

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