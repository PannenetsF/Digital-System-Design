module car_led(clk, reset, emergency, left , right, brake, led_left, led_right);

/*
 * Assume that: (a,b,c) -> reg[0,1,2] 
 */

// the special status of led on both side
`define all_off 3'b000 
`define one_on 3'b001 
`define two_on 3'b011
`define all_on 3'b111

`define go_straight 0
`define go_left 1
`define go_right 2
`define go_straight_brake 3
`define go_left_brake 4
`define go_right_brake 5
`define go_emergency 6

input clk, reset;
input emergency;
input left, right, brake;
output [2:0] led_left, led_right;

reg [3:0] status;

wire straight;
reg [2:0] led_left_reg, led_right_reg;
reg [1:0] left_cnt, right_cnt;
reg eme_cnt;

assign straight = (left == 0) && (right == 0);
assign led_left = led_left_reg;
assign led_right = led_right_reg;


always @(posedge clk or reset) begin
    if (reset) begin
        set_led(`all_off, led_left_reg);
        set_led(`all_off, led_right_reg);
        left_cnt <= 0;
        right_cnt <= 0;
        eme_cnt <= 0;
    end
    else begin
        case (status)
            `go_straight : begin
                led_left_reg <= `all_off;
                led_right_reg <= `all_off;
                left_cnt <= 0;
                right_cnt <= 0;
                eme_cnt <= 0;
            end
            `go_left: begin
                left_cnt <= left_cnt + 1;
                right_cnt <= 0;
                eme_cnt <= 0;
                led_right_reg <= `all_off;
                if (left_cnt == 0) led_left_reg <= `all_off;
                else if (left_cnt == 1) led_left_reg <= `one_on; 
                else if (left_cnt == 2) led_left_reg <= `two_on;
                else if (left_cnt == 3) led_left_reg <= `all_on;
            end
            `go_right: begin
                led_left_reg <= `all_off;
                right_cnt <= right_cnt + 1;
                left_cnt <= 0;
                eme_cnt <= 0;
                if (right_cnt == 0) led_right_reg <= `all_off;
                else if (right_cnt == 1) led_right_reg <= `one_on; 
                else if (right_cnt == 2) led_right_reg <= `two_on;
                else if (right_cnt == 3) led_right_reg <= `all_on;
            end
            `go_straight_brake: begin
                led_left_reg <= `all_on;
                led_right_reg <= `all_on;
                left_cnt <= 0;
                right_cnt <= 0;
                eme_cnt <= 0;
            end
            `go_left_brake: begin
                led_right_reg <= `all_on;
                left_cnt <= left_cnt + 1;
                right_cnt <= 0;
                eme_cnt <= 0;
                if (left_cnt == 0) led_left_reg <= `all_off;
                else if (left_cnt == 1) led_left_reg <= `one_on; 
                else if (left_cnt == 2) led_left_reg <= `two_on;
                else if (left_cnt == 3) led_left_reg <= `all_on;
            end
            `go_right_brake: begin
                led_left_reg <= `all_on;
                right_cnt <= right_cnt + 1;
                left_cnt <= 0;
                eme_cnt <= 0;
                if (right_cnt == 0) led_right_reg <= `all_off;
                else if (right_cnt == 1) led_right_reg <= `one_on; 
                else if (right_cnt == 2) led_right_reg <= `two_on;
                else if (right_cnt == 3) led_right_reg <= `all_on;
            end 
            `go_emergency: begin
                eme_cnt <= ~eme_cnt;
                left_cnt <= 0;
                right_cnt <= 0;
                if (eme_cnt) begin
                    led_right_reg <= `all_off;
                    led_left_reg <= `all_off;
                end
                else begin
                    led_right_reg <= `all_on;
                    led_left_reg <= `all_on;
                end
            end
            default: begin
                led_right_reg <= `all_off;
                led_left_reg <= `all_off;
                left_cnt <= 0;
                right_cnt <= 0;
                eme_cnt <= 0;
            end
        endcase
    end
end

always @(posedge clk or reset) begin
    if (reset == 0) begin
        if (emergency) status = `go_emergency;
        else if (left == 0 && right == 0 && brake == 0) status = `go_straight;
        else if (left == 1 && right == 0 && brake == 0) status = `go_left;
        else if (left == 0 && right == 1 && brake == 0) status = `go_right;
        else if (left == 0 && right == 0 && brake == 1) status = `go_straight_brake;
        else if (left == 1 && right == 0 && brake == 1) status = `go_left_brake;
        else if (left == 0 && right == 1 && brake == 1) status = `go_right_brake;   
    end
end

task set_led;
input [2:0] led_pos;
output reg [2:0] led;
    begin
        // $display("led pos is %d", led_pos);
        led <= led_pos;
    end
endtask

endmodule