`include "bcd_add.v"

module test (

);

reg [11:0] bin;
wire [11:0] res;

top_module u(bin, res);

integer i;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    for (i = 0; i < 1000; i = i + 1) begin
        bin = ((i/100) << 8) + (((i%100)/10) << 4) + i % 10;
        #1;
        if (res !=  ((((1+i))/100) << 8 )+ (((((1+i))%100)/10) << 4) + ((1+i)) % 10) begin
            $display("failed at %d the res should be %d but %d, ", i, ((((1+i)%256)/100) << 8 )+ (((((1+i)%256)%100)/10) << 4) + ((1+i)%256) % 10, res);
            $finish;
        end
    end
    $display("passed");
    $finish;
end
    
endmodule