module bcd (
    bin,
    bcd_hun,
    bcd_ten,
    bcd_one
);

input [9:0] bin;
output [3:0] bcd_hun;
output [3:0] bcd_ten;
output [3:0] bcd_one;

assign bcd_hun = bcd_hun_r;
assign bcd_ten = bcd_ten_r;
assign bcd_one = bcd_one_r;

reg [9:0] bin_r;
reg [3:0] bcd_hun_r;
reg [3:0] bcd_ten_r;
reg [3:0] bcd_one_r;

integer i;

always @(bin) begin
    init_all;
    for (i = 0; i < 10; i = i + 1) begin
        check_all;
        shift_all;
    end
end

task init_all;
    begin
        bin_r = bin;
        bcd_hun_r = 0;
        bcd_ten_r = 0;
        bcd_one_r = 0;
    end
endtask

task shift_all;
    {bcd_hun_r, bcd_ten_r, bcd_one_r, bin_r} = {bcd_hun_r, bcd_ten_r, bcd_one_r, bin_r} << 1;
endtask 

task check_all;
    begin
        if (bcd_one_r > 4) begin
            bcd_one_r = bcd_one_r + 3;
        end
        if (bcd_ten_r > 4) begin
            bcd_ten_r = bcd_ten_r + 3;
        end
        if (bcd_hun_r > 4) begin
            bcd_hun_r = bcd_hun_r + 3;
        end
    end
endtask
    
endmodule 