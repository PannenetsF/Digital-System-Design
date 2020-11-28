// `include "tik.v"

module led (
    CLOCK_50,
    SW,
    KEY,
    LEDR
);

input CLOCK_50;
input [2:2]KEY;
input [17:16] SW;
output [9:0] LEDR;

wire clk, reset, en, push;
assign push = KEY[2];
assign reset = SW[17];
assign en = SW[16];
tiks #(.M(5), .BASE(50000000)) u_tik(
    .CLOCK_50(CLOCK_50),
    .reset(reset),
    .tik(clk)
);

reg [9:0] f_0_to_9, f_9_to_0;
reg [1:0] cnt;
reg [3:0] timer;
assign LEDR = f_0_to_9 | f_9_to_0;

`define t_1 10
`define t_2 9 
`define t_3 5 

always @(posedge clk or posedge reset) begin
    if (reset) begin
        f_0_to_9 <= 0;
        f_9_to_0 <= 0;
        cnt <= 0;
        timer <= 0;
    end
    else if (!en) begin
        f_0_to_9 <= 0;
        f_9_to_0 <= 0;
        cnt <= 0;
        timer <= 0;
    end
    else begin
        if (push) begin
            cnt <= cnt + 1;
            case (cnt + 1)
                1: begin
                    f_0_to_9 <= 1;
                    f_9_to_0 <= 0;
                end
                2: begin
                    f_0_to_9 <= 1 << 9;
                    f_9_to_0 <= 1 << 8;
                end
                3: begin
                    f_0_to_9 <= 1;
                    f_9_to_0 <= 1 << 9;
                end
                default : begin
                    f_0_to_9 <= 0;
                    f_9_to_0 <= 0;
                end
            endcase
        end
        else begin
            case (cnt)
                1: begin
                    f_9_to_0 <= 0;
                    f_0_to_9 <= {f_0_to_9[8:0], f_0_to_9[9]};
                end
                2: begin
                    f_0_to_9 <= {f_0_to_9[0], f_0_to_9[9:1]};
                    f_9_to_0 <= {f_9_to_0[0], f_9_to_0[9:1]};
                end
                3: begin
                    f_0_to_9 <= {f_0_to_9[8:0], f_0_to_9[9]};
                    f_9_to_0 <= {f_9_to_0[0], f_9_to_0[9:1]};
                end
                default: begin
                    f_0_to_9 <= 0;
                    f_9_to_0 <= 0;
                end
            endcase
        end
    end
end


endmodule