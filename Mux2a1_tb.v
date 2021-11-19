`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut puede alternar entre
//                        Input0 e Input1 al cambiar el selector
// Estímulos: Se inicia la uut con todas las entradas en 0, luego se
//            empieza a alternar el selector y a aumentar Input0 e Input1
// Resultados esperados: Se espera observar que output tome el valor
//                       de Input1 y seguidamente el de Input0, la 
//                       secuencia se repite
module Mux2a1_tb;

     parameter WIDTH=8;

     // Inputs
     
     reg Selector;
     reg [WIDTH-1:0] Input0, Input1;
     
     //Variables de Testbench
     
     integer j = 0;
     
     // Outputs
    
     wire [WIDTH-1:0] Output;
    
     // Instantiate the Unit Under Test (UUT)
    
     Mux2a1 #(.WIDTH(WIDTH)) uut (
           .Selector(Selector), 
           .Output(Output), 
           .Input0(Input0), 
           .Input1(Input1)
     );
    
     initial begin
    
      // Initialize Inputs
     
     Selector=0;
     Input0=0;
     Input1=0;
     
     // Wait 100 ns for global reset to finish
    
     #100;        
    
     // Cada 10ns se alterna el selector entre 0 y 1,
     // además, se cambian los valores de Input0 e Input1
    
     while (j < 32) begin
        #10 Selector= ~Selector; Input0 = j; Input1 = j+1;
        j=j+2;
     end
     #10;

     end 

endmodule