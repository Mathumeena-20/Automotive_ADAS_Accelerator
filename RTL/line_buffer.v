module line_buffer #(
    parameter WIDTH = 5
)(
    input clk,
    input reset,
    input [7:0] pixel_in,
    output [7:0] lb1_out,
    output [7:0] lb2_out
);

reg [7:0] line1 [0:WIDTH-1];
reg [7:0] line2 [0:WIDTH-1];

integer i;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i=0; i<WIDTH; i=i+1) begin
            line1[i] <= 0;
            line2[i] <= 0;
        end
    end else begin
        for (i=WIDTH-1; i>0; i=i-1) begin
            line1[i] <= line1[i-1];
            line2[i] <= line2[i-1];
        end

        line1[0] <= pixel_in;
        line2[0] <= line1[WIDTH-1];
    end
end

assign lb1_out = line1[WIDTH-1];
assign lb2_out = line2[WIDTH-1];

endmodule