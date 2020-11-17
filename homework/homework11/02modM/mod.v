// `include "dec.v"
module mod #(parameter integer M = 10)  
(
    SW,
    KEY,
    HEX2,
    HEX1,
    HEX0
);


input [17:0] SW;
input [0:0] KEY;
output [6:0] HEX0, HEX1, HEX2;

wire reset;
wire clk;
wire en;

assign reset = SW[17];
assign clk = KEY[0];
assign en = SW[16];

reg [7:0] cnt;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt <= 0;
    end
    else begin
        if (en) begin
            cnt <= (cnt + 1) % M;
        end
        else begin
            cnt <= cnt;
        end
    end
end

dec u_0(cnt % 10, HEX0);
dec u_1((cnt % 100) / 10, HEX1);
dec u_2(cnt / 100, HEX2);

endmodule