///////////////////ROL////////////////////////////
function [XLEN-1 : 0] rotate_left;
    input[XLEN-1:0] rs1;
    input[XLEN-1:0] rs2;
    input integer XLEN;
        
    reg[5:0] shamt;

    begin
    if ( XLEN ==32)
        shamt = rs2[4:0];
    else
        shamt = rs2[5:0];
    
    rotate_left = (rs1 << shamt) | (rs1 >> (XLEN - shamt));
end
endfunction

/////////////////ROLW///////////////////////////////
function [XLEN-1:0] rotate_left_word;
    input[XLEN-1:0] rs1;
    input[XLEN-1:0] rs2;
   input integer XLEN;
    
    reg [4:0] shamt;
    reg [31:0] rs1_reg;
    reg [31:0] rd;

    begin

       rs1_reg = rs1[31:0];

       shamt = rs2[4:0];

       rd = (rs1_reg << shamt ) | (rs1_reg >> (32 - shamt));

       rotate_left_word = {{32{rd[31]}},rd};

     end
endfunction
    
/////////////////////////////////////ROR////////////////////////
function [XLEN-1 :0] rotate_right;
    input [XLEN-1:0] rs1;
    input [XLEN-1:0] rs2;
    input integer XLEN;

    reg[5:0] shamt;

    begin
        if(XLEN==32)begin
            shamt = rs2[4:0];
        end
        else begin
            shamt = rs2[5:0];
        end

        rotate_right = (rs1 >> shamt | rs1 << (XLEN-shamt));
    end
endfunction

////////////////////////////RORI///////////////////////////////////          
function [XLEN-1:0] rotate_right_imm;
    input[XLEN-1:0] rs1;
    input[5:0] shmat;
    input integer XLEN;

        reg[5:0] shmat_reg;
    begin
        if(XLEN==32)
        begin
            shmat_reg = shmat[4:0];
        end
        else 
        begin
            shmat_reg = shmat[5:0];
        end

        rotate_right_imm = (rs1 >> shmat_reg | rs1 << (XLEN - shmat_reg));
    end 
endfunction

///////////////////////////RORIW//////////////////////////////
function [XLEN-1:0] rotate_right_imm_word;
    input[XLEN-1:0] rs1;
    input[5:0] shmat;
    input integer XLEN;

    reg [31:0] rs1_reg ;
    reg [31:0] rd;

    begin
        rs1_reg = rs1[31:0];
       

        rd = (rs1_reg >> shmat) | (rs1_reg << (32-shmat));

        rotate_right_imm_word = {{32{rd[31]}},rd};

    end
endfunction

//////////////////////////RORW///////////////////////////////////
function [XLEN-1:0] rotate_right_word;
    input[XLEN-1:0] rs1;
    input[XLEN-1:0] rs2;
    input integer XLEN;

    reg [4:0] shamt;
    reg [31:0] rs1_reg;
    reg [31:0] rd;


    begin
        rs1_reg = rs1[31:0];
        shamt = rs2[4:0];
        
        rd = (rs1_reg >> shamt) | (rs1_reg << (32-shamt));

        rotate_right_word = {{32{rd[31]}},rd};
        
    end
endfunction

//////////////////////ANDN////////////////////////////////////////////
function [XLEN-1:0] and_not;
    input [XLEN-1:0] rs1;
    input [XLEN-1:0] rs2;
    input integer XLEN;

    begin

    and_not = rs1 & (~rs2);
    
    end 
    
    endfunction
//////////////////////////////////////////////Or_NOT////////////////////
function [XLEN-1:0] or_not;
    input[XLEN-1:0] rs1;
    input[XLEN-1:0] rs2;
    input integer XLEN;

    begin
        or_not = rs1 | (~rs2);
    end
endfunction

///////////////////////////////////////XOR_NOT/////////////////////////
function [XLEN-1:0] xor_nor;
    input[XLEN-1:0] rs1;
    input[XLEN-1:0] rs2;
    input integer XLEN ;

    begin
        xor_nor = ~(rs1 ^ rs2);
    end
endfunction

/////////////////////////////////PACK////////////////////////////////
function [XLEN-1:0] pack;
    input[XLEN-1:0] rs1;
    input[XLEN-1:0] rs2;
    input integer XLEN;

        begin
            if(XLEN ==32) begin
               pack = {rs2[15:0] , rs1[15:0]};
           end
           else begin
               pack = {rs2[31:0] , rs1[31:0]};
           end
    end
endfunction

/////////////////////////PACKH///////////////////////////
function [XLEN-1:0] packh;
    input[XLEN-1:0] rs1;
    input[XLEN-1:0] rs2;
    input integer XLEN;

    begin
        if(XLEN==32)begin
            packh = {16'b0,{rs2[7:0],rs1[7:0]}};
        end
        else begin
            packh = {48'b0,{rs2[7:0],rs1[7:0]}};
         end
    end
endfunction

////////////////////////PACKW//////////////////////////

function[XLEN-1:0] packw;
    input[XLEN-1:0] rs1;
    input[XLEN-1:0] rs2;
    input integer XLEN;

    begin
        packw = {32'b0,{rs2[15:0],rs1[15:0]}};
    end
endfunction

/////////////////////BREV8//////////////////////////

function  [XLEN-1:0] brev8;
  input [XLEN-1:0] rs1;
  input integer XLEN;

  begin
    if (XLEN == 32)
      // Reverse bits within each byte for 32-bit input
      brev8 = { 
                {rs1[24], rs1[25], rs1[26], rs1[27], rs1[28], rs1[29], rs1[30], rs1[31]},
                {rs1[16], rs1[17], rs1[18], rs1[19], rs1[20], rs1[21], rs1[22], rs1[23]},
                {rs1[8],  rs1[9],  rs1[10], rs1[11], rs1[12], rs1[13], rs1[14], rs1[15]},
                {rs1[0],  rs1[1],  rs1[2],  rs1[3],  rs1[4],  rs1[5],  rs1[6],  rs1[7]}
              };
    else
      // Reverse bits within each byte for 64-bit input
      brev8 = {
                {rs1[56], rs1[57], rs1[58], rs1[59], rs1[60], rs1[61], rs1[62], rs1[63]},
                {rs1[48], rs1[49], rs1[50], rs1[51], rs1[52], rs1[53], rs1[54], rs1[55]},
                {rs1[40], rs1[41], rs1[42], rs1[43], rs1[44], rs1[45], rs1[46], rs1[47]},
                {rs1[32], rs1[33], rs1[34], rs1[35], rs1[36], rs1[37], rs1[38], rs1[39]},
                {rs1[24], rs1[25], rs1[26], rs1[27], rs1[28], rs1[29], rs1[30], rs1[31]},
                {rs1[16], rs1[17], rs1[18], rs1[19], rs1[20], rs1[21], rs1[22], rs1[23]},
                {rs1[8],  rs1[9],  rs1[10], rs1[11], rs1[12], rs1[13], rs1[14], rs1[15]},
                {rs1[0],  rs1[1],  rs1[2],  rs1[3],  rs1[4],  rs1[5],  rs1[6],  rs1[7]}
              };
  end
endfunction

/////////////////////////////////////////////////rev8//////////////////////////////////
function [XLEN-1:0] rev8;
    input[XLEN-1:0] rs1;
    input integer XLEN;
    
    begin
        if(XLEN==32)begin
            rev8 = {rs1[7:0],rs1[15:8],rs1[23:16],rs1[31:24]};
        end
        else begin
            rev8 = { rs1[7:0], rs1[15:8], rs1[23:16], rs1[31:24],
                     rs1[39:32], rs1[47:40], rs1[55:48], rs1[63:56] };
        end
    end
endfunction

/////////////////////////////////////ZIP////////////////////////////

function [XLEN-1:0] zip;
    input[XLEN-1:0] rs1;
    input integer XLEN;
    
    
    reg [31:0] result;

    integer i;

    begin
        result = 'd0;
        for(i=0; i<(XLEN/2); i=i+1)
        begin
            result[2*i] = rs1[i];
            result[2*i+1] =rs1[i+(XLEN/2)];
        end
        
        zip = result;
    end
endfunction

////////////////////////////////////UNZIP/////////////////////////

function [XLEN-1:0] unzip;
    input[XLEN-1:0] rs1;
    input integer XLEN;

    reg[31:0] result;

    integer i;

    begin
        result = 'd0;
        for(i=0; i<(XLEN/2); i=i+1)
        begin
            result[i] = rs1[2*i];
            result[i+(XLEN/2)] =  rs1[2*i+1];
        end
        unzip = result;
    end
endfunction

