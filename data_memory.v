module data_memory(
	input clk,
	input [31:0] A,
	input [31:0] WD,
	input WE,
	
	output reg [31:0] RD
);

reg [31:0] Memory [255:0] ;


always @(*)
begin
	RD = Memory[A>>2];
end

always @(posedge clk)
begin 
	if(WE)
		Memory[A>>2] <= WD; 
end



endmodule


