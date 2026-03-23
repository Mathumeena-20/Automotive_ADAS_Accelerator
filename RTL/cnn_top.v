module cnn_top (
    input clk,
    input reset,
    output reg valid,
    output reg signed [15:0] final_out
);

// ================= IMAGE CHANNELS =================
reg signed [7:0] img0 [0:24];
reg signed [7:0] img1 [0:24];
reg signed [7:0] img2 [0:24];

integer i, j;

// ================= STREAM =================
reg [7:0] pixel0, pixel1, pixel2;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        i <= 0;
    end else begin
        pixel0 <= img0[i];
        pixel1 <= img1[i];
        pixel2 <= img2[i];

        if (i < 24)
            i <= i + 1;
        else
            i <= 0;
    end
end

// ================= INIT =================
initial begin
    for (j = 0; j < 25; j = j + 1) begin
        img0[j] = j;
        img1[j] = j + 1;
        img2[j] = j + 2;
    end
end

// ================= LINE BUFFERS =================
wire [7:0] lb0_1, lb0_2;
wire [7:0] lb1_1, lb1_2;
wire [7:0] lb2_1, lb2_2;

line_buffer lb0 (clk, reset, pixel0, lb0_1, lb0_2);
line_buffer lb1 (clk, reset, pixel1, lb1_1, lb1_2);
line_buffer lb2 (clk, reset, pixel2, lb2_1, lb2_2);

// ================= WINDOWS =================
wire [7:0] w0_0,w0_1,w0_2,w0_3,w0_4,w0_5,w0_6,w0_7,w0_8;
wire [7:0] w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7,w1_8;
wire [7:0] w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7,w2_8;

window_3x3 win0 (clk, reset, pixel0, lb0_1, lb0_2,
    w0_0,w0_1,w0_2,w0_3,w0_4,w0_5,w0_6,w0_7,w0_8);

window_3x3 win1 (clk, reset, pixel1, lb1_1, lb1_2,
    w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7,w1_8);

window_3x3 win2 (clk, reset, pixel2, lb2_1, lb2_2,
    w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7,w2_8);

// ================= KERNEL =================
wire signed [15:0] conv0, conv1, conv2;
wire signed [15:0] sum_conv;
wire signed [15:0] relu_out;

// Channel 0
conv3x3 c0 (
    clk, reset,
    w0_0,w0_1,w0_2,w0_3,w0_4,w0_5,w0_6,w0_7,w0_8,
    1,0,1, 0,1,0, 1,0,1,
    conv0
);

// Channel 1
conv3x3 c1 (
    clk, reset,
    w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7,w1_8,
    1,0,1, 0,1,0, 1,0,1,
    conv1
);

// Channel 2
conv3x3 c2 (
    clk, reset,
    w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7,w2_8,
    1,0,1, 0,1,0, 1,0,1,
    conv2
);

// ================= SUM =================
//assign sum_conv = conv0 + conv1 + conv2;

reg signed [15:0] sum_reg;

always @(posedge clk) begin
    sum_reg <= conv0 + conv1 + conv2;
end
// ================= RELU =================
//relu relu_inst (
//   .in(sum_conv),
//   .out(relu_out)
//);

reg signed [15:0] relu_reg;

always @(posedge clk or posedge reset) begin
    if (reset)
        relu_reg <= 0;
    else if (sum_reg > 0)
        relu_reg <= sum_reg;
    else
        relu_reg <= 0;
end
// ================= VALID CONTROL =================
reg [5:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        valid <= 0;
        final_out <= 0;
    end else begin
        count <= count + 1;

        if (count > 10) begin   // window ready
            valid <= 1;
            final_out <= relu_reg;
        end else begin
            valid <= 0;
        end
    end
end

endmodule