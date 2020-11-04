module  seqdet_mealy (
    clk, 
    reset,
    data,
    res
);


`define idle 0 
`define state1 1
`define state10 2
`define state100 3
`define state1001 4

input clk, reset, data;
output res;

assign res = res_reg;

reg res_reg;
reg [3:0] status;


always @(posedge clk or reset) begin
    if (reset) begin
        status <= `idle;
        res_reg <= 0;
    end
    else begin
        case (status)
            `idle: begin
                if (data == 1) begin
                    status <= `state1;
                    
                end
                else begin
                    status <= `idle;
                    res_reg <= 0;      
                end
                
            end
            `state1: begin
                if (data == 1) begin
                    status <= `state1;
                    res_reg <= 0;
                end 
                else begin
                    status <= `state10; 
                    res_reg <= 0;
                end
            end
            `state10: begin
                if (data == 1) begin
                    status <= `state1; 
                    res_reg <= 0;
                end
                else begin
                    status <= `state100;
                    res_reg <= 0;
                end
            end
            `state100: begin
                if (data == 1) begin
                    status <= `state1001;
                    res_reg <= 0;
                end
                else begin
                    status <= `idle;  
                    res_reg <= 0;
                end
            end
            `state1001: begin
                if (data == 1) begin
                    status <= `state1;
                    res_reg <= 0;
                end
                else begin
                    status <= `state10; 
                    res_reg <= 1;
                end
            end
            default: begin
                status <= `idle;
                res_reg <= 0;
            end
        endcase
    end
end
    
endmodule