`include "led.v"

module test (

);

reg CLOCK_50, KEY;
reg [1:0] SW;
wire [9:0] LEDR;

led u(
    CLOCK_50,
    SW,
    KEY,
    LEDR
);

always #1 CLOCK_50 = ~CLOCK_50;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    CLOCK_50 = 0;
    SW[17] = 0;
    KEY = 0;
    #1 SW[1] = 1;
    #1 SW[1] = 0;
    SW[0] = 1;
    #60; 
    KEY = 1;
    #1 KEY = 0;
    #60; 
    KEY = 1;
    #1 KEY = 0;
    #60; 
    KEY = 1;
    #1 KEY = 0;
    #200 $finish;
end

endmodule