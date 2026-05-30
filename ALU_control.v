module ALU_control(
	input [1:0] ALUOp,
	input [2:0] funct3,
	input [6:0] funct7,
	
	output reg [2:0] ALUControl
);


always @(*)
begin
	case(ALUOp)
		2'b00: ALUControl = 3'b000; //lw y sw
		2'b01: ALUControl = 3'b001; //beq
		2'b10: 
			begin
				case(funct3)
					3'b000: 
					begin
						if(funct7 == 7'b0100000)
							ALUControl = 3'b001; //sub
						else
							ALUControl = 3'b000; //add
						end
					
					3'b111: ALUControl = 3'b010; //and
					3'b110: ALUControl = 3'b011; //or
					3'b010: ALUControl = 3'b101; //slt
				
				endcase
			end
			
			default: ALUControl = 3'b000;
			
	 endcase
end


/*
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
						//if({Op,funct7} == 00 | 01 |100)
						if(funct7 == 7'b0100000)
							ALUControl = 3'b001;
						//else if({Op,funct7} == 11 )
							ALUControl = 3'b000;
						end
			3'b010 : ALUControl = 3'b101;
			3'b110 : ALUControl = 3'b011;
			3'b111 : ALUControl = 3'b010;
	
			default : ALUControl = 0;			
		endcase 
	end
			
end
*/


endmodule
