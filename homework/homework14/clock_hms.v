// `include "param.v"

module clock_hms #(
    parameter integer max_h = 12,
    parameter integer max_m = 23,
    parameter integer max_s = 41
) 
(
    clk,
    reset,
    en,
    set,
    set_h,
    set_m,
    set_s,
    out_h,
    out_m,
    out_s,
);

input clk, reset, en, set;
input [5:0] set_h, set_m, set_s;
output reg [5:0] out_h, out_m, out_s;

`define clock_hms_status_work 0
`define clock_hms_status_set 1

reg status;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out_h <= `clock_hms_init_h;
        out_m <= `clock_hms_init_m;
        out_s <= `clock_hms_init_s;
        status <= `clock_hms_status_work;
    end
    else begin
        case (status)
            `clock_hms_status_work: begin
                status <= set;
                if (set) begin
                    out_s <= set_s;
                    out_m <= set_m;
                    out_h <= set_h;
                end
                else begin
                    if (out_s == max_s - 1) begin
                        out_s <= 0;
                        if (out_m == max_m - 1) begin
                            out_m <= 0;
                            if (out_h == max_h - 1) begin
                                out_h <= 0;
                            end
                            else begin
                                out_h <= out_h + 1;
                            end
                        end
                        else begin
                            out_m <= out_m + 1;
                        end
                    end
                    else begin
                        out_s <= out_s + 1;
                    end
                end
            end
            `clock_hms_status_set: begin   
                    status <= `clock_hms_status_work;
            end
            default: begin
                status <= `clock_hms_status_work;
                out_h <= out_h;
                out_m <= out_m;
                out_s <= out_s;
            end
        endcase
    end
end


    
endmodule