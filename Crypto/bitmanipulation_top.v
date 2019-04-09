module top #(parameter XLEN = 32,
             parameter OP_WIDTH =5)

            (input [ XLEN-1 : 0] rs1_in,
             input [ XLEN-1 : 0] rs2_in,
             input [ OP_WIDTH-1 :0] op_in,
             output reg [ XLEN-1 :0 ] out);

         `include "bitmani_func.v"

         always@(*) begin
             case(op_in)
                 5'b00001 : begin out = rotate_left(rs1_in,rs2_in,XLEN);end

                 5'b00010 : begin out = rotate_left_word(rs1_in,rs2_in,XLEN); end

                 5'b00011 : begin out = rotate_right(rs1_in,rs2_in,XLEN); end 

                 5'b00100 : begin out = rotate_right_imm(rs1_in,rs2_in[5:0],XLEN); end 

                 5'b00101 : begin out =  rotate_right_imm_word(rs1_in,rs2_in[5:0],XLEN);end

                 5'b00110 : begin out = rotate_right_word(rs1_in,rs2_in,XLEN);end

                 5'b00111 : begin out = and_not(rs1_in,rs2_in,XLEN);end

                 5'b01000 : begin out = or_not(rs1_in,rs2_in,XLEN);end

                 5'b01001 : begin out = xor_nor(rs1_in,rs2_in,XLEN);end
 
                 5'b01010 : begin out = pack(rs1_in, rs2_in,XLEN);end

                 5'b01011 : begin out = packh(rs1_in ,rs2_in,XLEN);end

                 5'b01100 : begin out = packw(rs1_in,rs2_in,XLEN);end

                 5'b01101 : begin out = brev8(rs1_in,XLEN);end

                 5'b01110 : begin out = rev8(rs1_in,XLEN);end

                 5'b01111 : begin out = zip(rs1_in,XLEN);end

                 5'b10000 : begin out = unzip(rs1_in,XLEN);end

              endcase
         end

         endmodule
          

