`timescale 1ns / 1ps
// La funci�n de este m�dulo es cargar instrucciones a partir de un
// archivo de inicializaci�n de memoria (code.mem), y luego asignar
// estas instrucciones dependiendo de la direcci�n de entrada

// Entradas: Address: Direcci�n de entrada
//           
// Salida:   Instruction: Instrucci�n guardada en la direcci�n de Address

// Se introdujo este m�dulo para poder cargar las instrucciones de los
// distintos c�digos, as� como para cambiar de instrucci�n en base a
// el valor de PCOut
module InstructionMemory(Address, Instruction); 


    input       [31:0]  Address;        

    output   [31:0]  Instruction;    
    
    //  Matriz para almacenar todas las instrucciones
    reg [31:0] mem[0:1024];

    //Se lee code.mem para cargar instrucciones
	initial
	begin
		$readmemh("code.mem",mem);
	end
    // Se le asigna a Instruction la instrucci�n de mem
    // en la posici�n de Address
	assign Instruction = mem[Address>>2];	
	

endmodule