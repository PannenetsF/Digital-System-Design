`include "param.v"

module cnt_rev #(
    parameter integer r_t = 3,
    parameter integer g_t = 3,
    parameter integer y_t = 3,
    parameter integer y_n_t = 3,
    parameter integer l_t = 3,
    parameter integer init_state = `cnt_green,
    parameter integer init_time = 3
)  (
    clk,
    reset,
    en,
    cnt
);


input clk;
input reset;
input en;
output reg [7:0] cnt;

reg [3:0] state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        cnt <= 0;
        cnt <= init_time;
        state <= init_state;
    end 
	 else if (en==0) begin 
        cnt <= 0;
        cnt <= init_time;
        state <= init_state;		
	 end
    else begin
        if (cnt == 0) begin
            case (state)
                `cnt_green : begin
                    state <= `cnt_yellow;
                    cnt <= y_t - 1;
                end
                `cnt_yellow : begin
                    state <= `cnt_left;
                    cnt <= l_t - 1;
                end
                `cnt_left : begin
                    state <= `cnt_yellow_next;
                    cnt <= y_n_t - 1;
                end
                `cnt_yellow_next : begin
                    state <= `cnt_red;
                    cnt <= r_t - 1;
                end
                `cnt_red : begin
                    state <= `cnt_green;
                    cnt <= g_t - 1;
                end
                default: begin
                    state <= `cnt_green;
                    cnt <= 0;
                end
            endcase
        end
        else begin
            cnt <= cnt - 1;
        end
    end
end
    
endmodule