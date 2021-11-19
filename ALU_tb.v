`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut realice las operaciones
//                        y se obtengan los resultados adecuados, además
//                        de probar las banderas
// Estímulos: Se inicia la uut con A=30 y B=20 y se realizan las operaciones
//            desde ALUControl=0 hasta ALUControl=5, luego se utiliza A=-4 y 
//            B=1 para probar el shift derecho aritmético.
//            Por último se fuerza el resultado a 0 para probar la bandera Z y 
//            luego se fuerza el resultado a 0xABCD para probar la bandera ABCD
          
// Resultados esperados: Se espera observar que los valores adecuados de las
//                       operaciones realizadas
//                       En secuencia se espera obtener: 50, 10, 20, 30, 10
//                       31457280, -2, 0 y 0xABCD
module ALU_tb;

     // Inputs
     
     reg [2:0] ALUcontrol;
     reg signed [31:0] A, B;
     
     //Variables de Testbench
     
     integer j = 0;
     
     // Outputs
    
     wire signed [31:0] Output;
     wire Z, ABCD;
    
     // Instantiate the Unit Under Test (UUT)
    
     ALU uut (
           .ALUcontrol(ALUcontrol), 
           .A(A), 
           .B(B),
           .Output(Output), 
           .Z(Z),
           .ABCD(ABCD)
     );
    
     initial begin
    
      // Initialize Inputs
     
     A=30;
     B=20;
     ALUcontrol=0;
     
     // Wait 100 ns for global reset to finish
    
     #100;        
    
     // Add stimulus here
    
     while (j < 6) begin
        #10 ALUcontrol= j;
        j=j+1;
     end
     #10 A=-32'd4; B=1; ALUcontrol= 6;
     
     //Prueba bandera Z
     #10 A=-32'd4; B=32'd4; ALUcontrol= 7;
     //Prueba bandera ABCD
     #10 A=32'hABCD; B=32'd0; ALUcontrol= 7;

     end 

endmodule