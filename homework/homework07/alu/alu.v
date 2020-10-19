module alu (
    op,
    a,
    b,
    res
);

input [1:0] op;
input [3:0] a;
input [3:0] b;
output [3:0] res;

reg [3:0] ans;

assign res = ans;

always @(*) begin
    case (op)
        2'b00: ans = ~a;
        2'b01: ans = ~b;
        2'b10: ans = a & b;
        2'b11: ans = a | b;
        default: ans = 0;
    endcase
end
    
endmodule