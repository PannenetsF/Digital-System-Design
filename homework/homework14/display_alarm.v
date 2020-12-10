module display_alarm (
    clk,
    reset,
    en,
    HEX
);

input clk, reset, en;
output reg [6:0] HEX;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        HEX <= 1;
    end
    else if (!en) begin
        HEX <= 1;
    end
    else begin
       HEX <= {HEX[5:0], HEX[6]};
    end
end
    
endmodule