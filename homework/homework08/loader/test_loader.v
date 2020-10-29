`include "loader.v"

module test (
);

reg clk;
reg reset;
reg set;
reg load;
reg [3:0] D;
wire [3:0] Q;

top_module u_reg(
    clk,
    reset,
    set,
    load,
    D,
    Q
);

always #1 clk = ~clk;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    reset = 0;
    set = 0;
    load = 0;
    D = 0;
    #1 reset = 1;
    #2 reset = 0;
    #2 set = 1;
    #2 set = 0;
    #2 D = 10;
    #2 D = 6;
    #2 load = 1;
    #2 D = 7;
    #2 load = 0;
    #2 $finish;
end
    
endmodule