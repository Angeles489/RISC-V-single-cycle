module ALU(
	input [31:0] A,
	input [31:0] B,
	input [2:0] ALUControl,
		
	output reg [31:0] Result,
	output reg zero
);

// Realizar la operación 			

always @(*)
begin 
	case(ALUControl)
	3'b000 : Result = A + B; //add
	3'b001 : Result = A - B; //sub
	3'b010 : Result = A & B; //and
	3'b011 : Result = A | B; //or 
	3'b101 : Result = A << B[4:0]; //shift
	default: Result = 0;
	endcase 
	
	if(Result == 0)
		zero = 1;
		else
		zero = 0;
	
end


endmodule
