module top_module (
    clk,
    reset,
    C,
    Q
);

`define MAX 10 

input clk;
input reset;
output C;
output [3:0] Q;

reg [3:0] cnt;
reg full;

assign C = full;
assign Q = cnt;

always @(posedge clk or reset) begin
    if (reset) begin
        cnt <= 0;
        full <= 0;
    end
    else begin
        if (cnt == `MAX - 1) begin
            cnt <= 0;
            full <= 0;
        end
        else begin
            cnt <= cnt + 1;
            if (cnt == `MAX - 1 - 1) begin
                full <= 1;
            end
            else full <= 0;
        end
    end
end
    
endmodule