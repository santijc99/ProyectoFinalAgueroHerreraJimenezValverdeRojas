`timescale 1ns / 1ps
// La función de este módulo es unir todos los módulos descritos
// para obtener una microarquitectura para el ISA de RISCV32 que sea
// capaz de ejecutar distintas instrucciones de ensamblador necesarias
// para ejecutar distintos códigos.

// Entradas: CLK: Señal de reloj
//           RST: Se reinicia el dispositivo
// Parametros: SIZE: Cantidad de palabras almacenables en Data memory
//             OFFSET: Offset de la dirección de memoria de entrada en
//                     Data memory

// Se introdujo este módulo para conectar todos los componente del
// circuito diseñado, tal y como se muestra en el diagrama de circuito

module Main #(parameter SIZE = 32, OFFSET=50) (CLK, RST);

    input CLK, RST;
    
    wire [31:0] PCOut, Instruction, MuxSel1Out, MuxALUSrcOut, RD1, RD2, ExtensorOut, ALUOut, MuxMemtoRegOut;
    wire [31:0] DataOut, MuxPCOut, MuxJalrOut, GPIOOut;
    wire [4:0] MuxSrc2Out;
    wire Z, RegSrc2, ALUSrc, MemtoReg, MemWrite, ByteORword, ByteORwordS, RegWrite, Jalr, ABCD, GPIOOn;
    wire [1:0]PCDIRR, Sel1;
    wire [2:0] ImmSrc, ALUControl;
     
    UC UC(
        .opcode(Instruction[6:0]),   
        .funct7(Instruction[31:25]),
        .funct3(Instruction[14:12]),
        .rd(Instruction[11:7]),      
        .Z(Z),
        .PCDIRR(PCDIRR), 
        .Sel1(Sel1),
        .RegSrc2(RegSrc2), 
        .RegWrite(RegWrite), 
        .MemWrite(MemWrite), 
        .MemtoReg(MemtoReg), 
        .ByteORword(ByteORword), 
        .ByteORwordS(ByteORwordS),
        .Jalr(Jalr),
        .ABCD(ABCD),
        .GPIOOn(GPIOOn),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl)    

);
    
    RegisterFile RegisterFile(
    .WD(MuxSel1Out),
    .A3(Instruction[11:7]),
    .RD1(RD1),
    .A1(Instruction[19:15]),
    .RD2(RD2),
    .A2(MuxSrc2Out),
    .RegWrite(RegWrite),
    .RST(RST),
    .EN(1),
    .CLK(CLK) 
    );

    ALU ALU (
    .ALUcontrol(ALUControl),
    .A(RD1), 
    .B(MuxALUSrcOut), 
    .Output(ALUOut),
    .Z(Z),
    .ABCD(ABCD)
    );
    
    ExtensorDeSigno ExtensorDeSigno (
    .morse(Instruction),
    .selec(ImmSrc),
    .salida(ExtensorOut)
    );
    
    DataMemory #(.SIZE(SIZE),.OFFSET(OFFSET)) DataMemory (
    .A(ALUOut), 
    .WD(RD2), 
    .ByteORword(ByteORword),
    .ByteORwordS(ByteORwordS),
    .MemWrite(MemWrite),
    .RST(RST), 
    .EN(1), 
    .CLK(CLK), 
    .RD(DataOut)
    );
    
    FlipFlopD #(.REGISTRO_WIDTH(32)) PC (
    .CLK(CLK),
    .EN(1),
    .RST(RST),
    .D(MuxJalrOut), 
    .Q(PCOut)
    );
    
    FlipFlopD #(.REGISTRO_WIDTH(32)) GPIO (
    .CLK(CLK),
    .EN(GPIOOn),
    .RST(RST),
    .D(RD2), 
    .Q(GPIOOut)
    );
    
    InstructionMemory InstructionMemory(
    .Address(PCOut), 
    .Instruction(Instruction)
    );
    
    Mux2a1 #(.WIDTH(32)) MuxJalr (
    .Selector(Jalr),
    .Output(MuxJalrOut), 
    .Input0((PCOut+MuxPCOut)), 
    .Input1(MuxMemtoRegOut)
    );
    
    Mux2a1 #(.WIDTH(5)) MuxSrc2 (
    .Selector(RegSrc2),
    .Output(MuxSrc2Out), 
    .Input0(Instruction[24:20]), 
    .Input1(5'b0)
    );
    
    Mux2a1 #(.WIDTH(32)) MuxALUSrc (
    .Selector(ALUSrc),
    .Output(MuxALUSrcOut), 
    .Input0(RD2), 
    .Input1(ExtensorOut)
    );
    
    Mux2a1 #(.WIDTH(32)) MuxMemtoReg (
    .Selector(MemtoReg),
    .Output(MuxMemtoRegOut), 
    .Input0(ALUOut), 
    .Input1(DataOut)
    );
    
    Mux4a1 #(.WIDTH(32)) MuxSel1 (
    .Selector(Sel1),
    .Output(MuxSel1Out), 
    .Input0((PCOut+32'd4)), 
    .Input1(MuxMemtoRegOut),
    .Input2(ExtensorOut), 
    .Input3(0)
    );
    
    Mux4a1 #(.WIDTH(32)) MuxPC (
    .Selector(PCDIRR),
    .Output(MuxPCOut), 
    .Input0(0), 
    .Input1(32'd4),
    .Input2(ExtensorOut), 
    .Input3(MuxMemtoRegOut)
    );
    
endmodule