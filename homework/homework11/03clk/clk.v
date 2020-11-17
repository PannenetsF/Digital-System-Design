`include "dec.v"
`include "bcd.v"

module clk #(
    parameter integer M = 5,  // 10M - > 5 Hz
    parameter integer R = 59
)  
(
    CLOCK_50,
    SW,
    HEX2,
    HEX1,
    HEX0
);

parameter CNT_MAX = 50000000/M/2 - 1;

input CLOCK_50;
input [17:0] SW;
output [6:0] HEX2, HEX1, HEX0;

wire reset;
assign reset = SW[17];
reg [31:0] cnt;
reg [7:0] tik;

wire [3:0] bcd_100, bcd_10, bcd_1;

bcd u_bcd(tik, bcd_100, bcd_10, bcd_1);
dec u_100(bcd_100, HEX2);
dec u_10(bcd_10, HEX1);
dec u_1(bcd_1, HEX0);

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
            if (tik != R) begin
                tik <= tik + 1;
            end
            else begin
                tik <= 0;
            end
        end
    end
end

endmodule