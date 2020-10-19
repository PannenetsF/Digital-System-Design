`include "mux.v"

module test (

);

reg en;
reg [1:0] s;
reg [3:0] d;
wire y;

mux4 u_mux(
    .en(en),
    .s(s),
    .d(d),
    .y(y)
);

reg en_r [99:0];
reg [1:0] s_r [99:0];
reg [3:0] d_r [99:0];
reg y_r [99:0];

integer i;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    $readmemb("en.ram", en_r);
    $readmemb("s.ram", s_r);
    $readmemb("d.ram", d_r);
    $readmemb("y.ram", y_r);
    for (i = 0; i < 100; i = i + 1) begin
        en = en_r[i];
        s = s_r[i];
        d = d_r[i];
        #1;
        if (y != y_r[i]) begin
            $display("failed, y:%x y_r:%x", y, y_r[i]);
            $finish;
        end
    end
    $display("passed");
    $finish;
end
    
endmodule