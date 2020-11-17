`include "shift.v"

module test (

);


reg [17:0] SW;
reg [0:0] KEY;
wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

shift u(SW,
    KEY,
    HEX7,
    HEX6,
    HEX5,
    HEX4,
    HEX3,
    HEX2,
    HEX1,
    HEX0);

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    SW = 0;
    KEY = 0;
    SW[7:0] = 12;
    SW[16:15] = 3;
    #1 KEY = 1;
    #1 KEY = 0;
    SW[16:15] = 2;
    #1 KEY = 1;
    #1 KEY = 0;
    $finish; 
end

endmodule