`include "seg.v"

module seg_4 (
    SW,
    HEX3,
    HEX2,
    HEX1,
    HEX0
);

input [15:0] SW;
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;

seg u1(SW[3:0], HEX0);
seg u2(SW[7:4], HEX1);
seg u3(SW[11:8], HEX2);
seg u4(SW[15:12], HEX3);

endmodule
