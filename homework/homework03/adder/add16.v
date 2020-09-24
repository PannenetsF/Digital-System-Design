module add16 (
    a, b, cin, sum, cout
);

input [15:0] a, b;
input cin;
output [15:0] sum;
output cout;

assign {cout, sum} = a + b;
    
endmodule