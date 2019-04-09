module aes32esi_executed(
    input [31:0] rs1,
    input [31:0] rs2,
    input [1:0] bs,
    output  [31:0] result 
);

wire [7:0] b0 = rs2[7:0];
wire [7:0] b1 = rs2[15:8];
wire [7:0] b2 = rs2[23:16];
wire [7:0] b3 = rs2[31:24];

reg [31:0] select_byte;

always@(*)begin
        case(bs)
                2'b00 : select_byte = b0;
                2'b01 : select_byte = b1;
                2'b10 : select_byte = b2;
                2'b11 : select_byte = b3;
                default : select_byte = 8'h0;
            endcase
end


wire [7:0] s_out;

aes_sbox_forward execution(.in(select_byte), .out(s_out));

reg[31:0] placed;

always@(*) begin
        case(bs)
               2'b00 : placed = {24'h0, s_out};
               2'b01 : placed = {16'h0, s_out , 8'h0 };
               2'b10 : placed = {8'h0, s_out , 16'h0};
               2'b11 : placed = {s_out, 24'h0};
               default : placed = 32'b0;
           endcase
        end
  
        assign result = placed ^ rs2;

endmodule


