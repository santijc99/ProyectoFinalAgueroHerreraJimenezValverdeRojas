`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut puede alternar entre
//                        Input0, Input1, Input2 y Input3 al cambiar el selector
// Estímulos: Se inicia la uut con todas las entradas en 0, luego se
//            empieza a alternar el selector y a aumentar los Inputs
// Resultados esperados: Se espera observar que output tome el valor
//                       de Input1, Input2, Input 3 y por último Input0, la 
//                       secuencia se repite
module Mux4a1_tb;

     parameter WIDTH=8;

     // Inputs
     
     reg [1:0] Selector;
     reg [WIDTH-1:0] Input0, Input1, Input2, Input3;
     
     //Variables de Testbench
     
     integer j = 0;
     
     // Outputs
    
     wire [WIDTH-1:0] Output;
    
     // Instantiate the Unit Under Test (UUT)
    
     Mux4a1 #(.WIDTH(WIDTH)) uut (
           .Selector(Selector), 
           .Output(Output), 
           .Input0(Input0), 
           .Input1(Input1),
           .Input2(Input2),
           .Input3(Input3)
     );
    
     initial begin
    
      // Initialize Inputs
     
     Selector=0;
     Input0=0;
     Input1=0;
     Input2=0;
     Input3=0;
     
     // Wait 100 ns for global reset to finish
    
     #100;        
    
     // Cada 10ns se aumenta el selector en 1,
     // además, se aumentan los valores de los inputs
    
     while (j < 64) begin
        #10 Selector= Selector + 1; Input0 = j; Input1 = j+1; Input2 = j+2; Input3 = j+3;
        j=j+4;
     end
     #10;

     end 

endmodule