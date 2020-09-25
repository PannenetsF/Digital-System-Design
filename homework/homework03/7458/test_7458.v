`include "7458v1.v"
// `include "7458v2.v"

module test (

);

reg [5:0] p1;
reg [3:0] p2;

wire [1:0] py;



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

    .p1y(py[0]),
    .p2y(py[1])
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

    .p1y(py[0]),
    .p2y(py[1])
);
`endif  

reg [5:0] p1_test [99:0];
reg [3:0] p2_test [99:0];
reg [1:0] ans_test [99:0];

integer i;

initial begin
    $dumpfile("test_7458.vcd");
    $dumpvars;
    // p1 = 6'b101111;
    // p2 = 4'b1101;
    $readmemb("p1.in", p1_test);
    $readmemb("p2.in", p2_test);
    $readmemb("p.out", ans_test);
    for (i = 0; i < 100; i = i + 1) begin
        p1 = p1_test[i];
        p2 = p2_test[i];
        #1;
        if (py != ans_test[i]) begin
            $display("test failed at %d! in1: %x in2: %x out: %x, should: %x", i, p1, p2, py, ans_test[i]);
            $finish;
        end
    end
    $display("test passed");
    #1 $finish;
end



endmodule