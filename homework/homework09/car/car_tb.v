`include "car.v"
`timescale 1ns/1ns

module test (

);


reg clk, reset;
reg emergency;
reg left, right, brake;
wire [2:0] led_left, led_right;

car_led u_car(clk, reset, emergency, left , right, brake, led_left, led_right);

always #5 clk = ~clk;

reg [3:0] data [11:0];
integer i;

initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    clk = 0;
    reset =  1;
    #1 reset = 0;
    $readmemb("data.bin", data);
    for (i = 0; i < 12; i = i + 1) begin
        {emergency, left, right, brake} = data[i];
        #20;
    end
    #10 $finish;
end


endmodule