module carry_less_mul#( parameter WIDTH_IN = 128,
                        parameter WIDTH_OUT = 256 )
                       
                        (input [ WIDTH_IN -1:0] x,
                         input [ WIDTH_IN -1:0] y,
                         output[ WIDTH_OUT-1:0] out);

          reg[WIDTH_OUT-1:0] temp;
          
          integer i; 

         always@(*) begin
                temp = 'd0;

               for(i=0 ; i<WIDTH_IN ;i=i+1)
               begin
                   if(y[i]) begin
                       temp = temp ^ ({{WIDTH_IN{1'b0}},x}<<i);                    
               end
         end
     end

         assign out = temp ; 
                     
 endmodule
