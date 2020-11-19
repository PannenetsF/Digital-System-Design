`include "tik.v"
`timescale 1ns/1ns 

module test (

);
reg clk;
reg reset;
wire tik;
always #1 clk = ~clk;


// 50M -> 5M 
tik #(.M(5000000)) u(.CLOCK_50(clk), .reset(reset), .tik(tik));

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    reset = 1;
    #1 reset = 0;
    #200;
    $finish;
end


endmodule