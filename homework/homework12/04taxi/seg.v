module seg (
    SW,
    HEX0
);

input [3:0] SW;
output [6:0] HEX0;
assign HEX0 = ~HEX;
reg [6:0] HEX;
always @(*) begin
    case (SW)
        0: HEX = 7'h3f; // O
        1: HEX = 7'h06; 
        2: HEX = 7'h5b;
        3: HEX = 7'h4f;
        4: HEX = 7'h66;
        5: HEX = 7'h6d;
        6: HEX = 7'h7d;
        7: HEX = 7'h07;
        8: HEX = 7'h7f; // B 
        9: HEX = 7'h6f; 
        10: HEX = 7'h76; // H 1110110
        11: HEX = 7'h79; // E
        12: HEX = 7'h38; // L
        13: HEX = 7'h3e; // U
        14: HEX = 7'h77; // A
        default: HEX = 0;
    endcase
end
    
endmodule