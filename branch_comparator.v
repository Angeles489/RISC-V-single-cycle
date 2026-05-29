module branch_comparator(
	input [31:0] RD1,
	input [31:0] RD2,
	
	output reg zero

);


always @(*)
begin
if( RD1 == RD2)
	zero = 1;
	else
		zero = 0;
end 


endmodule

