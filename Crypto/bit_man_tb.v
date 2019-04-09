

module tb;

  // ------------------------------------------------------------------
  // DUTs
  // ------------------------------------------------------------------
  localparam OP_WIDTH = 5;

  // 32-bit
  localparam XLEN32 = 32;
  reg  [XLEN32-1:0] rs1_32, rs2_32;
  reg  [OP_WIDTH-1:0] op_32;
  wire [XLEN32-1:0] rd_32;

  top #(.XLEN(XLEN32), .OP_WIDTH(OP_WIDTH)) dut32 (
    .rs1_in(rs1_32), .rs2_in(rs2_32), .op_in(op_32), .out(rd_32)
  );

  // 64-bit
  localparam XLEN64 = 64;
  reg  [XLEN64-1:0] rs1_64, rs2_64;
  reg  [OP_WIDTH-1:0] op_64;
  wire [XLEN64-1:0] rd_64;

  top #(.XLEN(XLEN64), .OP_WIDTH(OP_WIDTH)) dut64 (
    .rs1_in(rs1_64), .rs2_in(rs2_64), .op_in(op_64), .out(rd_64)
  );


    initial begin
        $shm_open("bit_man.shm");
        $shm_probe("ACTMF");
    end
  // ------------------------------------------------------------------
  // Linear stimulus
  // ------------------------------------------------------------------
  initial begin
    // ===================== ROL (XLEN=32) =====================
    $display("\n---------------- ROL (XLEN=32, op=00001) ----------------");
    $display(" time | sh |                 rs1 |       rs2 |                 rd");
    $display("----------------------------------------------------------------");
    op_32 = 5'b00001; // ROL
    rs1_32 = 32'hA5A5_A5A5; rs2_32 =  0; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hA5A5_A5A5; rs2_32 =  1; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hA5A5_A5A5; rs2_32 =  4; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hA5A5_A5A5; rs2_32 =  8; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hA5A5_A5A5; rs2_32 = 16; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hA5A5_A5A5; rs2_32 = 31; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hA5A5_A5A5; rs2_32 = 36; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32); // wrap ->4
    rs1_32 = 32'hA5A5_A5A5; rs2_32 = 63; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32); // wrap ->31

    // ===================== ROR (XLEN=32) =====================
    $display("\n---------------- ROR (XLEN=32, op=00011) ----------------");
    $display(" time | sh |                 rs1 |       rs2 |                 rd");
    $display("----------------------------------------------------------------");
    op_32 = 5'b00011; // ROR
    rs1_32 = 32'hDEAD_BEEF; rs2_32 =  0; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hDEAD_BEEF; rs2_32 =  1; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hDEAD_BEEF; rs2_32 =  4; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hDEAD_BEEF; rs2_32 =  8; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hDEAD_BEEF; rs2_32 = 31; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);
    rs1_32 = 32'hDEAD_BEEF; rs2_32 = 36; #5; $display("%4t | %2d | %h | %8h | %h", $time, rs2_32[4:0], rs1_32, rs2_32, rd_32);

    // ===================== ROL (XLEN=64) =====================
    $display("\n---------------- ROL (XLEN=64, op=00001) ----------------");
    $display(" time | sh |                         rs1 |                 rs2 |                         rd");
    $display("------------------------------------------------------------------------------------------------");
    op_64 = 5'b00001; // ROL
    rs1_64 = 64'h0123_4567_89AB_CDEF; rs2_64 =  0;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'h0123_4567_89AB_CDEF; rs2_64 =  1;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'h0123_4567_89AB_CDEF; rs2_64 = 16;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'h0123_4567_89AB_CDEF; rs2_64 = 31;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'h0123_4567_89AB_CDEF; rs2_64 = 63;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'h0123_4567_89AB_CDEF; rs2_64 = 68;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64); // wrap ->4

    // ===================== ROR (XLEN=64) =====================
    $display("\n---------------- ROR (XLEN=64, op=00011) ----------------");
    $display(" time | sh |                         rs1 |                 rs2 |                         rd");
    $display("------------------------------------------------------------------------------------------------");
    op_64 = 5'b00011; // ROR
    rs1_64 = 64'hFEDC_BA98_7654_3210; rs2_64 =  0;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'hFEDC_BA98_7654_3210; rs2_64 =  1;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'hFEDC_BA98_7654_3210; rs2_64 =  8;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'hFEDC_BA98_7654_3210; rs2_64 = 32;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'hFEDC_BA98_7654_3210; rs2_64 = 63;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[5:0], rs1_64, rs2_64, rd_64);

    // ===================== ROLW (XLEN=64) =====================
    // mask with rs2[4:0]; sign-extend bit31 of 32-bit result to 64 bits
    $display("\n---------------- ROLW (XLEN=64, op=00010) ----------------");
    $display(" time | sh |                         rs1 |                 rs2 |                         rd");
    $display("------------------------------------------------------------------------------------------------");
    op_64 = 5'b00010; // ROLW
    rs1_64 = 64'h0000_0000_A5A5_0001; rs2_64 =  0;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'h0000_0000_A5A5_0001; rs2_64 =  1;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'h0000_0000_A5A5_0001; rs2_64 =  4;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'h0000_0000_A5A5_0001; rs2_64 =  8;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);
    rs1_64 = 64'h0000_0000_A5A5_0001; rs2_64 = 31;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);
    // >31 wraps via [4:0]
    rs1_64 = 64'h0000_0000_A5A5_0001; rs2_64 = 36;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);
    // show sign-extend (force bit31=1 after rotate)
    rs1_64 = 64'h0000_0000_F123_4567; rs2_64 =  5;  #5; $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);


    // ===================== RORIW (XLEN=64, op=00101) =====================
    // Rotate right immediate word — operates on lower 32 bits only,
    // and sign-extends bit 31 to upper 32 bits of the 64-bit result.
    $display("\n---------------- RORIW (XLEN=64, op=00101) ----------------");
    $display(" time | sh |                         rs1 |                 imm |                         rd");
    $display("------------------------------------------------------------------------------------------------");
    op_64 = 5'b00101; // RORIW (rotate right immediate word)

    // 32-bit word inside 64-bit register
    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 =  0;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 =  1;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 =  4;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 =  8;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 = 31;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 = 36;  #5; // wraps to 4
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    // check sign extension (bit 31 = 1)
    rs1_64 = 64'h0000_0000_F123_4567; rs2_64 =  5;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);



 // ===================== RORW (XLEN=64, op=00110) =====================
    // Rotate right on lower 32 bits of rs1 by rs2[4:0], then sign-extend bit31
    $display("\n---------------- RORW (XLEN=64, op=00110) ----------------");
    $display(" time | sh |                         rs1 |                 rs2 |                         rd");
    $display("------------------------------------------------------------------------------------------------");
    op_64 = 5'b00110; // RORW

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 =  0;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 =  1;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 =  4;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 =  8;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 = 16;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 = 31;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    // wrap around (rs2 > 31)
    rs1_64 = 64'h0000_0000_DEAD_BEEF; rs2_64 = 36;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);

    // check sign extension with MSB=1
    rs1_64 = 64'h0000_0000_F123_4567; rs2_64 =  5;  #5;
    $display("%4t | %2d | %h | %h | %h", $time, rs2_64[4:0], rs1_64, rs2_64, rd_64);    


    // ===================== ANDN (XLEN=64, op=00111) =====================
    // Performs bitwise AND between rs1 and bitwise NOT of rs2
    $display("\n---------------- ANDN (XLEN=64, op=00111) ----------------");
    $display(" time |                         rs1 |                         rs2 |                         rd");
    $display("------------------------------------------------------------------------------------------------");

    op_64 = 5'b00111; // ANDN

    rs1_64 = 64'hFFFF_FFFF_0000_0000; rs2_64 = 64'h0000_0000_FFFF_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'hA5A5_A5A5_5A5A_5A5A; rs2_64 = 64'hFFFF_0000_FFFF_0000; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h1234_5678_9ABC_DEF0; rs2_64 = 64'hFFFF_FFFF_FFFF_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'hFFFF_0000_FFFF_0000; rs2_64 = 64'h0000_FFFF_0000_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'hDEAD_BEEF_1234_5678; rs2_64 = 64'h0F0F_0F0F_0F0F_0F0F; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_FFFF_FFFF; rs2_64 = 64'hFFFF_0000_0000_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);


  // ===================== ORN (XLEN=64, op=01000) =====================
    // Performs bitwise OR between rs1 and bitwise NOT of rs2
    $display("\n---------------- ORN (XLEN=64, op=01000) ----------------");
    $display(" time |                         rs1 |                         rs2 |                         rd");
    $display("------------------------------------------------------------------------------------------------");

    op_64 = 5'b01000; // ORN

    rs1_64 = 64'hFFFF_FFFF_0000_0000; rs2_64 = 64'h0000_0000_FFFF_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'hA5A5_A5A5_5A5A_5A5A; rs2_64 = 64'hFFFF_0000_FFFF_0000; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h1234_5678_9ABC_DEF0; rs2_64 = 64'hFFFF_FFFF_FFFF_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'hFFFF_0000_FFFF_0000; rs2_64 = 64'h0000_FFFF_0000_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'hDEAD_BEEF_1234_5678; rs2_64 = 64'h0F0F_0F0F_0F0F_0F0F; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_FFFF_FFFF; rs2_64 = 64'hFFFF_0000_0000_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// ===================== XNOR (XLEN=64, op=01001) =====================
    // Performs bitwise XNOR between rs1 and rs2 (inverts XOR result)
    $display("\n---------------- XNOR (XLEN=64, op=01001) ----------------");
    $display(" time |                         rs1 |                         rs2 |                         rd");
    $display("------------------------------------------------------------------------------------------------");

    op_64 = 5'b01001; // XNOR

    rs1_64 = 64'hFFFF_FFFF_0000_0000; rs2_64 = 64'h0000_0000_FFFF_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'hA5A5_A5A5_5A5A_5A5A; rs2_64 = 64'hFFFF_0000_FFFF_0000; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h1234_5678_9ABC_DEF0; rs2_64 = 64'hFFFF_FFFF_FFFF_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'hFFFF_0000_FFFF_0000; rs2_64 = 64'h0000_FFFF_0000_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'hDEAD_BEEF_1234_5678; rs2_64 = 64'h0F0F_0F0F_0F0F_0F0F; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

    rs1_64 = 64'h0000_0000_FFFF_FFFF; rs2_64 = 64'hFFFF_0000_0000_FFFF; #5;
    $display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// ===================== PACK (XLEN=32, op=01010) =====================
$display("\n---------------- PACK (XLEN=32, op=01010) ----------------");
$display(" time |                 rs1 |                 rs2 |                 rd");
$display("----------------------------------------------------------------");

op_32 = 5'b01010; // PACK
rs1_32 = 32'hAAAA_BBBB; rs2_32 = 32'h1111_2222; #5;
$display("%4t | %h | %h | %h", $time, rs1_32, rs2_32, rd_32);

rs1_32 = 32'h1234_5678; rs2_32 = 32'h9ABC_DEF0; #5;
$display("%4t | %h | %h | %h", $time, rs1_32, rs2_32, rd_32);

rs1_32 = 32'h0000_FFFF; rs2_32 = 32'hFFFF_0000; #5;
$display("%4t | %h | %h | %h", $time, rs1_32, rs2_32, rd_32);

rs1_32 = 32'h1357_9BDF; rs2_32 = 32'h2468_ACED; #5;
$display("%4t | %h | %h | %h", $time, rs1_32, rs2_32, rd_32);


// ===================== PACK (XLEN=64, op=01010) =====================
$display("\n---------------- PACK (XLEN=64, op=01010) ----------------");
$display(" time |                         rs1 |                         rs2 |                         rd");
$display("------------------------------------------------------------------------------------------------");

op_64 = 5'b01010; // PACK
rs1_64 = 64'hAAAA_BBBB_CCCC_DDDD; rs2_64 = 64'h1111_2222_3333_4444; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

rs1_64 = 64'h1234_5678_9ABC_DEF0; rs2_64 = 64'hFEDC_BA98_7654_3210; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

rs1_64 = 64'h0000_FFFF_FFFF_0000; rs2_64 = 64'hFFFF_0000_0000_FFFF; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

rs1_64 = 64'h1111_0000_2222_3333; rs2_64 = 64'hAAAA_BBBB_CCCC_DDDD; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);


// ===================== PACKH (XLEN=64, op=01011) =====================
// rd = zero_extend_64( { rs2[7:0], rs1[7:0] } )
$display("\n---------------- PACKH (XLEN=64, op=01011) ----------------");
$display(" time |                         rs1 |                         rs2 |                         rd");
$display("------------------------------------------------------------------------------------------------");

op_64 = 5'b01011; // PACKH

// rs2[7:0]=EE, rs1[7:0]=11 -> rd = ...0000_0000_0000_EE11
rs1_64 = 64'hAAAA_BBBB_CCCC_DD11; rs2_64 = 64'h1111_2222_3333_44EE; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=00, rs1[7:0]=00 -> rd = ...0000
rs1_64 = 64'h0000_0000_0000_0000; rs2_64 = 64'hFFFF_FFFF_FFFF_FF00; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=FF, rs1[7:0]=00 -> rd = ...00FF
rs1_64 = 64'h1234_5678_9ABC_DE00; rs2_64 = 64'h0000_0000_0000_00FF; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=34, rs1[7:0]=12 -> rd = ...0034_12
rs1_64 = 64'hFFFF_FFFF_FFFF_FF12; rs2_64 = 64'h0000_0000_0000_0034; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=A5, rs1[7:0]=5A -> rd = ...00A5_5A
rs1_64 = 64'hDEAD_BEEF_1234_565A; rs2_64 = 64'h0000_0000_0000_00A5; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=01, rs1[7:0]=FF -> rd = ...0001_FF
rs1_64 = 64'h0000_0000_0000_00FF; rs2_64 = 64'h0000_0000_0000_0001; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);




// ===================== PACKw (XLEN=64, op=01100) =====================
// rd = zero_extend_64( { rs2[16:0], rs1[16:0] } )
$display("\n---------------- PACKH (XLEN=64, op=01100) ----------------");
$display(" time |                         rd |                         rs1 |                         rs2");
$display("------------------------------------------------------------------------------------------------");

op_64 = 5'b01100; // PACKH

// rs2[7:0]=EE, rs1[7:0]=11 -> rd = ...0000_0000_0000_EE11
rs1_64 = 64'hAAAA_BBBB_CCCC_DD11; rs2_64 = 64'h1111_2222_3333_44EE; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=00, rs1[7:0]=00 -> rd = ...0000
rs1_64 = 64'h0000_0000_0000_0000; rs2_64 = 64'hFFFF_FFFF_FFFF_FF00; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=FF, rs1[7:0]=00 -> rd = ...00FF
rs1_64 = 64'h1234_5678_9ABC_DE00; rs2_64 = 64'h0000_0000_0000_00FF; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=34, rs1[7:0]=12 -> rd = ...0034_12
rs1_64 = 64'hFFFF_FFFF_FFFF_FF12; rs2_64 = 64'h0000_0000_0000_0034; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=A5, rs1[7:0]=5A -> rd = ...00A5_5A
rs1_64 = 64'hDEAD_BEEF_1234_565A; rs2_64 = 64'h0000_0000_0000_00A5; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);

// rs2[7:0]=01, rs1[7:0]=FF -> rd = ...0001_FF
rs1_64 = 64'h0000_0000_0000_00FF; rs2_64 = 64'h0000_0000_0000_0001; #5;
$display("%4t | %h | %h | %h", $time, rs1_64, rs2_64, rd_64);



// ===================== BREV8 (XLEN=64, op=01101) =====================
// Reverse bits within each byte of rs1
$display("\n---------------- BREV8 (XLEN=64, op=01101) ----------------");
$display(" time |                         rs1 |                         rd");
$display("------------------------------------------------------------------------------------------------");

op_64 = 5'b01101; // BREV8

rs1_64 = 64'h0000_0000_0000_00FF; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'h0000_0000_0000_00F0; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'h0123_4567_89AB_CDEF; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'hA5A5_A5A5_5A5A_5A5A; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'hF0F0_F0F0_0F0F_0F0F; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'hDEAD_BEEF_1234_5678; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'h0000_0000_FFFF_FFFF; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'hFFFF_FFFF_0000_0000; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);

// ===================== BREV8 (XLEN=32, op=01101) =====================
// Reverse bits within each byte of rs1
$display("\n---------------- BREV8 (XLEN=32, op=01101) ----------------");
$display(" time |                 rs1 |                 rd");
$display("----------------------------------------------------------------");

op_32 = 5'b01101; // BREV8

rs1_32 = 32'h0000_00FF; #5;  $display("%4t | %h | %h", $time, rs1_32, rd_32);
rs1_32 = 32'h0000_00F0; #5;  $display("%4t | %h | %h", $time, rs1_32, rd_32);
rs1_32 = 32'h1234_ABCD; #5;  $display("%4t | %h | %h", $time, rs1_32, rd_32);
rs1_32 = 32'hA5A5_5A5A; #5;  $display("%4t | %h | %h", $time, rs1_32, rd_32);
rs1_32 = 32'hF0F0_0F0F; #5;  $display("%4t | %h | %h", $time, rs1_32, rd_32);
rs1_32 = 32'hDEAD_BEEF; #5;  $display("%4t | %h | %h", $time, rs1_32, rd_32);


// ===================== REV8 (XLEN=64, op=01110) =====================
$display("\n---------------- REV8 (XLEN=64, op=01110) ----------------");
$display(" time |                         rs1 |                         rd");
$display("------------------------------------------------------------------------------------------------");

op_64 = 5'b01110; // REV8

rs1_64 = 64'h1122334455667788; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'hDEADBEEF12345678; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'hAABBCCDDEEFF0011; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'h00000000000000FF; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'hFF00000000000000; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);
rs1_64 = 64'h123456789ABCDEF0; #5;  $display("%4t | %h | %h", $time, rs1_64, rd_64);

// ===================== REV8 (XLEN=32, op=01110) =====================
$display("\n---------------- REV8 (XLEN=32, op=01110) ----------------");
$display(" time |                 rs1 |                 rd");
$display("----------------------------------------------------------------");

op_32 = 5'b01110; // REV8

rs1_32 = 32'h11223344; #5;  $display("%4t | %h | %h", $time, rs1_32, rd_32);
rs1_32 = 32'hDEADBEEF; #5;  $display("%4t | %h | %h", $time, rs1_32, rd_32);
rs1_32 = 32'h12345678; #5;  $display("%4t | %h | %h", $time, rs1_32, rd_32);

    // ===================== ZIP (XLEN=32, op=01111) =====================
    // Gathers bits from the high and low halves of rs1 into even/odd bit positions
    $display("\n---------------- ZIP (XLEN=32, op=01111) ----------------");
    $display(" time |           rs1           |           rd");
    $display("-----------------------------------------------------------");

    op_32 = 5'b01111; // ZIP operation opcode

    // Test 1: Simple pattern
    rs1_32 = 32'hFFFF0000; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    // Test 2: Alternating pattern
    rs1_32 = 32'hAAAA5555; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    // Test 3: Lower half = 0x0000FFFF, upper = 0xFFFF0000
    rs1_32 = 32'hFFFF0000; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    // Test 4: Checkerboard bit pattern
    rs1_32 = 32'h0F0FF0F0; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    // Test 5: Random mixed pattern
    rs1_32 = 32'h12345678; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    // Test 6: Deadbeef pattern
    rs1_32 = 32'hDEADBEEF; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

// ===================== UNZIP (XLEN=32, op=10000) =====================
    // Inverse of ZIP - de-interleaves bits back to original order
    $display("\n---------------- UNZIP (XLEN=32, op=10000) ----------------");
    $display(" time |           rs1           |           rd");
    $display("-----------------------------------------------------------");

    op_32 = 5'b10000; // UNZIP opcode

    rs1_32 = 32'hAAAAAAAA; #5; // From ZIP output
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    rs1_32 = 32'h99999999; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    rs1_32 = 32'hAAAAAAAA; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    rs1_32 = 32'h55AA55AA; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    rs1_32 = 32'h131C1F60; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);

    rs1_32 = 32'hE7FCDCF7; #5;
    $display("%4t | %h | %h", $time, rs1_32, rd_32);





$display("\nSimulation finished.");

    $display("\nSimulation finished.");
    $finish;
  end

endmodule

