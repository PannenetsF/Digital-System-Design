module show_bit (
    bit,
    en,
    led
);

input bit, en;
output [3:0] led;

assign led = en ? ((bit == 0) ? 4'b0011 : 4'b1100) : 0;

endmodule