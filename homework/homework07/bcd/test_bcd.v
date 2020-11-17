`include "bcd.v"

module test (

);

reg [9:0] bin;
wire [3:0] bcd_hun;
wire [3:0] bcd_ten;
wire [3:0] bcd_one;

top_module u(bin, bcd_hun, bcd_ten, bcd_one);

integer i;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    for (i = 0; i < 1000; i = i + 1) begin
        bin = i;
        #1;
        if (bin != 100*bcd_hun + 10*bcd_ten + bcd_one) begin
            $display("failed at %d, ", i);
        end
    end
    $display("passed");
    $finish;
end
    
endmodule