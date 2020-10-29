`include "top_module.v"

module test ();


reg clk;
reg reset;
reg updown;
wire C;
wire [7:0] Q;

always #1 clk = ~clk;

top_module u_bin(clk, reset, updown, C, Q);

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    reset = 1;
    updown = 1;
    #1; 
    reset = 0;
    #1 reset = 1;
    #2200;
    updown = 0;
    #2200;
    $finish;
end

    
endmodule