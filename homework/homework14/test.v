`define DEBUG 0
`include "top.v"

module test (
);


reg CLOCK_50;
reg [7:0] KEY;
reg [17:0] SW;
wire [17:0] LEDR;
wire [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

top u_top
(
    CLOCK_50,
    KEY,
    SW,
    LEDR,
    HEX7,
    HEX6,
    HEX5,
    HEX4,
    HEX3,
    HEX2,
    HEX1,
    HEX0
);

always #1 CLOCK_50 = ~CLOCK_50;


`define CLEAR SW[3] = 1; #3 SW[3] = 0; #5;
`define MOD_CHOOSE KEY[0] = 0; #3 KEY[0] = 1; #5;
`define BIT_CHOOSE KEY[1] = 0; #3 KEY[1] = 1;#5;
`define VAL_ADD KEY[2] = 0; #3 KEY[2] = 1;#5;
`define VAL_SUB KEY[3] = 0; #3 KEY[3] = 1;#5;
`define VAL_SET SW[2] = 1; #3 SW[2] = 0;#5;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    $display(`FREQ);
    // display simple 
    KEY = ~0;
    SW = 0;
    CLOCK_50 = 0;
    SW[0] = 1;
    SW[1] = 1;
    #2 SW[0] = 0;
    #100;
    // display close the alarm
    `CLEAR
    #100;
    // display the mod change 
    `MOD_CHOOSE
    `MOD_CHOOSE
    `MOD_CHOOSE
    `MOD_CHOOSE
    // display the stop watch 
    `MOD_CHOOSE
    `MOD_CHOOSE
    `VAL_SET
    `VAL_ADD
    #20;
    `VAL_ADD
    #20;
    `VAL_SET
    // test set the alarm to 8:03
    `MOD_CHOOSE
    `VAL_ADD
    `VAL_SET
    // test set time 
    `MOD_CHOOSE
    `MOD_CHOOSE
    `VAL_ADD 
    `BIT_CHOOSE
    `VAL_SUB
    `VAL_SET
    #500;
    $finish;
end


endmodule