module sync (
    clk,
    reset,
    read,
    sig,
    valid
);

input clk, reset, sig, read;
output reg valid;
reg sig_buf;

always @(*) begin
    if (valid) begin
        sig_buf = 0;
    end
    else if (sig_buf && read == 0) begin
        sig_buf = sig_buf;
    end
    else begin
        sig_buf = sig;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        valid <= 0;
    end
    else begin
        if (valid) begin
            // if (read) begin
                valid <= 0;
            // end
            // else valid <= valid;
        end
        else begin
            if (sig_buf == 1) begin
                valid <= 1;
            end
            else begin
                valid <= 0;
            end 
        end
    end
end



endmodule