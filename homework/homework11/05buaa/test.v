`include "show.v"
module test (
);

reg clk;
reg [17:17] SW;
show u(.CLOCK_50(clk), .SW(SW));

always #1 clk = ~clk;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    $displayb({`H, `E, `L, `L, `O, `SP, `B, `U, `A, `A, `SP});
    SW[17] = 1;
    clk = 0;
    #1 SW[17] = 0;
    #1000;
    $finish;
end
    
endmodule