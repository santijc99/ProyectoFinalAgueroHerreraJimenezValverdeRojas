`timescale 1ns / 1ps
// La función de este módulo es seleccionar entre 2 entradas
// distintas para hacer esta llegar a la salida del módulo,
// es decir, un multiplexor de 2 a 1.

// Entradas: Input0, Input1: Valores a escoger para la salida
//           Selector: Señal de control para escoger entre los Input
// Salida:   Output: Input seleccionada por el selector
// Parametro: WIDTH: Tamaño de los Inputs y el Output

// Se introducjo este módulo para seleccionar entre distintas señales
// dependiendo de la instrucción que se ejecute en el momento
module Mux2a1 #(parameter WIDTH = 8)(Selector, Output, Input0, Input1);


	input Selector;
	input [WIDTH-1:0] Input0, Input1;
	output [WIDTH-1:0] Output;
	
	//Si selector=1, Output=Input1
	//Si selector=0, Output=Input0
    assign Output = Selector ? Input1 : Input0;
					
					
endmodule