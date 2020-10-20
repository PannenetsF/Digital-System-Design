`include "alu.v"

module test (
);

reg [1:0] op;
reg [3:0] a;
reg [3:0] b;
wire [3:0] res;

top_module u_alu(
    .op(op),
    .a(a),
    .b(b),
    .res(res)
);

integer i;
reg [3:0] a_r [99:0];
reg [3:0] b_r [99:0];
reg [3:0] op_r [99:0];
reg [3:0] ans_r [99:0];

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    $readmemh("a.ram", a_r);
    $readmemh("b.ram", b_r);
    $readmemh("op.ram", op_r);
    $readmemh("ans.ram", ans_r);
    for (i = 0; i < 100; i = 1 + i) begin
        a = a_r[i];
        b = b_r[i];
        op = op_r[i];
        #1;
        if (res != ans_r[i]) begin
            $display("failed at a: %x, b: %x, op: %x, ans: %x", a, b, op, res);
        end
    end
    $display("passed");
    $finish;
end
    
endmodule