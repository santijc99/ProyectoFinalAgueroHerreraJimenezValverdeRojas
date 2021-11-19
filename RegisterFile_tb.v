`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut realice las operaciones
//                        de lectura y escritura de registros
// Estímulos: Se inicia la uut en un estado de reinicio, luego de un tiempo
//            se escribe en el registro X, el valor X, al mismo tiempo se está
//            leyendo el registro X, luego se realiza únicamente la lectura de
//            todos los registros. Por último se escriben 2 registros específicos
//            y se leen para verificar el cambio.       
// Resultados esperados: Se espera observar que los valores adecuados de las
//                       operaciones realizadas
//                       Se espera leer el registro X y leer el valor X, luego leer
//                       los registros 5 y 10 y leer 10 y 20, respectivamente
module RegisterFile_tb;

     // Inputs
     
     reg [31:0] WD;
     reg [4:0] A3;
     reg [4:0] A1;
     reg [4:0] A2;
     reg RegWrite;
     reg RST;
     reg EN;
     reg CLK;
     
     //Variables de Testbench
     
     integer j = 0;
     
     // Outputs
    
     wire [31:0] RD1;
     wire [31:0] RD2;
    
     // Instantiate the Unit Under Test (UUT)
    
     RegisterFile uut (
           .WD(WD), 
           .A3(A3), 
           .RD1(RD1), 
           .A1(A1), 
           .RD2(RD2), 
           .A2(A2), 
           .RegWrite(RegWrite), 
           .RST(RST), 
           .EN(EN), 
           .CLK(CLK)
     );
    
     initial begin
    
      // Initialize Inputs
    
     WD  = 32'b0;
     A3  = 4'b0;
     A1  = 4'b0;
     A2  = 4'b0;
     RegWrite  = 1'b0;
     RST  = 1'b1;
     EN  = 1'b0;
     CLK  = 1'b0;
    
     // Wait 100 ns for global reset to finish
    
     #99;        
    
     // Add stimulus here
    
     RST  = 1'b0;
     EN  = 1'b1;
     //Se escriben los registros
     RegWrite = 1;
     while (j < 32) begin
        #2 A3=j; WD=j; A1=j; A2=j;
        j=j+1;
     end
     #10;
     
     RegWrite  = 0;
     //Se leen los registros
     #20;
     j=0;
     while (j < 32) begin
        #10 A1=j; A2=j+1;
        j=j+2;
     end
     #10;
     //Modificación de registros 5 y 10
     RegWrite = 1;
     #10 A3=5; WD=10;
     #10 A3=10; WD=20;
     #10 RegWrite = 0;
     #20 A1=5; A2=10;

     end 
    
     always begin
    
         #1;
         CLK = ~CLK;
         
     end 

endmodule