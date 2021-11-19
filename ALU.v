`timescale 1ns / 1ps
// La funci�n de este m�dulo es actuar como una ALU con un par
// de banderas. La ALU soporta las operaciones de suma, resta
// AND, OR, XOR, Shift izquierda y Shift derecha aritm�tico.
// La bandera Z es 1 s�lo cuando la salida de la ALU es 0
// La bandera ABCD es 1 s�lo cuando la salida es 0xABCD

// Entradas: A: Primer operando
//           B: Segundo operando
//           ALUcontrol: Selecciona la operaci�n de la ALU
// Salidas:  Output: Resultado de la operaci�n
//           Z: Bandera de control, Output=0
//           ABCD: Bandera de control, Output=0xABCD

// Se introdujo este m�dulo para realizar todas las operaciones
// aritm�tico l�gicas necesarias para la ejecuci�n de las instrucciones
// Las banderas son utilizadas en la UC para determinar el valor de
// se�ales de control, espec�ficamente las de las instrucciones bne y 
// los sw y sb en la direcci�n 0xABCD
module ALU(ALUcontrol, A, B, Output, Z, ABCD);

    input [2:0] ALUcontrol;
    input signed [31:0] A, B;
    output reg signed [31:0] Output;
    output reg Z, ABCD;

    always @* begin
    
        case(ALUcontrol)
        3'b000: // Suma
           Output = A + B ; 
        3'b001: // Resta
           Output = A - B ;
        3'b010: // AND
           Output = A & B;
        3'b011: // OR
           Output = A | B;
        3'b100: // XOR
           Output = A ^ B;
        3'b101: // Shift izq
           Output = A << B;
        3'b110: // Shift derecha aritm�tico
           Output = A >>> B;
        default: // Suma
            Output = A + B ; 
        endcase
        
        if (Output==43981) //Bandera ABCD
            ABCD=1;
        else
            ABCD=0;
        
        if (Output==0) //Bandera Z
            Z=1;
        else
            Z=0;
        
        end
        
        

endmodule