module mux #(parameter N=2) (
	input [N*32-1:0] mux_in,
	input [$clog2(N)-1:0] mux_sel,
	
	output reg [31:0] mux_out
);

always @(*)
begin
	//mux_out = mux_in[((mux_sel+N)*(31)) : ((mux_sel)*(31))];
	
	 mux_out = mux_in[mux_sel*32 +: 32];
end

endmodule


/*module mux(
	input [31:0] i1,i2,
	input Selector,
	
	output reg [31:0] Salida

);

always @(*)
begin
	if(Selector == 0)
		Salida = i1;
	else
		Salida = i2 ;
end

endmodule*/