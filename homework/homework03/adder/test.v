`include "add16.v"
// `include "add32.v"

module test (
);

reg [`addbit-1:0] a, b;
reg cin;
wire [`addbit:0] ans;

`ifdef Module_32 

add32 u_add(
    .a(a),
    .b(b),
    .cin(cin),
    .cout(ans[`addbit]),
    .sum(ans[`addbit - 1 : 0])
);

`else


add16 u_add(
    .a(a),
    .b(b),
    .cin(cin),
    .cout(ans[`addbit]),
    .sum(ans[`addbit - 1 : 0])
);

`endif 

reg [`addbit-1:0] a_test[99:0];
reg [`addbit-1:0] b_test[99:0];
reg cin_test [99:0];
reg [`addbit:0] ans_test[99:0];

integer i;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;    
    $readmemb("add1.in", a_test);
    $readmemb("add2.in", b_test);
    $readmemb("cin.in", cin_test);
    $readmemb("ans.out", ans_test);

    for (i = 0; i < 100; i = i + 1) begin
        #1;
        a = a_test[i];
        b = b_test[i];
        cin = cin_test[i];
        #1;
        if (ans != ans_test[i]) begin
            $display("test failed at %d! in1: %x in2: %x, cin: %x, out: %x, should: %x", i, a, b, cin, ans, ans_test[i]);
            $finish;
        end
    end
    $display("test passed");
    $finish;
end

endmodule