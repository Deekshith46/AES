module ghash_top_datapath#(parameter WIDTH = 128)
                           (input [WIDTH-1:0] h_reg_data,
                            input h_reg_en,
                            input [WIDTH-1:0] aad_data,
                            input [WIDTH-1:0] cipher_text,
                            input [WIDTH-1:0] length_data,
                            input [1:0] mux_sel,
                            input ac_reg_en,
                            input ac_clr,
                            input s_reg_en,
                            output s_reg_out);


wire [WIDTH-1:0] mux_out,xor_out,ac_data_out_w,h_reg_out,gf_out,s_reg_out_w;

mux mux(.in1(aad_data),
        .in2(cipher_text),
        .in3(length_data),
        .mux_sel(mul_sel),
        .out(mux_out));

xor_op xor_op(.a(mux_out),
              .b(s_reg_data_out_w),
              .out(xor_out));

ac_reg ac_reg(.clk(clk),
              .rst(rst),
              . ac_en(ac_reg_en),
              . clr_ac(ac_clr),
              . ac_data_in(xor_out),
              . ac_data_out(ac_data_out_w));

h_reg h_eg   ( .clk(clk),
              .rst(rst),
              .h_en(h_reg_en),
              .h_data(h_reg_data),
              .h_out(h_reg_out));

top gf (.x(h_reg_out),
        .y(ac_data_out_w),
        .out(gf_out));


s_reg s_reg   ( .clk(clk),
              .rst(rst),
              .s_en(s_reg_en),
              .s_data(gf_out),
              .s_out(s_reg_data_out_w));



assign s_reg_out = s_reg_data_out_w; 

endmodule
