`include "light.v"
`timescale 1ns/1ns
module test (

);

reg clk, reset;
wire  [3:0] light_ew_rgyl;
wire [3:0] light_sn_rgyl;

traffic_light u(
    clk, reset, light_ew_rgyl, light_sn_rgyl
);

always #5 clk = ~clk;

integer i;
reg [3:0] sta;
reg [7:0] cnt;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    #1 reset = 1;
    #1 reset = 0;
    sta = u.status;
    cnt = 0;
    for (i = 0; i < 20; i = i) begin
        @(posedge clk) begin
            cnt = cnt + 1; 
        end
        if (u.status != sta) begin
            $display("state: %d, last: %d", sta, cnt); 
            sta = u.status;
            cnt = 0;
            i = i + 1;
        end
    end    
    #20;
    $finish;
end

endmodule
