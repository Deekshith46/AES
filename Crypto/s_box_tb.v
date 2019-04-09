module s_box_tb;
reg [7:0] in;
wire [7:0] out;

integer i ;

aes_sbox_forward dut(.in(in), .out(out));

initial begin
    $shm_open("s_box.shm");
    $shm_probe("ACTMF");
end

initial begin
    for(i = 0 ; i <= 8'hFF ; i = i +1)
    begin
        in = i;
#5;
$display("in = %h , out = %h",in,out);
    end
    #1000;
    $finish();
end 
endmodule
