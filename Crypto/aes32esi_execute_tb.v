module tb_aes32esi;
    reg [31:0] rf_rs1_val;
    reg [31:0] rf_rs2_val;
    reg [1:0]  bs;
    wire [31:0] result;

aes32esi_executed dut(
                         .rs1(rf_rs1_val),
                        .rs2(rf_rs2_val),
                        .bs(bs),
                        .result(result)
    );

    initial begin
        $display("AES32ESI TB start");

        // Test vector A (from our discussion):
        // rs2 = 0xA1B2C3D4, rs1 = 0x11223344, bs = 1 (select byte 1 -> 0xC3)
        rf_rs2_val = 32'hA1B2C3D4;
        rf_rs1_val = 32'h11223344;
        bs = 2'b01;
        #5;
        $display("T1 -> rs1=0x%08h rs2=0x%08h bs=%0d result=0x%08h", rf_rs1_val, rf_rs2_val, bs, result);

        // Expected: compute manually or check below (we assert)
        // Expected result for this vector = 0x11221D44 (see notes)
        if (result !== 32'h11221D44) begin
            $display("FAIL T1: expected 0x11221D44");
            $finish;
        end else $display("PASS T1");

        // Test vector B: bs=0 (LSB 0xD4)
        rf_rs2_val = 32'hA1B2C3D4;
        rf_rs1_val = 32'hFFFFFFFF;
        bs = 2'b00;
        #5;
        $display("T2 -> rs1=0x%08h rs2=0x%08h bs=%0d result=0x%08h", rf_rs1_val, rf_rs2_val, bs, result);
        $finish;
    end
endmodule

