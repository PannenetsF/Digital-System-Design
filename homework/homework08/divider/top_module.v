module top_module (
    clk,
    clkA,
    clkB,
    debug_rst
);

`define CNT_A 2/2
`define CNT_B 5

input clk;
input debug_rst;
output reg clkA;
output reg clkB;

reg [4:0] cntA;
reg [4:0] cntB;

always @(posedge clk) begin
    if (debug_rst) begin
      cntA <= 0;
      clkA <= 0;
    end
    else begin
        if (cntA == `CNT_A - 1) begin
            clkA <= ~clkA;
            cntA <= 0;
        end
        else begin
            cntA <= cntA + 1;
        end
    end
end


always @(posedge clk or negedge clk) begin
    if (debug_rst) begin
      cntB <= 0;
      clkB <= 0;
    end
    else begin
        if (cntB == `CNT_B - 1) begin
            clkB <= ~clkB;
            cntB <= 0;
        end
        else begin
            cntB <= cntB + 1;
        end
    end
end



endmodule