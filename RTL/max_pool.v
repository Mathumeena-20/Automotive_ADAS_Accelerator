module max_pool (
    input signed [15:0] a,b,c,d,
    output signed [15:0] max_out
);

assign max_out = (a>b ? (a>c ? (a>d?a:d) : (c>d?c:d)) :
                         (b>c ? (b>d?b:d) : (c>d?c:d)));

endmodule