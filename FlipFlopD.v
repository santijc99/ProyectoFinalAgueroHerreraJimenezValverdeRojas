`timescale 1ns / 1ps
// La función de este módulo es actuar como un Flip Flop D
// (FFD), de tal manera que se pueden almacenar valores siempre
// que el dispositivo no se resetee o se sobreescriba

// Entradas: CLK: Señal de reloj
//           EN: Habilita la escritura en el FFD
//           RST: Reinicia el FFD
//           D: Valor a guardar
// Salida:   Q: Valor almacenado en el FFD
// Parametro: REGISTRO_WIDTH: Tamaño del Input y el Output

// Se introdujo este módulo para actuar como el registro de PC,
// de tal manera que el valor de la instrucción actual sea almacenado
// hasta la siguiente instrucción.
// Además es utilizado para emular un GPIO.
module FlipFlopD #(parameter REGISTRO_WIDTH = 30) (CLK, EN, RST, D, Q
    );
	 
	 input CLK, EN, RST;
	 input [REGISTRO_WIDTH-1:0] D;
	 output reg [REGISTRO_WIDTH-1:0] Q;
	 
	 // En flanco positivo del reloj
	 always @(posedge CLK)
	  // Si se resetea, se borra el valor
      if (RST)
         Q <= 0;
      // Si no se resetea, se almacena D en Q en caso
      // de que EN sea 1, si no se preserva el valor de Q
      else begin
			if (EN) begin
				Q <= D;
			end else
				Q <= Q;
		end
endmodule
