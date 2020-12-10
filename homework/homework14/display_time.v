// `include "bcd.v"
// `include "dec.v"

module display_time (
    clk,
    reset,
    en,
    h,
    m,
    s,
    HEX7,
    HEX6,
    HEX5,
    HEX4,
    HEX3,
    HEX2
);

input clk, reset, en;
input [5:0] h, m, s;
output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2;

wire [3:0] h_10, h_1, m_10, m_1, s_10, s_1;
bcd bcd_h(.bin(h), .bcd_ten(h_10), .bcd_one(h_1));
bcd bcd_m(.bin(m), .bcd_ten(m_10), .bcd_one(m_1));
bcd bcd_s(.bin(s), .bcd_ten(s_10), .bcd_one(s_1));

dec dec_h_10(.SW(h_10), .HEX0(HEX7));
dec dec_h_1(.SW(h_1), .HEX0(HEX6));
dec dec_m_10(.SW(m_10), .HEX0(HEX5));
dec dec_m_1(.SW(m_1), .HEX0(HEX4));
dec dec_s_10(.SW(s_10), .HEX0(HEX3));
dec dec_s_1(.SW(s_1), .HEX0(HEX2));

endmodule