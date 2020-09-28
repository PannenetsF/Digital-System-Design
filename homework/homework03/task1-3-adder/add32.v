`include "add16.v"
`define byname 0
// `define byport 0
`define addbit 32
`define Module_32 0

module add32 (
    a, b, cin, sum, cout
);
    

input [31:0] a, b;
input cin;
output [31:0] sum;
output cout;

wire [15:0] ah, al, bh, bl, sh, sl;
wire cout_l;

assign {ah, al} = a;
assign {bh, bl} = b;
assign sum = {sh, sl};

`ifdef byport
add16 u_l(
    .a(al),
    .b(bl),
    .cin(cin),
    .sum(sl),
    .cout(cout_l)
);

add16 u_h(
    .a(ah),
    .b(bh),
    .cin(cout_l),
    .sum(sh),
    .cout(cout)
);
`endif


`ifdef byname
add16 u_l(
    al,
    bl,
    cin,
    sl,
    cout_l
);

add16 u_h(
    ah,
    bh,
    cout_l,
    sh,
    cout
);
`endif


endmodule