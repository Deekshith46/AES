module mux#(parameter WIDTH = 128)
            (input [WIDTH-1:0] in1,
             input [WIDTH-1:0] in2,
             input [WIDTH-1:0] in3,
             input [1:0] mux_sel, 
             output reg[WIDTH-1:0] out);

  always@(*)begin
      case(mux_sel)
          2'b00 : begin out = in1; end
          2'b01 : begin out = in2; end
          2'b10 : begin out = in2; end
      endcase
  end
  endmodule


