`timescale 1ns / 1ps
// La función de este módulo es cargar instrucciones a partir de un
// archivo de inicialización de memoria (code.mem), y luego asignar
// estas instrucciones dependiendo de la dirección de entrada

// Entradas: Address: Dirección de entrada
//           
// Salida:   Instruction: Instrucción guardada en la dirección de Address

// Se introdujo este módulo para poder cargar las instrucciones de los
// distintos códigos, así como para cambiar de instrucción en base a
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
    // Se le asigna a Instruction la instrucción de mem
    // en la posición de Address
	assign Instruction = mem[Address>>2];	
	

endmodule