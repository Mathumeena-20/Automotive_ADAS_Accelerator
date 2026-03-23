`timescale 1ns/1ps

module cnn_tb;

reg clk;
reg reset;
wire valid;
wire signed [15:0] final_out;

// DUT
cnn_top uut (
    .clk(clk),
    .reset(reset),
    .valid(valid),
    .final_out(final_out)
);

// Clock
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #10 reset = 0;

    #3000 $finish;
end

endmodule