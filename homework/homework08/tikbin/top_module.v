module top_module (
    clk,
    reset,
    updown,
    C,
    Q
);

input clk;
input reset;
input updown;
output C;
output [7:0] Q;

reg full;
reg [7:0] Q_reg;

assign C = full;
assign Q = Q_reg;

`define ADD 1
`define MINUS 0 
`define FULL 8'hff 
`define NULL 0

always @(posedge clk or reset) begin
    if (!reset) begin
        full <= 0;
        Q_reg <= 0;
    end
    else begin
        case (updown)
            `ADD: begin
                Q_reg <= Q_reg + 1;
                if (Q_reg == `FULL - 1) begin
                    full <= 1;
                end
                else full <= 0;
            end
            `MINUS: begin
                Q_reg <= Q_reg - 1;
                if (Q_reg == `NULL + 1) begin
                    full <= 1;
                end
                else full <= 0;
            end
        endcase
    end
end

endmodule