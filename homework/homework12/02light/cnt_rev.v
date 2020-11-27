module cnt_rev #(
    parameter integer r_t = 3,
    parameter integer g_t = 3,
    parameter integer y_t = 3,
    parameter integer l_t = 3
)  (
    clk,
    reset,
    en,
    light_rgyl,
    cnt
);


input clk;
input reset;
input en;
input [3:0] light_rgyl;
output reg [7:0] cnt;

reg [3:0] flag_now;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt <= 0;
        flag_now <= 0;
    end    
    else begin
        if (cnt == 0) begin
            flag_now <= light_rgyl;
            case (light_rgyl)
                4'b0001: cnt <= l_t - 1;
                4'b0010: cnt <= y_t - 1;
                4'b0100: cnt <= g_t - 1;
                4'b1000: cnt <= r_t - 1;
                default: cnt <= 0;
            endcase
        end
        else begin
            cnt <= cnt - 1;
        end
    end
end
    
endmodule