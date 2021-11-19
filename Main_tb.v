`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut logre ejecutar las instrucciones
//                        de ensamblador presentes en code.mem
// Est�mulos: Se inicia la uut en un estado de reinicio, luego de un tiempo
//            se inicia la ejecuci�n de las instrucciones
//            Luego de un tiempo arbitrario, se hace un display de los valores
//            de todos los registros y se crea dump.txt, donde se hace un
//            memory dump de DataMemory. La se�al de reloj tiene un periodo de 2ns.      
// Resultados esperados: Se espera observar que los valores adecuados de las
//                       instrucciones ejecutadas en base a cu�l c�digo est�
//                       en code.mem
//                       C�digo 1: -2
//                       C�digo 2: 0x8, 0x0, 0x666
//                       C�digo 3: 16
//                       C�digo 4: 287
//                       C�digo 5: L (76)
module Main_tb;

    parameter SIZE=1024;
    parameter OFFSET=0;
    reg CLK, RST;
    
    integer i=0;
    integer j=0;
    integer z=0;
    integer file_name;
    
    Main #(.SIZE(SIZE),.OFFSET(OFFSET)) uut(
            .CLK(CLK),
            .RST(RST)
    );
    
    initial begin
     
        CLK=0;
        RST=1;
        file_name = $fopen("dump.txt", "w+");
        
        #10;
        
        RST=0;
        
        #120;
        
        for (j=0; j<1; j=j+1) begin
            while (i<32) begin
                $display("Registro %g: Se escribi� el mensaje %h.",i,Main.RegisterFile.regFile[i]);
                i = i + 1;
            end
            i=0;
        end
        
        i=0;
        
        
        while (i<((SIZE*4)-1)) begin
            $fdisplay(file_name, "Direcci�n:0x%h Valor:0x%h ", i, {Main.DataMemory.DataMem[i+3],Main.DataMemory.DataMem[i+2],Main.DataMemory.DataMem[i+1],Main.DataMemory.DataMem[i]});
            i= i+4;
        end
        

        $fclose(file_name);
             
    end
    
    always begin
    
         #1 CLK = ~CLK;
         
     end
     
     
     
     
    
endmodule