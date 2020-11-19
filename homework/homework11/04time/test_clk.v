`include "clk.v"
module test (
);

reg clk;
reg [17:0] SW;
clks u(.CLOCK_50(clk), .SW(SW));

always #1 clk = ~clk;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    SW[17] = 1;
    clk = 0;
    #1 SW[17] = 0;
    #1000;
    $finish;
end
    
endmodule