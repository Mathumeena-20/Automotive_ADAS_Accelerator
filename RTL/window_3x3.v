module window_3x3(
    input clk,
    input reset,
    input [7:0] in,
    input [7:0] lb1,
    input [7:0] lb2,
    output reg [7:0] w0,w1,w2,
    output reg [7:0] w3,w4,w5,
    output reg [7:0] w6,w7,w8
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        w0<=0; w1<=0; w2<=0;
        w3<=0; w4<=0; w5<=0;
        w6<=0; w7<=0; w8<=0;
    end else begin
        w0 <= w1; w1 <= w2; w2 <= in;
        w3 <= w4; w4 <= w5; w5 <= lb1;
        w6 <= w7; w7 <= w8; w8 <= lb2;
    end
end

endmodule