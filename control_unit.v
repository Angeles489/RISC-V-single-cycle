module control_unit(
	input [6:0] Op,
	input [2:0] funct3,
	input funct7,
	input zero, 
	
	output reg [1:0] ResultSrc,
	output reg MemWrite,
	output reg ALUSrc,
	output reg [1:0] ImmSrc,
	output reg RegWrite,
	output reg Branch,
	output reg [1:0] ALUOp,
	output reg Jump
);


always @(*)
begin
	 RegWrite = 0;
    MemWrite = 0;
    ALUSrc = 0;
    Branch = 0;
    Jump = 0;
    ALUOp = 0;
    ImmSrc = 0;
    ResultSrc = 0;
	 
	 
	case(Op)
	3: begin
		RegWrite = 1;
		ImmSrc = 00;
		ALUSrc = 1;
		MemWrite = 0;
		ResultSrc = 01;
		Branch = 0;
		ALUOp = 00;
		Jump = 0;
		end
		
	35: begin 
		RegWrite = 0;
		ImmSrc = 01;
		ALUSrc = 1;
		MemWrite = 1;
		ResultSrc = 2'bXX;
		Branch = 0;
		ALUOp = 00;
		Jump = 0;
		end
	
	51: begin 
		RegWrite = 1;
		ImmSrc = 2'bXX;
		ALUSrc = 0;
		MemWrite = 0;
		ResultSrc = 00;
		Branch = 0;
		ALUOp = 10;
		Jump = 0;
		end
		
	99: begin 
		RegWrite = 0;
		ImmSrc = 10;
		ALUSrc = 0;
		MemWrite = 0;
		ResultSrc = 2'bXX;
		Branch = 1;
		ALUOp = 01;
		Jump = 0;
		end
		
	19: begin 
		RegWrite = 1;
		ImmSrc = 00;
		ALUSrc = 1;
		MemWrite = 0;
		ResultSrc = 00;
		Branch = 0;
		ALUOp = 10;
		Jump = 0;
		end
		
	111: begin 
		RegWrite = 1;
		ImmSrc = 11;
		ALUSrc = 1'bX;
		MemWrite = 0;
		ResultSrc = 10;
		Branch = 0;
		ALUOp = 2'bXX;
		Jump = 1;
		end	
	endcase
end
	

endmodule