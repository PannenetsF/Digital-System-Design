`include "gray2bin.v"
module test (
);

reg [3:0] in;
wire [3:0] out;

gray2bin u_2(
    in,
    out
);

integer i; 

reg [3:0] bin [15:0];
reg [3:0] gray [15:0];

initial begin
    $dumpfile("test_2.vcd");
    $dumpvars;
    $readmemb("bin.ram", bin);
    $readmemb("gray.ram", gray);
    for (i = 0; i < 16; i = 1 + i) begin
        in = gray[i];
        #1;
        if (out != bin[i]) begin
            $display("failed at gray %x", in);
            $finish;
        end
    end
    $display("passed");
    $finish;
end
    
endmodule