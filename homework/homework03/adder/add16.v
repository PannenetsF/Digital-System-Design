`define addbit 16
`define Module_16 0


module add16 (
    a, b, cin, sum, cout
);

input [15:0] a, b;
input cin;
output [15:0] sum;
output cout;

assign {cout, sum} = a + b + cin;


initial begin
    $display(`addbit);
end
    
endmodule