// `include "dec.v"
module shift #(parameter integer N = 4)  
(
    SW,
    KEY,
    HEX7,
    HEX6,
    HEX5,
    HEX4,
    HEX3,
    HEX2,
    HEX1,
    HEX0
);

input [17:0] SW;
input [0:0] KEY;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

wire reset;
wire clk;
wire [1:0] ctrl;
wire [N-1:0] data;

assign reset = SW[17];
assign clk = KEY[0];
assign ctrl = SW[16:15];
assign data = SW[N-1:0];

reg [7:0] show;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        show <= 0;
    end
else begin
        case (ctrl)
            // hold
            0 : show <= show;
            // left
            1 : show <= {show[N-2:0], SW[0]};
            // right
            2 : show <= {SW[1], show[N-1:1]};
            // load 
            3 : show <= data;
            default: show <= 0;
        endcase
    end
end

dec u_7(show[7], HEX7);
dec u_6(show[6], HEX6);
dec u_5(show[5], HEX5);
dec u_4(show[4], HEX4);
dec u_3(show[3], HEX3);
dec u_2(show[2], HEX2);
dec u_1(show[1], HEX1);
dec u_0(show[0], HEX0);

endmodule