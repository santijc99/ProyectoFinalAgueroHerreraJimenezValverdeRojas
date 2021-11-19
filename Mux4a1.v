`timescale 1ns / 1ps
// La funci�n de este m�dulo es seleccionar entre 4 entradas
// distintas para hacer esta llegar a la salida del m�dulo,
// es decir, un multiplexor de 4 a 1.

// Entradas: Input0, Input1, Input2, Input3: Valores a escoger para la salida
//           Selector: Se�al de control para escoger entre los Input
// Salida:   Output: Input seleccionada por el selector
// Parametro: WIDTH: Tama�o de los Inputs y el Output

// Se introducjo este m�dulo para seleccionar entre distintas se�ales
// dependiendo de la instrucci�n que se ejecute en el momento
module Mux4a1 #(parameter WIDTH = 8)(Selector, Output, Input0, Input1, Input2, Input3);


	input [1:0] Selector;
	input [WIDTH-1:0] Input0, Input1, Input2, Input3;
	output reg [WIDTH-1:0] Output;
	
	//Dependiendo del selector, se asigna un input a output
	always @*
      case (Selector)
         2'b00: Output = Input0;
         2'b01: Output = Input1;
         2'b10: Output = Input2;
         2'b11: Output = Input3;
      endcase
								
endmodule