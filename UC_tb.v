`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut calcule adecuadamente
//                        las señales de control necesarias para
//                        ejecutar una instruccion dada
// Estímulos: Se inicia la uut y se ejecutan instrucciones addi, sw, lw
//            lui, sub, andi, xori, slli, xori, slli, jal, sb, lbu, add, 
//            bne donde no se toma branch, bne donde se toma branch, srai
//            jalr, "mv", "j", jal rd!=0
          
// Resultados esperados: Se espera observar los valores adecuados de las
//                       señales de control en función de la instrucción
//                       que se esté ejecutando, los valores obtenidos
//                       se comparan con la tabla de verdad y los valores
//                       en UC.v

module UC_tb;

//inputs para el testbench 
   
reg [6:0] opcode;
reg [31:25] funct7;   //en caso de operaciones tipo R
reg [14:12] funct3;   //en caso de operaciones tipo R
reg [4:0] rd;        //registro de destino
reg Z;
reg ABCD;

//outputs para el testbench

wire Jalr;
wire GPIOOn;
wire [1:0] PCDIRR;
wire RegSrc2;
wire [1:0] Sel1;
wire RegWrite; 
wire [2:0] ImmSrc;
wire ALUSrc;
wire [2:0] ALUControl;
wire MemWrite, MemtoReg, ByteORword, ByteORwordS;



// Unit under test (UUT)
UC uut(
        .opcode(opcode),   
        .funct7(funct7),
        .funct3(funct3),
        .rd(rd),      
        .Z(Z),
        .ABCD(ABCD),
        .Jalr(Jalr),
        .GPIOOn(GPIOOn),
        .PCDIRR(PCDIRR), 
        .Sel1(Sel1),
        .RegSrc2(RegSrc2), 
        .RegWrite(RegWrite), 
        .MemWrite(MemWrite), 
        .MemtoReg(MemtoReg), 
        .ByteORword(ByteORword), 
        .ByteORwordS(ByteORwordS),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl)    

);

 
    initial begin
    
    #100; //caso para la operación addi
    
    opcode = 7'b0010011;
    funct3 = 3'b000;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100;
    
    //caso para operación sw
    
    opcode = 7'b0100011;
    funct3 = 3'b010;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXX;
    Z = 1'bX;
    ABCD = 1'bX; 
    
    #100;
    
    //caso para instrucción lw
    
    opcode = 7'b0000011;
    funct3 = 3'b010;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100;
    
    //caso para lui
    
    opcode = 7'b0110111;
    funct3 = 3'b010;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para sub
    
    opcode = 7'b0110011;
    funct3 = 3'b000;
    funct7 = 7'b0100000;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para andi
    
    opcode = 7'b0010011;
    funct3 = 3'b111;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para xori
    
    opcode = 7'b0010011;
    funct3 = 3'b100;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para slli
    
    opcode = 7'b0010011;
    funct3 = 3'b001;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para jal
    
    opcode = 7'b1101111;
    funct3 = 3'b111;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para sb
    
    opcode = 7'b0100011;
    funct3 = 3'b000;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para lbu
    
    opcode = 7'b0000011;
    funct3 = 3'b100;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
   
    #100; //caso para add
    
    opcode = 7'b0110011;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para bne, rs1==rs2
    //no se hace el branch
    
    opcode = 7'b1100011;
    funct3 = 3'b001;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'b1;
    ABCD = 1'bX;
    
    #100; //caso para bne, rs1!=rs2
    //se hace el branch
    
    opcode = 7'b1100011;
    funct3 = 3'b001;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'b0;
    ABCD = 1'bX;
    
    #100; //caso para srai
    
    opcode = 7'b0010011;
    funct3 = 3'b101;
    funct7 = 7'b0100000;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para jalr
    
    opcode = 7'b1100111;
    funct3 = 3'b000;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para mv
    //es decir, imm = 0, caso especial de addi
    
    opcode = 7'b0010011;
    funct3 = 3'b000;
    funct7 = 7'bXXXXXXX;
    rd = 5'bXXXXX;
    Z = 1'bX;
    ABCD = 1'bX;

    
    #100; //caso para j
    //caso especial de jal rd==0
    
    opcode = 7'b1101111;
    funct3 = 3'bXXX;
    funct7 = 7'bXXXXXXX;
    rd = 5'b00000;
    Z = 1'bX;
    ABCD = 1'bX;
    
    #100; //caso para jal
    //caso general de jal rd!=0
    
    opcode = 7'b1101111;
    funct3 = 3'bXXX;
    funct7 = 7'bXXXXXXX;
    rd = 5'b00011;
    Z = 1'bX;
    ABCD = 1'bX;
    
    end
    
endmodule