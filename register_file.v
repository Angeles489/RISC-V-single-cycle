module register_file(
	input clk,
	input [4:0] A1,
	input [4:0] A2,
	input [4:0] A3,
	input [31:0] WD3,
	input WE3,
	
	output reg [31:0] RD1,
	output reg [31:0] RD2
);

//REGISTRO TEMPORAL
reg [31:0] REG [31:0];


always @(*)
begin 
	RD1= REG[A1];
	RD2= REG[A2];
end 


always @(posedge clk)
begin	
	if(WE3==1)
		REG[A3] <= WD3; 
end

endmodule