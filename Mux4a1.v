`timescale 1ns / 1ps
// La función de este módulo es seleccionar entre 4 entradas
// distintas para hacer esta llegar a la salida del módulo,
// es decir, un multiplexor de 4 a 1.

// Entradas: Input0, Input1, Input2, Input3: Valores a escoger para la salida
//           Selector: Señal de control para escoger entre los Input
// Salida:   Output: Input seleccionada por el selector
// Parametro: WIDTH: Tamaño de los Inputs y el Output

// Se introducjo este módulo para seleccionar entre distintas señales
// dependiendo de la instrucción que se ejecute en el momento
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