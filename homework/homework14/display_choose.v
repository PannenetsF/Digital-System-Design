module display_choose (
    clk,
    reset,
    en,
    switch,
    clock_h,
    clock_m,
    clock_s,
    alarm_h,
    alarm_m,
    alarm_s,
    stopwatch_h,
    stopwatch_m,
    stopwatch_s,
    temp_h,
    temp_m,
    temp_s,
    out_h,
    out_m,
    out_s
);

input clk, reset, en;
input [1:0] switch;
input [5:0] clock_h, clock_m, clock_s, alarm_h, alarm_m, alarm_s, stopwatch_h, stopwatch_m, stopwatch_s, temp_h, temp_m, temp_s;
output [5:0] out_h, out_m, out_s;

assign {out_h, out_m, out_s} = 
    (switch == 0) ? {clock_h, clock_m, clock_s} : (
        (switch == 1) ? {alarm_h, alarm_m, alarm_s} : (
            (switch == 2) ? {stopwatch_h, stopwatch_m, stopwatch_s} : (
                (switch == 3) ? {temp_h, temp_m, temp_s} : 0
            )
        )
    );

    
endmodule