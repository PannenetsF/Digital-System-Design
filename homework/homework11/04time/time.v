`include "clk.v"
`include "bcd.v"
`include "dec_4.v"

module timer (
    // SW[17] reset, ALL -> 0
    // SW[16-11] min 
    // SW[10-5] sec
    // SW[4-0] m sec 
    SW,
    // KEY[0] load, ALL -> Preset
    KEY,
    CLOCK_50,
    HEX7,
    HEX6,
    HEX5,
    HEX4,
    HEX3,
    HEX2,
    HEX1,
    HEX0
);


input CLOCK_50;
input [17:0] SW;
input [0:0] KEY;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

reg [7:0] min, sec, msec;
wire reset;
wire [3:0] min_100, min_10, min_1, sec_100, sec_10, sec_1, msec_100, msec_10, msec_1;
assign reset = SW[17];


clk #(1000) u_clk(.CLOCK_50(CLOCK_50), .SW(SW), .tik(tik));
bcd u_min(
    .bin(min),
    .bcd_hun(min_100),
    .bcd_ten(min_10),
    .bcd_one(min_1)
);
bcd u_sec(
    .bin(sec),
    .bcd_hun(sec_100),
    .bcd_ten(sec_10),
    .bcd_one(sec_1)
);
bcd u_msec(
    .bin(msec),
    .bcd_hun(msec_100),
    .bcd_ten(msec_10),
    .bcd_one(msec_1)
);

dec_4 u_min_sec_show(
    .SW({min_10, min_1, sec_10, sec_1}),
    .HEX3(HEX7),
    .HEX2(HEX6),
    .HEX1(HEX5),
    .HEX0(HEX4)
);


dec_4 u_msec_show(
    .SW({4'hf, msec_100, msec_10, msec_1}),
    .HEX3(HEX3),
    .HEX2(HEX2),
    .HEX1(HEX1),
    .HEX0(HEX0)
);


always @(posedge tik or posedge reset) begin
    if (reset) begin
        min <= 0;
        sec <= 0;
        msec <= 0;
    end
    else begin
        if (msec == 999) begin
            msec <= 0;
            if (sec == 59) begin
                sec <= 0;
                if (min == 59) begin
                    min <= 0;
                end
                else begin
                    min <= min + 1;
                end
            end
            else begin
                sec <= sec + 1;
            end
        end
        else begin
            msec <= msec + 1;
        end
    end
end
    


endmodule