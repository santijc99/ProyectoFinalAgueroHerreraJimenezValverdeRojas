`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut realice las operaciones
//                        de lectura y escritura tanto de palabras como
//                        de bytes
// Estímulos: Se inicia la uut en estado de reinicio, luego de un tiempo se habilita
//            el funcionamiento. Se aplica una escritura de bytes y luego se leen las
//            palabras generadas, luego se escriben palabras y se leen los bytes generados
//            Por último se hacen un par de escrituras de bytes con valores personalizados
//            y se hace una lectura de palabras
// Resultados esperados: Se espera observar que los valores escritos puedan ser correctamente
//                       leídos a través de los distintas lecturas en el testbench
module DataMemory_tb;

    parameter SIZE=32;

     // Inputs
     
     reg [31:0] A, WD;
     reg ByteORword, ByteORwordS, MemWrite;
     reg RST;
     reg EN;
     reg CLK;
     
     //Variables de Testbench
     
     integer j = 0;
     
     // Outputs
    
     wire [31:0] RD;
    
     // Instantiate the Unit Under Test (UUT)
    
     DataMemory #(.SIZE(SIZE)) uut (
           .A(A),
           .WD(WD), 
           .ByteORword(ByteORword), 
           .ByteORwordS(ByteORwordS), 
           .MemWrite(MemWrite),  
           .RST(RST), 
           .EN(EN), 
           .CLK(CLK),
           .RD(RD)
     );
    
     initial begin
    
      // Initialize Inputs
    
     WD  = 32'b0;
     A  = 32'b0;
     ByteORword = 0;
     ByteORwordS = 0;
     MemWrite = 0;
     RST  = 1'b1;
     EN  = 1'b0;
     CLK  = 1'b0;
    
     // Wait 100 ns for global reset to finish
    
     #101;        
    
     // Add stimulus here
    
     RST  = 1'b0;
     EN  = 1'b1;
     
     //Escritura de bytes
     MemWrite = 1;
     ByteORwordS = 1;
     while (j <= (SIZE*4)) begin
        #10 A=j; WD=j; 
        j=j+1;
     end
     A=0;WD=0;
     #10;
     
     MemWrite  = 0;
     ByteORwordS = 0;
        
     //Lectura de palabras
     #20;
     j=0;
     while (j <= (SIZE*4)) begin
        #10 A=j;
        j=j+4;
     end
     A=0;WD=0;
     
     
     #20;
     //Escritura de palabras
     MemWrite = 1;
     j=0;
     while (j <= (SIZE*4)) begin
        #10 A=j; WD=(j/4); 
        j=j+4;
     end
     A=0;WD=0;
     MemWrite = 0;
     
     //Lectura de Bytes
     #20;
     ByteORword = 1;
     j=0;
     while (j <= (SIZE*4)) begin
        #10 A=j;
        j=j+1;
     end
     A=0;WD=0;
     ByteORword = 0;
     j=0;
     
     //Escritura de bytes
     MemWrite = 1;
     ByteORwordS = 1;
     while (j <= (SIZE*4)) begin
        #10 A=j; WD=j; 
        j=j+1;
     end
     A=0;WD=0;
     MemWrite  = 0;
     ByteORwordS = 0;
     j=0;
     #10;
     
     
     
     //Escritura de bytes 2
     #20;
     MemWrite = 1;
     ByteORwordS = 1;
     while (j <= (SIZE*4)) begin
        #10 A=j; WD=32'hff; 
        j=j+2;
     end
     MemWrite  = 0;
     ByteORwordS = 0;
     A=0;WD=0;
     #10;
     
     
     
     //Lectura de palabras
     #20;
     j=0;
     while (j <= (SIZE*4)) begin
        #10 A=j;
        j=j+4;
     end
     A=0;WD=0;
     
     end 
    
     always begin
    
         #1;
         CLK = ~CLK;
         
     end 

endmodule