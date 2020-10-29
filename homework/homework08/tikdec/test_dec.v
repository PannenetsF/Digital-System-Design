`include "dec.v"

module test (

);

reg clk;
reg reset;
wire C;
wire [3:0] Q;

top_module u_cnt(clk, reset, C, Q);

always #1 clk = ~clk;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    reset = 0;
    #2 reset = 1;
    #1 reset = 0;
    #100;
    $finish;
end
    
endmodule