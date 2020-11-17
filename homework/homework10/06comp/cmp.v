module cmp (
    SW,
    HEX0,
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    HEX6,
    HEX7
);

input [17:0] SW;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

wire [5:0] data1, data2;
wire [6:0] ans;
// The thounsand of answer must be zero, for the answer get 7 bit (128) .
wire [3:0] data1_ten, data1_one, data2_ten, data2_one, ans_thou, ans_hun, ans_ten, ans_one;

assign data1 = SW[12:7];
assign data2 = SW[5:0];

assign ans = (SW[17]) ? (data1 + data2) : (data1 - data2);

assign data1_one = data1 % 10;
assign data1_ten = data1 / 10;
assign data2_one = data2 % 10;
assign data2_ten = data2 / 10;
assign ans_thou = 0;
assign ans_hun = ans / 100;
assign ans_ten = (ans % 100) / 10;
assign ans_one = ans % 10;

dec u_d1_1(data1_ten, HEX7);
dec u_d1_2(data1_one, HEX6);
dec u_d2_1(data2_ten, HEX5);
dec u_d2_2(data2_one, HEX4);
dec u_ans_1(ans_thou, HEX3);
dec u_ans_2(ans_hun, HEX2);
dec u_ans_3(ans_ten, HEX1);
dec u_ans_4(ans_one, HEX0);


endmodule