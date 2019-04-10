module tb;
        parameter WIDTH = 128;
        reg clk;
        reg rst;
        reg [WIDTH-1:0] h_reg_data;
        reg h_reg_en;
        reg [WIDTH-1:0] aad_data;
        reg [WIDTH-1:0] cipher_text;
        reg [WIDTH-1:0] length_data;
        reg [1:0] mux_sel;
        reg ac_reg_en;
        reg ac_clr;
        reg s_reg_en;
        wire s_reg_out;

ghash_top_datapath dut (.clk(clk),
                        .rst(rst),
                        .h_reg_data(h_reg_data),
                        .h_reg_en(h_reg_en),
                        .aad_data(aad_data),
                        .cipher_text(cipher_text),
                        .length_data(length_data),
                        .mux_sel(mux_sel),
                        .ac_reg_en(ac_reg_en),
                        .ac_clr(ac_clr),
                        .s_reg_en(s_reg_en),
                        .s_reg_out(s_reg_out));

    initial begin
        $shm_open("ghash1.shm");
        $shm_probe("ACTMF");
    end

    always begin
        clk =0;
        forever #5 clk = ~clk;
    end
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
        //mux_sel     = 2'b00;
        h_reg_data  = {WIDTH{1'b0}};
        aad_data    = {WIDTH{1'b0}};
        cipher_text = {WIDTH{1'b0}};
        length_data = {WIDTH{1'b0}};

        #20
        rst = 0;
        #10

        h_reg_data = 128'h0F0E_0D0C_0B0A_0908_0706_0504_0302_0100;  // example H
        h_reg_en   = 1;
        #10;
        h_reg_en   = 0; 

        ac_clr = 1;
#10
        ac_clr = 0;
        
        aad_data  = 128'h1111_2222_3333_4444_5555_6666_7777_8888;
        mux_sel   = 2'b00;   // select AAD
        ac_reg_en = 1;
        s_reg_en  = 1;
        #10;                 // one cycle
        ac_reg_en = 0;
        s_reg_en  = 0;
#20
$finish();
        
    end
endmodule
