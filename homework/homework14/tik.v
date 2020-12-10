module tik #(
    parameter integer M = 5,  // 10M - > 5 Hz,
    parameter integer BASE = 50000000
)  
(
    CLOCK_50,
    reset,
    tik
);

parameter CNT_MAX = BASE/M/2 - 1;

input CLOCK_50;
input reset;
output reg tik;
reg [31:0] tmp;

reg [31:0] cnt;

always @(posedge CLOCK_50 or posedge reset) begin
    if (reset) begin
        cnt <= 0;
        tik <= 0;
        tmp <= CNT_MAX;
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