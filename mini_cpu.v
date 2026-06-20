module mini_cpu (
    input clk, rst
);
wire [31:0] pc, instr;
wire [6:0] opcode, funct7;
wire [4:0] rd, rs1, rs2;
wire [2:0] funct3;
wire [3:0] alu_op;
wire [31:0] read_data1, read_data2, alu_result;
wire zero;

reg we;
reg [4:0] rd_delayed;
reg [31:0] alu_result_delayed;

pc_imem PCMEM (.clk(clk), .rst(rst), .pc(pc), .instr(instr));

decoder DEC (
    .instr(instr), .opcode(opcode), .rd(rd), .funct3(funct3),
    .rs1(rs1), .rs2(rs2), .funct7(funct7), .alu_op(alu_op)
);

register_file RF (
    .clk(clk), .we(we),
    .rs1(rs1), .rs2(rs2), .rd(rd_delayed),
    .write_data(alu_result_delayed),
    .read_data1(read_data1), .read_data2(read_data2)
);

alu ALU (
    .a(read_data1), .b(read_data2), .alu_op(alu_op),
    .result(alu_result), .zero(zero)
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        we <= 0;
        rd_delayed <= 0;
        alu_result_delayed <= 0;
    end else begin
        we <= 1;
        rd_delayed <= rd;
        alu_result_delayed <= alu_result;
    end
end

endmodule
