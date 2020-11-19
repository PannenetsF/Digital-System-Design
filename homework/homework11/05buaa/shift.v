// `include "dec.v"
module shift #(
    parameter integer N = 4, 
    parameter [4*N-1:0] INIT = 10
)  
(
    clk,
    reset, 
    out 
);

input clk, reset;
output reg [4*N-1:0] out;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out <= INIT;
        $displayb(INIT);
    end
    else begin
        out <= {out[4*N-5:0], out[4*N-1:4*N-4]};
    end
end


endmodule