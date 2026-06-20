module pc_imem (
    input clk, rst,
    output reg [31:0] pc,
    output [31:0] instr
);
reg [31:0] imem [0:7];
initial begin
    imem[0] = 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2
    imem[1] = 32'b0100000_00010_00001_000_00101_0110011; // SUB x5, x1, x2
    imem[2] = 32'b0000000_00010_00001_111_00111_0110011; // AND x7, x1, x2
    imem[3] = 32'b0; imem[4] = 32'b0; imem[5] = 32'b0; imem[6] = 32'b0; imem[7] = 32'b0;
end
always @(posedge clk or posedge rst) begin
    if (rst) pc <= 0;
    else pc <= pc + 4;
end
assign instr = imem[pc[31:2]];
endmodule
