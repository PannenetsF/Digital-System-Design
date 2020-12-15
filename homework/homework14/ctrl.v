// `include "clock_hms.v"
// `include "stopwatch.v"
// `include "alarm.v"
// `include "display_choose.v"
// `include "show_bit.v"

module ctrl #(
    parameter integer max_h = 12,
    parameter integer max_m = 23,
    parameter integer max_s = 41
) 
(
    clk,
    reset,
    en,
    alarm_on,
    alarming,
    mod_choose,
    bit_choose,
    val_add,
    val_sub,
    val_set,
    clear,
    out_h,
    out_m,
    out_s,
    led,
    debug_bit_now,
    debug_mod_now
);

input clk, reset, en, mod_choose, bit_choose, val_add, val_sub, val_set, clear;

output [5:0] out_h, out_m, out_s;
output [3:0] led;
output alarming, alarm_on;

output debug_bit_now;
output [1:0] debug_mod_now;
assign debug_bit_now = bit_now;
assign debug_mod_now = mod_now;

assign alarm_on = en;

`define ctrl_clock_show 0
`define ctrl_clock_set 1
`define ctrl_stopwatch 2
`define ctrl_alarm 3

reg status;
`define ctrl_set_start 0
`define ctrl_set_done 1

reg [1:0] mod_now;
reg bit_now;
reg [5:0] temp_h, temp_m, temp_s;
reg [5:0] set_h, set_m, set_s;


/*
 * Clock instance
 */
reg clock_set;
wire [5:0] clock_h, clock_m, clock_s;

clock_hms #(.max_h(max_h), .max_m(max_m), .max_s(max_s)) 
    u_clock(
    .clk(clk),
    .reset(reset),
    .en((mod_now == `ctrl_clock_set)),
    .set(clock_set),
    .set_h(set_h),
    .set_m(set_m),
    .set_s(set_s),
    .out_h(clock_h),
    .out_m(clock_m),
    .out_s(clock_s)
);


/*
 * Stopwatch instance
 */

wire stopwatch_set, stopwatch_pause_resume;
wire [5:0] stop_h, stop_m, stop_s;
assign stopwatch_set = val_set;
assign stopwatch_pause_resume = val_add || val_sub;

stopwatch #(.max_h(max_h), .max_m(max_m), .max_s(max_s)) 
    u_stop(
        .clk(clk),
        .reset(reset),
        .en(en),
        .set(stopwatch_set),
        .pause_resume(stopwatch_pause_resume),
        .out_h(stop_h),
        .out_m(stop_m),
        .out_s(stop_s)
    );

/*
 * Alarm instance
 */

reg alarm_set;
wire [5:0] saved_h, saved_m, saved_s;

alarm u_alarm(
    .clk(clk),
    .reset(reset),
    .set(alarm_set),
    .en((mod_now == `ctrl_alarm)),
    .alarming(alarming),
    .clear(clear),
    .set_h(set_h),
    .set_m(set_m),
    .set_s(set_s),
    .hms_h(clock_h),
    .hms_m(clock_m),
    .hms_s(clock_s),
    .saved_h(saved_h),
    .saved_m(saved_m),
    .saved_s(saved_s)
);


/*
 * Display choose
 */

wire [1:0] switch;
assign switch = 
    (mod_now == `ctrl_clock_show) ? 0 : (
        (mod_now == `ctrl_alarm) ? 1 : (
            (mod_now == `ctrl_stopwatch) ? 2 : (
                (mod_now == `ctrl_clock_set) ? 3 : 0
            )
        )
    );

display_choose u_choose(
    .clk(clk),
    .reset(reset),
    .en(en),
    .switch(switch),
    .clock_h(clock_h),
    .clock_m(clock_m),
    .clock_s(clock_s),
    .alarm_h(temp_h),
    .alarm_m(temp_m),
    .alarm_s(temp_s),
    .stopwatch_h(stop_h),
    .stopwatch_m(stop_m),
    .stopwatch_s(stop_s),
    .temp_h(temp_h),
    .temp_m(temp_m),
    .temp_s(temp_s),
    .out_h(out_h),
    .out_m(out_m),
    .out_s(out_s)
);

/*
 * Bit choose and show
 */

show_bit u_show_bit(
    .bit(bit_now),
    .en((mod_now == `ctrl_alarm) || (mod_now == `ctrl_clock_set)),
    .led(led)
);

/*
 * Controll logic
 */

reg alarm_loaded;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        {temp_h, temp_m, temp_s} <= 0;
        {set_h, set_m, set_s} <= 0;
        clock_set <= 0;
        alarm_loaded <= 0;
        alarm_set <= 0;
        status <= `ctrl_set_start;
    end
    else if (!en) begin
        {temp_h, temp_m, temp_s} <= 0;
        {set_h, set_m, set_s} <= 0;
    end
    else begin
        if (status == `ctrl_set_start) begin
            case (mod_now)
                `ctrl_clock_show: begin
                    {temp_h, temp_m, temp_s} <= {clock_h, clock_m, clock_s};
                    alarm_loaded <= 0;
                end
                `ctrl_clock_set: begin
                    alarm_loaded <= 0;
                    temp_s <= 0;
                    if (val_add) begin
                        if (bit_now == 0) begin
                            if (temp_m == max_m - 1) temp_m <= 0;
                            else temp_m <= temp_m + 1;
                        end
                        else begin
                            if (temp_h == max_h - 1) temp_h <= 0;
                            else temp_h <= temp_h + 1;
                        end
                    end
                    else if (val_sub) begin
                        if (bit_now == 0) begin
                            if (temp_m == 0) temp_m <= max_m - 1;
                            else temp_m <= temp_m - 1;
                        end
                        else begin
                            if (temp_h == max_h - 1) temp_h <= max_h - 1;
                            else temp_h <= temp_h - 1;
                        end
                    end
                    else if (val_set) begin
                        {set_h, set_m, set_s} <= {temp_h, temp_m, temp_s};
                        clock_set <= 1;
                        status <= `ctrl_set_done;
                    end
                end
                `ctrl_alarm: begin
                    if (alarm_loaded == 0) begin
                        {temp_h, temp_m, temp_s} <= {saved_h, saved_m, saved_s};
                        alarm_loaded <= 1;
                    end
                    else begin
                        if (val_add) begin
                            if (bit_now == 0) begin
                                if (temp_m == max_m - 1) temp_m <= 0;
                                else temp_m <= temp_m + 1;
                            end
                            else begin
                                if (temp_h == max_h - 1) temp_h <= 0;
                                else temp_h <= temp_h + 1;
                            end
                        end
                        else if (val_sub) begin
                            if (bit_now == 0) begin
                                if (temp_m == 0) temp_m <= max_m - 1;
                                else temp_m <= temp_m - 1;
                            end
                            else begin
                                if (temp_h == max_h - 1) temp_h <= max_h - 1;
                                else temp_h <= temp_h - 1;
                            end
                        end
                        else if (val_set) begin
                            {set_h, set_m, set_s} <= {temp_h, temp_m, temp_s};
                            alarm_set <= 1;
                            status <= `ctrl_set_done;
                        end
                    end
                end
                default: begin
                    {temp_h, temp_m, temp_s} <= {clock_h, clock_m, clock_s};
                    {set_h, set_m, set_s} <= 0;
                    alarm_loaded <= 0;
                end
            endcase
        end
        else begin
            clock_set <= 0;
            alarm_set <= 0;
            alarm_loaded <= 0;
            status <= `ctrl_set_start;
        end
        
    end 
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        mod_now <= `ctrl_clock_show;
        bit_now <= 0;
    end
    else if (!en) begin
        mod_now <= `ctrl_clock_show;
        bit_now <= 0;
    end
    else begin
        if (mod_choose) mod_now <= mod_now + 1;
        else mod_now <= mod_now;
        if (bit_choose) bit_now <= bit_now + 1;
        else bit_now <= bit_now;
    end
end
    
endmodule