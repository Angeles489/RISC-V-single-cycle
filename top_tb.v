`timescale 1ns/1ps

module top_tb;

reg clk;
reg rst;


top DUT(
    .clk(clk),
    .rst(rst)
);


// inicio de reloj
always #5 clk = ~clk;


initial
begin
    // inicio
    clk = 0;
    rst = 1;
	 
	 // inicializar registros en cero
    DUT.RF.REG[0] = 0;  
    DUT.RF.REG[5]  = 0;
    DUT.RF.REG[6]  = 0;
    DUT.RF.REG[10] = 0;

    // reset activo
    #20;

    rst = 0;

    #200;

    $display("-----------------------------------");
    $display("x5  = %d", DUT.RF.REG[5]);
    $display("x6  = %d", DUT.RF.REG[6]);
    $display("x10 = %d", DUT.RF.REG[10]);
    $display("-----------------------------------");

		
	 $stop;
    $finish;

end

//monitorear las señales
always @(posedge clk) 
begin
    if(DUT.PC <= 32'h0000000C)  // hasta que el PC cubra las primeras 4 direcciones
        $display(
            "TIME=%0t | PC=%h | INSTR=%h | ALUResult=%h | x5=%d | x6=%d | x10=%d",
            $time,
            DUT.PC,
            DUT.Instr,
            DUT.ALUResult,
            DUT.RF.REG[5],
            DUT.RF.REG[6],
            DUT.RF.REG[10]
        );
end
endmodule