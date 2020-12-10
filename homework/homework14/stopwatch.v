`include "param.v"

module stopwatch #(
    parameter integer max_h = 12,
    parameter integer max_m = 23,
    parameter integer max_s = 41
) 
(
    clk,
    reset,
    en,
    set,
    pause_resume,
    out_h,
    out_m,
    out_s
);


input clk, reset, en, set, pause_resume;
output reg [5:0] out_h, out_m, out_s;

`define stopwatch_pause 0
`define stopwatch_working 1

reg status;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        {out_h, out_m, out_s} <= 0;
        status <= `stopwatch_pause;
    end
    else if (!en) begin
        {out_h, out_m, out_s} <= {out_h, out_m, out_s};
    end
    else begin
        if (set) begin
            status <= `stopwatch_pause;
            {out_h, out_m, out_s} <= 0;
        end
        else begin
            case (status)
                `stopwatch_pause: begin
                    if (pause_resume) status <= `stopwatch_working;
                    else {out_h, out_m, out_s} <= {out_h, out_m, out_s};
                end
                `stopwatch_working: begin
                    if (pause_resume) status <= `stopwatch_pause;
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
                default: begin
                    status <= `stopwatch_pause;
                    {out_h, out_m, out_s} <= 0;
                end
            endcase
        end
    end
end
    
endmodule