`include "moore.v"

module test (
);

reg clk, reset, data;
wire res;

seqdet_moore u(
    clk,
    reset,
    data,
    res
);

always #1 clk = ~clk;

integer i;
reg all [19:0];

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    reset = 1;
    clk = 0;
    #1 reset = 0;
    #1;
    $readmemb("data.bin", all);
    for (i = 0; i < 20; i = i + 1) begin
        @( posedge clk);
        data = all[i];
    end
    #2 $finish;
end
    
endmodule