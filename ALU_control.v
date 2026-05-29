module ALU_control(
	input [1:0] ALUOp,
	input [2:0] funct3,
	input [6:0] funct7,
	input Op,
	
	output reg [2:0] ALUControl
);

// Decidir que operación vamos a realizar
always @(*)
begin
	if(ALUOp == 00)begin
		ALUControl = 000;
		end
	else if(ALUOp == 01 )begin
		ALUControl = 001;
		end
	else
		begin
		case(funct3)
			3'b000 : begin
						if({Op,funct7} == 00 | 01 |10)
							ALUControl = 000;
						else if({Op,funct7} == 11 )
							ALUControl = 001;
						end
			3'b010 : ALUControl = 101;
			3'b110 : ALUControl = 011;
			3'b111 : ALUControl = 010;
	
			default : ALUControl = 0;			
		endcase 
	end
			
end



endmodule