`include "byteInv.v"

module test (

);

reg [31:0] a;
wire [31:0] b;

byteInv u_byte(
    .in(a),
    .out(b)
);

reg [31:0] in_test [99:0];
reg [31:0] out_test [99:0];

integer i;

initial begin
    $dumpfile("test_byte.vcd");
    $dumpvars;
    $readmemh("byteInv.in", in_test);
    $readmemh("byteInv.out", out_test);
    for (i = 0; i < 100; i = 1 + i) begin
        a = in_test[i];
        #1;
        if (b != out_test[i]) begin
            $display("test failed at %d! in: %08x, out: %08x, should: %08x", i, a, b, out_test[i]);
            // $finish;
        end
    end
    #1;
    $display("test passed");
    $finish;
end

endmodule