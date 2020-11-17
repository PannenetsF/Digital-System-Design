module mux2(SW, LEDR);

input [17:0] SW;
output [17:0] LEDR;

wire S;
wire [7:0] X;
wire [7:0] Y;

assign S = SW[17];
assign X = SW[7:0];
assign Y = SW[15:8];

assign LEDR[7:0] = S ? Y : 0;
assign LEDR[15:8] = S ? 0 : X;

endmodule
