module tb;
parameter WIDTH_IN = 128;
parameter WIDTH_out = 128; 
                       
reg [ WIDTH_IN -1:0] x;
reg [ WIDTH_IN -1:0] y;
wire [ WIDTH_out-1:0] out;

top dut(.x(x),
                   .y(y),
                   .out(out));


               initial begin
                   $shm_open("cmul.shm");
                   $shm_probe("ACTMF");
               end
 initial begin
        $display("==============================");
        $display("    128-bit Carry-less MUL TB ");
        $display("==============================");

        // --------------------------------------------------
        // TEST CASE 1: Small example:  x = 0x000...000F, y = 0x000...000B
        // --------------------------------------------------
        x = 128'h0000_0000_0000_0000_0000_0000_0000_000F;  // polynomial 1111 = x^3 + x^2 + x + 1
        y = 128'h0000_0000_0000_0000_0000_0000_0000_000B;  // polynomial 1011 = x^3 + x + 1
        #10;
        $display("\nTEST 1");
        $display("x   = %h", x);
        $display("y   = %h", y);
        $display("reduction_in = %h", dut.reduction.in);
        $display("low = %h", dut.reduction.low);
        $display("high = %h", dut.reduction.high);
        $display("temp = %h", dut.reduction.temp);
        $display("i = %h", dut.reduction.i);
        $display("reduction_out = %h", dut.reduction.out);
        $display("out = %h\n", out);

        // --------------------------------------------------
        // TEST CASE 2: Large example with x^127 * x^64
        // --------------------------------------------------
        x = 128'h8000_0000_0000_0000_0000_0000_0000_0000;  // x^127
        y = 128'h0000_0000_0000_0000_0000_0000_0000_0001 << 64; // x^64
        #10;
        $display("TEST 2");
        $display("x   = %h", x);
        $display("y   = %h", y);
        $display("cmulout = %h", dut.cmul.out);
        $display("reduction_in = %h", dut.reduction.in);
        $display("low = %h", dut.reduction.low);
        $display("high = %h", dut.reduction.high);
        $display("temp = %h", dut.reduction.temp);
        $display("i = %h", dut.reduction.i);
        $display("reduction_out = %h", dut.reduction.out);
        $display("out = %h\n", out);

        // --------------------------------------------------
        // TEST CASE 3: Random test
        // --------------------------------------------------
        x = 128'h1234_5678_9ABC_DEF0_1122_3344_5566_7788;
        y = 128'h0F0E_0D0C_0B0A_0908_0706_0504_0302_0100;
        #10;
        $display("TEST 3");
        $display("x   = %h", x);
        $display("y   = %h", y);
        $display("reduction_in = %h", dut.reduction.in);
        $display("low = %h", dut.reduction.low);
        $display("high = %h", dut.reduction.high);
        $display("temp = %h", dut.reduction.temp);
        $display("i = %h", dut.reduction.i);
        $display("reduction_out = %h", dut.reduction.out);
        $display("out = %h\n", out);

        // --------------------------------------------------
        // END
        // --------------------------------------------------
        $finish;
    end


endmodule
