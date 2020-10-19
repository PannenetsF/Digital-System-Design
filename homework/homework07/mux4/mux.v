module mux4 (
    en,
    s,
    d,
    y
);

input en;
input [1:0] s;
input [3:0] d;
output y;

assign y = en ? d[s] : 0;
    
endmodule