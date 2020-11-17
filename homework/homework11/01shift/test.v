module test (
);

reg signed [3:0] b;

initial begin
    b = 0;
    #1 $display("%d", b);
    b = b - 1;
    #1 $display("%d", b);
    b = $signed(b) >>> 1;
    #1 $displayb(b);
    b = $signed(b) >> 1;
    #1 $displayb(b);
end
    
endmodule