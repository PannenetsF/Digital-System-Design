// `include "7458v1.v"
`include "7458v2.v"

module test (

);

reg [5:0] p1;
reg [3:0] p2;

wire p2y, p1y;



`ifdef Module_v1
_7458v1 u_7458(
    .p1a(p1[0]),
    .p1b(p1[1]),
    .p1c(p1[2]),
    .p1d(p1[3]),
    .p1e(p1[4]),
    .p1f(p1[5]),

    .p2a(p2[0]),
    .p2b(p2[1]),
    .p2c(p2[2]),
    .p2d(p2[3]),

    .p1y(p1y),
    .p2y(p2y)
);
`else 
_7458v2 u_7458(
    .p1a(p1[0]),
    .p1b(p1[1]),
    .p1c(p1[2]),
    .p1d(p1[3]),
    .p1e(p1[4]),
    .p1f(p1[5]),

    .p2a(p2[0]),
    .p2b(p2[1]),
    .p2c(p2[2]),
    .p2d(p2[3]),

    .p1y(p1y),
    .p2y(p2y)
);
`endif  

reg [5:0] p1_test [99:0];
reg [3:0] p2_test [99:0];

initial begin
    $dumpfile("test_7458.vcd");
    $dumpvars;
    p1 = 6'b101111;
    p2 = 4'b1101;
    #1 $finish;
end



endmodule