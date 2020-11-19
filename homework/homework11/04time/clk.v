// `include "dec_4.v"
// `include "bcd.v"
// `include "tik.v"
// `include "cnt.v"

module clks #(
    parameter integer M = 5,  // 10M - > 5 Hz
    parameter integer R = 60
)  
(
    CLOCK_50,
    SW,
    HEX7,
    HEX6,
    HEX5,
    HEX4,
    HEX3,
    HEX2,
    HEX1,
    HEX0
);


// ports
input CLOCK_50;
input [17:0] SW;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

// assign reset 
wire reset;
assign reset = SW[17];

// for module 'tik' to count for m-sec, sec, min.
wire tik_ms, tik_s, tik_min;
tiks #(.M(1000), .BASE(50000000)) u_tik_ms(.CLOCK_50(CLOCK_50), .reset(reset), .tik(tik_ms));
// tiks #(.M(1), .BASE(4)) u_tik_s(.CLOCK_50(tik_ms), .reset(reset), .tik(tik_s));
// tiks #(.M(1), .BASE(4)) u_tik_min(.CLOCK_50(tik_s), .reset(reset), .tik(tik_min));


// for module 'cnt'
// wire [31:0] sum_ms, sum_s, sum_min;
// cnt #(.MAX(1000), .BITS(10)) u_cnt_ms(.reset(reset), .to_cnt(tik_ms), .sum(sum_ms)); // 4 ms 
// cnt #(.MAX(16), .BITS(10)) u_cnt_s(.reset(reset), .to_cnt(tik_ms), .sum(sum_s)); // 
// cnt #(.MAX(64), .BITS(10)) u_cnt_min(.reset(reset), .to_cnt(tik_ms), .sum(sum_min));
reg [9:0] str_ms, str_s, str_min;
always @(posedge tik_ms or posedge reset) begin
    if (reset) begin
        str_min <= 0;
        str_s <= 0;
        str_ms <= 0;
    end
    else begin
        if (str_ms != 999) begin
            str_ms <= str_ms + 1;
        end
        else begin
            str_ms <= 0;
            if (str_s != 9) begin
                str_s <= str_s + 1;
            end
            else begin
                str_s <= 0;
                if (str_min != 9) begin
                    str_min <= str_min + 1;
                end
                else begin
                    str_min <= 0;
                end
            end
        end
    end
end


// for module 'bcd'
wire [3:0] bcd_ms_1, bcd_ms_10, bcd_ms_100;
wire [3:0] bcd_s_1, bcd_s_10, bcd_s_100;
wire [3:0] bcd_min_1, bcd_min_10, bcd_min_100;
bcd u_bcd_ms(str_ms, bcd_ms_100, bcd_ms_10, bcd_ms_1);
bcd u_bcd_s(str_s, bcd_s_100, bcd_s_10, bcd_s_1);
bcd u_bcd_min(str_min, bcd_min_100, bcd_min_10, bcd_min_1);

// for module 'dec'
dec_4 u_dec_ms(.SW({4'b1111, bcd_ms_100, bcd_ms_10, bcd_ms_1}), .HEX3(HEX3), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0));
dec_4 u_dec_min_s(.SW({bcd_min_10, bcd_min_1,bcd_s_10, bcd_s_1}), .HEX3(HEX7), .HEX2(HEX6), .HEX1(HEX5), .HEX0(HEX4));


endmodule