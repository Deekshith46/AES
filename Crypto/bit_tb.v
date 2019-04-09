
module tb;

  // Parameter for 32-bit XLEN
  parameter XLEN = 32;
  parameter OP_WIDTH = 5;

  reg  [XLEN-1:0] rs1;
  reg  [XLEN-1:0] rs2;
  reg  [OP_WIDTH-1:0] op_in;
  wire [XLEN-1:0] rd;

  // Instantiate the DUT
  top #(.XLEN(XLEN)) dut (
    .rs1_in(rs1),
    .rs2_in(rs2),
    .op_in(op_in),
    .out(rd)
  );

  initial begin
    // Header
    $display("Time | rs1 = %h | rs2 = %h | shamt | rd (rotate_left result)", rs1, rs2);

    // Apply test cases
    
    op_in = 5'b00001;
        
    rs1 = 32'hA5A5_0001; rs2 = 0;  #5;
    $display("%0t ns: rs1=%h rs2=%h -> rd=%h", $time, rs1, rs2, rd);

    rs1 = 32'hA5A5_0001; rs2 = 1;  #5;
    $display("%0t ns: rs1=%h rs2=%h -> rd=%h", $time, rs1, rs2, rd);

    rs1 = 32'hA5A5_0001; rs2 = 4;  #5;
    $display("%0t ns: rs1=%h rs2=%h -> rd=%h", $time, rs1, rs2, rd);

    rs1 = 32'hA5A5_0001; rs2 = 8;  #5;
    $display("%0t ns: rs1=%h rs2=%h -> rd=%h", $time, rs1, rs2, rd);
        
    rs1 = 32'hA5A5_0001; rs2 = 16; #5;
    $display("%0t ns: rs1=%h rs2=%h -> rd=%h", $time, rs1, rs2, rd);

    rs1 = 32'hA5A5_0001; rs2 = 31; #5;
    $display("%0t ns: rs1=%h rs2=%h -> rd=%h", $time, rs1, rs2, rd);

    rs1 = 32'hA5A5_0001; rs2 = 36; #5; // Same as shift 4
    $display("%0t ns: rs1=%h rs2=%h -> rd=%h", $time, rs1, rs2, rd);

    rs1 = 32'hA5A5_0001; rs2 = 63; #5; // Same as shift 31
    $display("%0t ns: rs1=%h rs2=%h -> rd=%h", $time, rs1, rs2, rd);

    op_in = 5'b00010; // ROLW

    rs1 = 64'h0000_0000_A5A5_0001; rs2 = 0;  #5;  $display("%4t | %2d    | %h | %h | %h", $time, rs2[4:0], rs1, rs2, rd);
    rs1 = 64'h0000_0000_A5A5_0001; rs2 = 1;  #5;  $display("%4t | %2d    | %h | %h | %h", $time, rs2[4:0], rs1, rs2, rd);
    rs1 = 64'h0000_0000_A5A5_0001; rs2 = 4;  #5;  $display("%4t | %2d    | %h | %h | %h", $time, rs2[4:0], rs1, rs2, rd);
    rs1 = 64'h0000_0000_A5A5_0001; rs2 = 8;  #5;  $display("%4t | %2d    | %h | %h | %h", $time, rs2[4:0], rs1, rs2, rd);
    rs1 = 64'h0000_0000_A5A5_0001; rs2 = 31; #5;  $display("%4t | %2d    | %h | %h | %h", $time, rs2[4:0], rs1, rs2, rd);
    // >31 wraps via rs2[4:0]
    rs1 = 64'h0000_0000_A5A5_0001; rs2 = 36; #5;  $display("%4t | %2d    | %h | %h | %h", $time, rs2[4:0], rs1, rs2, rd);

    // show sign-extension with MSB=1 of 32-bit result
    rs1 = 64'hFFFF_FFFF_F123_4567; rs2 = 5;  #5;  $display("%4t | %2d    | %h | %h | %h", $time, rs2[4:0], rs1, rs2, rd);
    

    $display("Simulation finished ?");
    $finish;
  end

endmodule

