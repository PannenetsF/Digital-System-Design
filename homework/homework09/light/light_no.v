module traffic_light(clk, reset, light_ew_rgyl, light_sn_rgyl); 

input clk;
input reset;
output [3:0] light_ew_rgyl;
output [3:0] light_sn_rgyl;

`define idle 0
`define pre 11 
`define ew_green 1
`define ew_yellow 2
`define ew_left 3
`define ew_yellow_next 4
`define ew_red 5
`define sn_green 6
`define sn_yellow 7
`define sn_left 8
`define sn_yellow_next 9
`define sn_red 10

reg [3:0] status;

assign light_ew_rgyl[0] = (status == `ew_left);
assign light_ew_rgyl[1] = (status == `ew_yellow || status == `ew_yellow_next);
assign light_ew_rgyl[2] = (status == `ew_green);
assign light_ew_rgyl[3] = (status != `ew_green) && (status != `ew_yellow) && (status != `ew_yellow_next) && (status != `ew_left);
assign light_sn_rgyl[0] = (status == `sn_left);
assign light_sn_rgyl[1] = (status == `sn_yellow || status == `sn_yellow_next);
assign light_sn_rgyl[2] = (status == `sn_green);
assign light_sn_rgyl[3] = (status != `sn_green) && (status != `sn_yellow) && (status != `sn_yellow_next) && (status != `sn_left);

reg [7:0] cnt;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        status <= `idle;
        cnt <= 0;
    end
    else begin
        case (status)
            // `idle: wait_and_change(3, `sn_green, status); 
            `idle: begin
                if (cnt + 1 == 3) begin
                    cnt <= 0;
                    status <= `sn_green;
                end
                else cnt <= cnt + 1;
            end
            // `sn_green: wait_and_change(30, `sn_yellow, status);
            `sn_green: begin
                if (cnt + 1 == 30) begin
                    cnt <= 0;
                    status <= `sn_yellow;
                end
                else cnt <= cnt + 1;
            end
            // `sn_yellow: wait_and_change(5, `sn_left, status);
            `sn_yellow: begin
                if (cnt + 1 == 5) begin
                    cnt <= 0;
                    status <= `sn_left;
                end
                else cnt <= cnt + 1;
            end
            // `sn_left: wait_and_change(15, `sn_yellow_next, status);
            `sn_left: begin
                if (cnt + 1 == 15) begin
                    cnt <= 0;
                    status <= `sn_yellow_next;
                end
                else cnt <= cnt + 1;
            end 
            // `sn_yellow_next: wait_and_change(5, `sn_red, status);
            `sn_yellow_next: begin
                if (cnt + 1 == 5) begin
                    cnt <= 0;
                    status <= `sn_red;
                end
                else cnt <= cnt + 1;
            end
            // `sn_red: wait_and_change(3, `ew_green, status);
            `sn_red: begin
                if (cnt + 1 == 3) begin
                    cnt <= 0;
                    status <= `ew_green;
                end
                else cnt <= cnt + 1;
            end
            // `ew_green: wait_and_change(40, `ew_yellow, status);
            `ew_green: begin
                if (cnt + 1 == 40) begin
                    cnt <= 0;
                    status <= `ew_yellow;
                end
                else cnt <= cnt + 1;
            end
            // `ew_yellow: wait_and_change(5, `ew_left, status);
            `ew_yellow: begin
                if (cnt + 1 == 5) begin
                    cnt <= 0;
                    status <= `ew_left;
                end
                else cnt <= cnt + 1;
            end
            // `ew_left: wait_and_change(15, `ew_yellow_next, status);
            `ew_left: begin
                if (cnt + 1 == 15) begin
                    cnt <= 0;
                    status <= `ew_yellow_next;
                end
                else cnt <= cnt + 1;
            end
            // `ew_yellow_next: wait_and_change(5, `ew_red, status);
            `ew_yellow_next: begin
                if (cnt + 1 == 5) begin
                    cnt <= 0;
                    status <= `ew_red;
                end
                else cnt <= cnt + 1;
            end
            // `ew_red: wait_and_change(2, `sn_green, status);
            `ew_red: begin
                if (cnt + 1 == 2) begin
                    cnt <= 0;
                    status <= `sn_green;
                end
                else cnt <= cnt + 1;
            end
            default: status <= `idle;
        endcase
    end
end


endmodule