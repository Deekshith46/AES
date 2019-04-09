module top#(parameter WIDTH = 128)
            (input [WIDTH-1:0] x,
             input [WIDTH-1:0] y,
             output [WIDTH-1:0] out);

         wire[255:0] w1;

carry_less_mul cmul(.x(x),
                    .y(y),
                    .out(w1));
                
reduction     reduction (.in(w1),
                        .out(out));
              
 endmodule

                        
