`include "clk.v"
`timescale 1ns/1ns 

module test (

);
reg clk;

always #1 clk = ~clk;

clk #(.M(10000000)) u(.CLOCK_50(clk));

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    #200;
    $finish;
end


endmodule