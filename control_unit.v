module control_unit(
	input [6:0] Op,
	input [2:0] funct3,
	input [6:0] funct7,
	input zero, 
	
	output [1:0] ResultSrc,
	output MemWrite,
	output ALUSrc,
	output [1:0] ImmSrc,
	output RegWrite,
	output [2:0] ALUControl,
	output PCSrc
);

wire [1:0] ALUOp;
wire Branch_int;
wire Jump_int;


MAIN_Decoder DUT(
	.Op(Op),
	.ResultSrc(ResultSrc),
	.MemWrite(MemWrite),
   .ALUSrc(ALUSrc),
   .ImmSrc(ImmSrc),
   .RegWrite(RegWrite),
   .Branch(Branch_int),
   .ALUOp(ALUOp),
   .Jump(Jump_int)
);

assign PCSrc = (zero & Branch_int) | Jump_int;


ALU_control DUT_ADD(
	.ALUOp(ALUOp),
   .funct3(funct3),
   .funct7(funct7),
   .ALUControl(ALUControl)
);


endmodule
