`include "bin2gray.v"
module test (
);

reg [3:0] in;
wire [3:0] out;

top_module u_2(
    in,
    out
);

integer i; 

reg [3:0] bin [15:0];
reg [3:0] gray [15:0];

initial begin
    $dumpfile("test_1.vcd");
    $dumpvars;
    $readmemb("bin.ram", bin);
    $readmemb("gray.ram", gray);
    for (i = 0; i < 16; i = 1 + i) begin
        in = bin[i];
        #1;
        if (out != gray[i]) begin
            $display("failed at bin %x", in);
            $finish;
        end
    end
    $display("passed");
    $finish;
end
    
endmodule