`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut puede cargar y leer
//                        correctamente al pasar por varias direcciones
// Est�mulos: Se inicia la uut con la direcci�n 0 y cada 5ns se pasa
//            a la siguiente direcci�n
// Resultados esperados: Se espera observar la lectura correcta y en orden de las
//                       instrucciones presentes en code.mem
module InstructionMemory_tb; 

    
    integer i=0;
    
    reg [31:0] Address;
    wire [31:0] Instruction;
    
    InstructionMemory uut (
    .Address (Address),
    .Instruction (Instruction)
    );
    
    initial begin
    
    Address = 0;
    //Cada 5ns se aumenta el valor de Address
    for ( i = 0 ; i<1024; i=i+4) begin
        #5 Address = i;
    end 
    end
    
    
endmodule