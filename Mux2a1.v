`timescale 1ns / 1ps
// La funci�n de este m�dulo es seleccionar entre 2 entradas
// distintas para hacer esta llegar a la salida del m�dulo,
// es decir, un multiplexor de 2 a 1.

// Entradas: Input0, Input1: Valores a escoger para la salida
//           Selector: Se�al de control para escoger entre los Input
// Salida:   Output: Input seleccionada por el selector
// Parametro: WIDTH: Tama�o de los Inputs y el Output

// Se introducjo este m�dulo para seleccionar entre distintas se�ales
// dependiendo de la instrucci�n que se ejecute en el momento
module Mux2a1 #(parameter WIDTH = 8)(Selector, Output, Input0, Input1);


	input Selector;
	input [WIDTH-1:0] Input0, Input1;
	output [WIDTH-1:0] Output;
	
	//Si selector=1, Output=Input1
	//Si selector=0, Output=Input0
    assign Output = Selector ? Input1 : Input0;
					
					
endmodule