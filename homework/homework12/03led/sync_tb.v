`include "sync.v"
module test (
);

reg clk, reset, read, sig;
wire valid;

 sync u(
    clk,
    reset,
    read,
    sig,
    valid
);

always #5 clk = ~clk;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    reset = 0;
    read = 0;
    #1 reset = 1;
    #1 reset = 0;
    #23 sig = 1;
    #2 sig = 0;
    #30 read = 1;
    #10 read = 0;
    #200 $finish;
end
    
endmodule