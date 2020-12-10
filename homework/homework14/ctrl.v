module ctrl (
    clk,
    reset,
    en,
    mod_choose,
    bit_choose,
    val_add,
    val_sub,
    val_set
);

input clk, reset, en, mod_choose, bit_choose, val_add, val_sub, val_set;


`define ctrl_clock_show 0
`define ctrl_clock_set 1
`define ctrl_stopwatch 2
`define ctrl_alarm 3

reg [1:0] mod_now;
reg bit_now;
reg [5:0] temp_h, temp_m, temp_s;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        {temp_h, temp_m, temp_s} <= 0;
        mod_now <= `ctrl_clock_show;
    end
    else if (!en) begin
        
    end
end
    
endmodule