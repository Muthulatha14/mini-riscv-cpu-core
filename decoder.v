module decoder (
    input  [31:0] instr,
    output [6:0]  opcode, funct7,
    output [4:0]  rd, rs1, rs2,
    output [2:0]  funct3,
    output reg [3:0] alu_op
);
assign opcode = instr[6:0];
assign rd     = instr[11:7];
assign funct3 = instr[14:12];
assign rs1    = instr[19:15];
assign rs2    = instr[24:20];
assign funct7 = instr[31:25];

always @(*) begin
    case (funct3)
        3'b000: alu_op = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000;
        3'b111: alu_op = 4'b0010;
        3'b110: alu_op = 4'b0011;
        3'b100: alu_op = 4'b0100;
        3'b001: alu_op = 4'b0101;
        3'b101: alu_op = 4'b0110;
        3'b010: alu_op = 4'b0111;
        default: alu_op = 4'b0000;
    endcase
end
endmodule
