module tb_mini_cpu;

reg clk, rst;
mini_cpu uut (.clk(clk), .rst(rst));

always #5 clk = ~clk;

initial begin
    clk = 0; rst = 1;
    #10 rst = 0;

    uut.RF.registers[1] = 15;
    uut.RF.registers[2] = 5;

    repeat (5) begin
        #10;
        $display("PC=%0d | rd=%0d | alu_op=%b | result=%0d",
                   uut.pc, uut.rd, uut.alu_op, uut.alu_result);
    end

    $display("Final: x3=%0d (ADD 15+5) x5=%0d (SUB 15-5) x7=%0d (AND 15&5)",
               uut.RF.registers[3], uut.RF.registers[5], uut.RF.registers[7]);

    $finish;
end

endmodule
