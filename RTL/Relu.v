module relu (
    input signed [15:0] in,
    output signed [15:0] out
);

assign out = (in > 0) ? in : 0;

endmodule