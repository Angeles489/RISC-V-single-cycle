module adder(
	input [31:0] PC,
	input [31:0] operacion2,
	
	output reg [31:0] Out

);


always @(*)
begin
	Out=PC+operacion2;
end

endmodule 