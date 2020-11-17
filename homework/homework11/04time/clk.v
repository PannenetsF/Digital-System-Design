// `include "dec.v"
// `include "bcd.v"

module clk #(
    parameter integer M = 5,  // 10M - > 5 Hz
    parameter integer R = 59
)  
(
    CLOCK_50,
    SW,
    tik
);

parameter CNT_MAX = 50000000/M/2 - 1;

input CLOCK_50;
input [17:0] SW;
// output [6:0] HEX2, HEX1, HEX0;
// output [3:0] bcd_100, bcd_10, bcd_1;
output tik;


wire reset;
assign reset = SW[17];
reg [31:0] cnt;
reg tik;


always @(posedge CLOCK_50 or posedge reset) begin
    if (reset) begin
        cnt <= 0;
        tik <= 0;
    end
    else begin
        if (cnt != CNT_MAX) begin
            cnt <= cnt + 1;
        end
        else begin
            cnt <= 0;
            tik <= ~tik;
        end
    end
end

endmodule