module top_module (
    clk,
    reset,
    set,
    load,
    D,
    Q
);

input clk;
input reset;
input set;
input load;
input [3:0] D;
output [3:0] Q;

reg [3:0] Q_reg;

assign Q = Q_reg;

always @(posedge clk) begin
    if (reset == 1) begin
        Q_reg <= 0;
    end
    else if (set == 1) begin
        Q_reg <= 4'b1111;
    end 
    else if (load == 1) begin
        Q_reg <= D;
    end
end
    
endmodule