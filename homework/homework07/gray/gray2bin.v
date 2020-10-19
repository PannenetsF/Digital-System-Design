module gray2bin (
    in, 
    out
);

input [3:0] in;
output [3:0] out;

integer i;
reg [3:0] temp;

assign out = temp;

always @(*) begin
    temp[3] = in[3];
    for (i = 2; i >= 0; i = i - 1) begin
        temp[i] = in[i] ^ temp[i+1];
    end    
end
    
endmodule