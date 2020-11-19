module cnt #(
    parameter integer MAX = 10,
    parameter integer BITS = 8
)
(
    reset,
    to_cnt,
    sum
);

input to_cnt;
input reset;
output reg [BITS-1:0] sum;

always @(posedge to_cnt or posedge reset) begin
    if (reset) begin
        sum <= 0;
    end
    else begin
        if (sum != MAX-1) begin
            sum <= sum + 1;
        end
        else begin
            sum <= 0;
        end
    end
end

    
endmodule