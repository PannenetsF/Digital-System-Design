// `include "moore.v"

module top (
    SW,
    KEY,
    LEDR
);

input [17:16] SW;
input [1:1] KEY;
output [10:10] LEDR;
    
wire clk, reset, data, res;
assign reset = SW[17];
assign clk = KEY[1];
assign data = SW[16];
assign LEDR[10] = res;

seqdet_moore u_moore(
    .clk(clk),
    .reset(reset),
    .data(data),
    .res(res)
);

endmodule