
module tb_ghash_top;

    parameter  WIDTH = 128;

    reg                  clk;
    reg                  rst;

    reg  [WIDTH-1:0]     h_reg_data;
    reg                  h_reg_en;

    reg  [WIDTH-1:0]     aad_data;
    reg  [WIDTH-1:0]     cipher_text;
    reg  [WIDTH-1:0]     length_data;
    reg  [1:0]           mux_sel;

    reg                  ac_reg_en;
    reg                  ac_clr;
    reg                  s_reg_en;

    wire [WIDTH-1:0]     s_reg_out;

    // DUT
    ghash_top_datapath #(.WIDTH(WIDTH)) dut (
        .clk        (clk),
        .rst        (rst),
        .h_reg_data (h_reg_data),
        .h_reg_en   (h_reg_en),
        .aad_data   (aad_data),
        .cipher_text(cipher_text),
        .length_data(length_data),
        .mux_sel    (mux_sel),
        .ac_reg_en  (ac_reg_en),
        .ac_clr     (ac_clr),
        .s_reg_en   (s_reg_en),
        .s_reg_out  (s_reg_out)
    );

    initial begin
        $shm_open("ghas.shm");
        $shm_probe("ACTMF");
    end
    // clock: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // main stimulus
    initial begin
        $display("====================================");
        $display("        GHASH TOP DATAPATH TB       ");
        $display("====================================");

        // initial values
        rst         = 1;
        h_reg_en    = 0;
        ac_reg_en   = 0;
        ac_clr      = 0;
        s_reg_en    = 0;
       // mux_sel     = 2'b00;
        h_reg_data  = {WIDTH{1'b0}};
        aad_data    = {WIDTH{1'b0}};
        cipher_text = {WIDTH{1'b0}};
        length_data = {WIDTH{1'b0}};

        // reset
        #20;
        rst = 0;
        #10;

        // ----------------------------
        // STEP 1: load H into H_REG
        // ----------------------------
        h_reg_data = 128'h0F0E_0D0C_0B0A_0908_0706_0504_0302_0100;  // example H
        h_reg_en   = 1;
        #10;
        h_reg_en   = 0;  // hold H
        //$display("h_reg = %0h",.dut.ghash_top_datapath.h_reg_out);

        // ----------------------------
        // STEP 2: clear AC (start GHASH)
        // ----------------------------
        ac_clr    = 1;
        #10;
        ac_clr    = 0;

        // ----------------------------
        // STEP 3: process one AAD block
        // ----------------------------
        aad_data  = 128'h1111_2222_3333_4444_5555_6666_7777_8888;
        mux_sel   = 2'b00;   // select AAD
        ac_reg_en = 1;
        s_reg_en  = 1;
        #10;                 // one cycle
        ac_reg_en = 0;
        s_reg_en  = 0;

        // ----------------------------
        // STEP 4: process one CIPHERTEXT block
        // ----------------------------
        cipher_text = 128'hAAAA_BBBB_CCCC_DDDD_EEEE_FFFF_0000_1111;
        mux_sel     = 2'b01; // select Cipher
        ac_reg_en   = 1;
        s_reg_en    = 1;
        #10;
        ac_reg_en   = 0;
        s_reg_en    = 0;

        // ----------------------------
        // STEP 5: process LENGTH block
        // len(AAD)=128 bits, len(CIPH)=128 bits example
        // ----------------------------
        length_data = {64'd128, 64'd128}; // [len(A)||len(C)] in bits
        mux_sel     = 2'b10; // select Length
        ac_reg_en   = 1;
        s_reg_en    = 1;
        #10;
        ac_reg_en   = 0;
        s_reg_en    = 0;

        // wait a bit and print final tag
        #20;
        $display("------------------------------------");
        $display("Final Tag (s_reg_out) = %h", s_reg_out);
        $display("------------------------------------");

        #20;
        $finish;
    end

    // optional monitor for debugging
    initial begin
        $monitor("t=%0t  mux_sel=%0d  ac_en=%b s_en=%b  tag=%h",
                  $time, mux_sel, ac_reg_en, s_reg_en, s_reg_out);
    end

endmodule

