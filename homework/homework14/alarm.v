`include "param.v"

module alarm (
    clk,
    reset,
    set,
    en,
    alarming,
    clear,
    set_h,
    set_m,
    set_s,
    hms_h,
    hms_m,
    hms_s,
    saved_h, 
    saved_m, 
    saved_s
);

input clk, reset, set, en, clear;
input [5:0] hms_h, hms_m, hms_s;
input [5:0] set_h, set_m, set_s;
output alarm_on;
output reg alarming;
output reg [5:0] saved_h, saved_m, saved_s;

`define alarm_status_work 0
`define alarm_status_set 1

assign alarm_on = (status == `alarm_status_work);

reg status;

wire time_is_right;
assign time_is_right = (hms_h === saved_h) && (hms_m === saved_m) && (hms_s === saved_s);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        saved_h <= `alarm_init_h;
        saved_m <= `alarm_init_m;
        saved_s <= `alarm_init_s;
        alarming <= 0;
        status <= `alarm_status_work;
    end
    else begin
        case (status)
            `alarm_status_work: begin
                status <= set;
                if (alarming == 0) begin
                    if (time_is_right) alarming <= 1;
                    else alarming <= alarming;
                end
                else begin
                    if (clear) alarming <= 0;
                    else alarming <= alarming;
                end
                if (set) begin
                    saved_h <= set_h;
                    saved_m <= set_m;
                    saved_s <= set_s;
                end
                else saved_h <= saved_h;
            end
            `alarm_status_set: begin 
                status <= `alarm_status_work;
            end
            default: begin
                saved_h <= saved_h;
                saved_m <= saved_m;
                saved_s <= saved_s;
                status <= set;
            end
        endcase
    end
end
    
endmodule