module MAIN_Decoder(
    input [6:0] Op,

    output reg [1:0] ResultSrc,
    output reg MemWrite,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg RegWrite,
    output reg Branch,
    output reg [1:0] ALUOp,
    output reg Jump
);

always @(*)
begin
    // valores por defecto
    ResultSrc = 2'b00;
    MemWrite = 1'b0;
    ALUSrc = 1'b0;
    ImmSrc = 2'b00;
    RegWrite = 1'b0;
    Branch = 1'b0;
    ALUOp = 2'b00;
    Jump = 1'b0;

    case(Op)
    //los casos con don't cares X, se omiten
        // lw
        3:
        begin
            RegWrite = 1;
            ALUSrc = 1;
            ResultSrc= 2'b01;
            ALUOp = 2'b00;
            ImmSrc = 2'b00;
        end

        // sw
        35:
        begin
            MemWrite = 1;
            ALUSrc = 1;
            ALUOp = 2'b00;
            ImmSrc = 2'b01;
        end

        // R-type
        51:
        begin
            RegWrite = 1;
            ALUSrc = 0;
            ResultSrc= 2'b00;
            ALUOp = 2'b10;
        end

        // beq
        99:
        begin
            Branch = 1;
            ALUOp = 2'b01;
            ImmSrc = 2'b10;
        end

        // addi
        19:
        begin
            RegWrite = 1;
            ALUSrc = 1;
            ResultSrc = 2'b00;
            ALUOp = 2'b10;
            ImmSrc = 2'b00;
        end

        // jal
        111:
        begin
            RegWrite = 1;
            Jump = 1;
            ResultSrc= 2'b10;
            ImmSrc = 2'b11;
        end

    endcase

end

endmodule
