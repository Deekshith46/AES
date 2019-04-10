module top#(parameter WIDTH = 128)

            (input [WIDTH-1:0] a,
             input [WIDTH-1:0] b,
             output [WIDTH-1:0] out);

         wire[WIDTH-1:0] w1;

carry_less_mul cmul(.x(a),
                    .y(b),
                    .out(w1));
                
              reduction(.in(w1),
                        .out(out));
              endmodule
                        
