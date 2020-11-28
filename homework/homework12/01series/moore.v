module  seqdet_moore (
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
`define state10010 5 

input clk, reset, data;
output res;

reg [3:0] status;

assign res = (status == `state10010); 

always @(posedge clk or posedge reset) begin
    if (reset) begin
        status <= `idle;
    end
    else begin
        case (status)
            `idle: begin
                if (data == 1) status <= `state1;
                else status <= `idle;
            end
            `state1: begin
                if (data == 1) status <= `state1;
                else status <= `state10; 
            end
            `state10: begin
                if (data == 1) status <= `state1; 
                else status <= `state100;
            end
            `state100: begin
                if (data == 1) status <= `state1001;
                else status <= `idle;  
            end
            `state1001: begin
                if (data == 1) status <= `state1;
                else status <= `state10010; 
            end
            `state10010: begin
                if (data == 1) status <= `state1;
                else status <= `state100; 
            end
            default: status <= `idle;
        endcase
    end
end
    
endmodule

