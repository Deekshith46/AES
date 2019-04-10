module reduction#(parameter WIDTH_IN = 256,
                  parameter WIDTH_OUT = 128)

                  (input [WIDTH_IN-1:0] in,
                   output reg [WIDTH_OUT-1:0] out);

reg[WIDTH_OUT-1:0] low ;
reg[WIDTH_OUT-1:0] high;
reg[WIDTH_OUT-1:0] temp;

   integer i ;
    always@(*) begin
              low = in[127:0];
              high = in[255:128];
              temp = 128'b0;

            for(i= 0; i < 128; i=i+1)
            begin
                if(high[i])
                begin
                    //Fold x^{128+i} = x^{i+7} + x^{i+2} + x^{i+1} + x^i 
                  
                      if(i < 128)
                        begin
                         temp[i] =  1'b1;
                         end                                 

                     if(i+1 < 128)
                        begin
                        temp[i+1] = 1'b1;
                        end
                    if(i+2 < 128)
                        begin
                        temp[i+2] =  1'b1;
                        end
                    if(i+7 < 128) 
                        begin
                        temp[i+7] =  1'b1;
                         end
                end
                    else 
                        begin
                           out =  low ^ temp;    
                         end
                                     
            end
             out =  low ^ temp  ;
    end
        
    endmodule
