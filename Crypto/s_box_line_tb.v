module linear_tb;

reg [7:0] in;
wire[7:0] out;

s_box_liner dut(.in(in),.out(out));

initial begin

    in = 'd58;
#10;
    $display("input = %0h , output = %0h",in,out);
end
endmodule
