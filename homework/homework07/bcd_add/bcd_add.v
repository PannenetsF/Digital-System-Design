`include "bcd.v"

module top_module (
    bcd,
    res
);

input [11:0] bcd;
output [11:0] res;

reg [11:0] res_r;
assign res = res_r;


always @(bcd) begin
    res_r = bcd;
    res_r[3:0] = res_r[3:0] + 1;
    if (res_r[3:0] > 9) begin
        res_r[3:0] = 0;
        res_r[7:4] = res_r[7:4] + 1;
    end
    if (res_r[7:4] > 9) begin
        res_r[7:4] = 0;
        res_r[11:8] = res_r[11:8] + 1;
    end
    
end
    
endmodule