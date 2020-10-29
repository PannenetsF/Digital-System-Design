`include "top_module.v"
module test (

);

reg clk;
reg clk3;
reg rst;
wire clkA;
wire clkB;

top_module u_clk(clk, clkA, clkB, rst);

always #1 clk = ~clk;
// always #6 clk3 = ~clk3;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    // clk3 = 0;
    rst = 0;
    #3 rst = 1;
    #3 rst = 0;
    #100;
    $finish;
end
    
endmodule