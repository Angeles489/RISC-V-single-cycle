module instruction_memory(
	input [31:0] PC,
	
	output reg [31:0] Instr

);

reg [31:0] Memory [0:255];


initial 
begin
	$readmemh("instrMem.hex", Memory);
end


always @(*)
begin 
	Instr = Memory[PC>>2];
	
end 




endmodule