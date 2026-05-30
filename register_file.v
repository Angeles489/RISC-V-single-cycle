module register_file(
    input clk,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    input WE3,
    
    output [31:0] RD1,
    output [31:0] RD2
);
    
reg [31:0] REG [31:0];

assign RD1 = REG[A1];
assign RD2 = REG[A2];

always @(posedge clk) 
begin
   if(WE3 == 1)
		REG[A3] <= WD3;
end

endmodule
