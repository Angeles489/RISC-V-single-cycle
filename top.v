module top(
    input clk,
    input rst
);

// PC
wire [31:0] PC_Next;
wire [31:0] PCplus4;
wire [31:0] PCTarget;
wire [31:0] PC;

// Instruction
wire [31:0] Instr;

// Register File
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] WD3;

// Immediate
wire [31:0] ImmExt;

// ALU
wire [31:0] SrcB;
wire [31:0] ALUResult;
wire [2:0] ALUControl;
wire ALUZero;

// Data Memory
wire [31:0] ReadData;

// Control
wire [1:0] ResultSrc;
wire MemWrite;
wire ALUSrc;
wire [1:0] ImmSrc;
wire RegWrite;

//Branch
wire Branch;
wire Jump;
wire zero;
wire PCSrc;

//Instancias

program_counter PC_Module(
    .clk(clk),
    .rst(rst),
    .PC_Next(PC_Next),
    .PC(PC)
);


adder PC_Adder(
    .PC(PC),
    .operacion2(4),
    .Out(PCplus4)
);


instruction_memory I_mem(
    .A(PC),
    .RD(Instr)
);

control_unit CU(
    .Op(Instr[6:0]),
    .funct3(Instr[14:12]),
    .funct7(Instr[31:25]),
    .zero(zero),
	 
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite),
    .ALUControl(ALUControl),
	 .PCSrc(PCSrc)
);


register_file RF(
    .clk(clk),
    .A1(Instr[19:15]),
    .A2(Instr[24:20]),
    .A3(Instr[11:7]),

    .WD3(WD3),
    .WE3(RegWrite),

    .RD1(RD1),
    .RD2(RD2)
);


immediate_generator IMM_GEN(
    .Instr(Instr),
    .Imm_Src(ImmSrc),
    .ImmExt(ImmExt)
);


mux #(2) ALU_MUX(
    .mux_in({ImmExt, RD2}),
    .mux_sel(ALUSrc),
    .mux_out(SrcB)
);

ALU DUT_ALU(
    .A(RD1),
    .B(SrcB),
    .ALUControl(ALUControl),

    .Result(ALUResult),
    .zero(ALUZero)
);

data_memory DMEM(
    .clk(clk),
    .A(ALUResult),
    .WD(RD2),
    .WE(MemWrite),

    .RD(ReadData)
);

mux #(4) WB_MUX(
    .mux_in({32'b0, PCPlus4, ReadData, ALUResult}),
    .mux_sel(ResultSrc),
    .mux_out(WD3)
);

branch_comparator BC(
    .RD1(RD1),
    .RD2(RD2),
    .zero(zero)
);

adder BRANCH_ADDER(
    .PC(PC),
    .operacion2(ImmExt),
    .Out(PCTarget)
);

mux #(2) PC_MUX(
    .mux_in({PCTarget, PCplus4}),
    .mux_sel(PCSrc),
    .mux_out(PC_Next)
);

endmodule
