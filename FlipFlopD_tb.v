`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut actualice su valor
//                        de salida de acuerdo a la entrada en el
//                        flanco positivo del reloj
// Estímulos: Se inicia la uut en estado de reinicio, luego de un tiempo se habilita
//            el FFD para actualizar su valor. El reloj tiene un periodo de 10ns y cada
//            5ns la entrada aumenta en 1
// Resultados esperados: Se espera observar que la salida del FFD aumenta de 2 en 2
module FlipFlopD_tb;

    parameter REGISTRO_WIDTH=4;

	// Inputs
	reg CLK;
	reg EN;
	reg RST;
	reg [REGISTRO_WIDTH-1:0] D;
	

	// Outputs
	wire [REGISTRO_WIDTH-1:0] Q;

	// Instantiate the Unit Under Test (UUT)
	FlipFlopD #(.REGISTRO_WIDTH(REGISTRO_WIDTH)) uut (
		.CLK(CLK),
		.EN(EN), 
		.RST(RST), 
		.D(D),
		.Q(Q)  
	);

	initial begin
		// Initialize Inputs
		CLK = 1;
		EN = 1;
		RST=1;
		D=0;
		#100 RST=0;
		#200 EN=1;
		#210 EN=0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #5 CLK = ~CLK;
	always #5 D = D + 1;
	
endmodule

