module register_file_tb();
	reg clk;
	reg [4:0] A1;
	reg [4:0] A2;
	reg [4:0] A3;
	reg [31:0] WD3;
	reg WE3;
	
	wire [31:0] RD1;
	wire [31:0] RD2;

register_file DUT(
	.clk(clk),
	.A1(A1),
	.A2(A2),
	.A3(A3),
	.WD3(WD3),
	.WE3(WE3),
	.RD1(RD1),
	.RD2(RD2)
);


always #10
	clk = ~clk;
	
	initial
		begin
		clk=0;
		WE3=0;
		A1=0;
		A2=0;
		A3=0;
		WD3=0;
		
		#20
		// CASO 1: ESCRIBIR
		A3=1;
		WD3=25;
		WE3=1;
		
		#20
		WE3=0;
		A1=1;
		
		#20
		$display("Lectura RD1: %d", RD1);
		
		#20
		$stop;
		$finish;
	end
	

		

endmodule 