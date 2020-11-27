`include "tik.v"
`include "bcd.v"

module texi (
    CLOCK_50,
    SW,
    HEX3,
    HEX2,
    HEX1,
    HEX0
);

input CLOCK_50;
input [17:16] SW;
output [6:0] HEX3, HEX2, HEX1, HEX0;

wire clk, reset, en;
assign reset = SW[17];
assign en = SW[16];
tiks #(.M(5), .BASE(50000000)) u_tik(
    .CLOCK_50(CLOCK_50),
    .reset(reset),
    .tik(clk)
);

reg [9:0] cost, distance;
reg [3:0] cnt;
wire [9:0] out_cost, out_distance;
assign out_cost = en ? cost : 0;
assign out_distance = en ? distance : 0;


wire [3:0] bcd_cost_10, bcd_cost_1, bcd_dis_10, bcd_dis_1;

bcd u_cost(
    .bin(out_cost),
    .bcd_ten(bcd_cost_10),
    .bcd_one(bcd_cost_1)
);

bcd u_dist(
    .bin(out_distance),
    .bcd_ten(bcd_dis_10),
    .bcd_one(bcd_dis_1)
);

wire in_0_3, in_3_6, in_6_10, in_10;
wire [3:0] flag;
assign in_0_3 = (distance < 3);
assign in_3_6 = (distance >= 3) && (distance < 6);
assign in_6_10 = (distance >= 6) && (distance < 10);
assign in_10 = (distance >= 10);
assign flag = {in_10, in_6_10, in_3_6, in_0_3};

always @(posedge clk or posedge reset) begin
    if (reset | !en) begin
        cost <= 10;
        distance <= 0;
        cnt <= 0;
    end 
    else begin
        if (cnt == 10) begin
            cnt <= 0;
            distance <= distance + 1;
            case (flag)
                4'b0001 : cost <= cost;
                4'b0010 : cost <= cost + 2;
                4'b0100 : cost <= cost + 3;
                4'b1000 : cost <= cost + 5;
                default: cost <= cost;
            endcase
        end
        else begin
            cnt <= cnt + 1;
        end
    end
end
    
endmodule