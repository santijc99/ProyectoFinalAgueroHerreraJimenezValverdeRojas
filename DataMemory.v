`timescale 1ns / 1ps
// La función de este módulo es actuar como una memoria
// a base de bytes (8 bits), de tal manera que se pueden leer
// y almacenar palabras(32 bits/4 bytes) o bytes. La lectura
// se realiza de manera combinacional y la escritura de manera
// secuencial.

// Entradas: A: Dirección de escritura/Lectura
//           WD: Valor a escribir
//           ByteORword: Señal de control para cuando se leen bytes
//                       en vez de palabras
//           ByteORwordS: Señal de control para cuando se escriben 
//                        bytes en vez de palabras
//           MemWrite: Señal de control que habilita la escritura
//           EN: Habilita el dispositivo
//           CLK: Señal de reloj
//           RST: Señal de reseteo
// Salidas:  RD: Valor leído
// Parametros: SIZE: Cantidad de palabras almacenables
//             OFFSET: Offset de la dirección de memoria de entrada

// Se introdujo este módulo para actuar como la memoria de la microarquitectura
// y almacenar todos los valores que se deben guardar en memoria
module DataMemory #(parameter SIZE = 32, OFFSET = 50) ( A, WD, ByteORword, ByteORwordS, MemWrite, RST, EN, CLK, RD);      

    input  [31:0]  A, WD; 
    input  ByteORword, ByteORwordS, MemWrite; 
    input  EN, CLK, RST; 
    
    output [31:0]  RD;
    
    reg  [31:0]  RD;
    //  Matriz para almacenar todos los valores de memoria       
    reg [7:0]  DataMem [0:((SIZE*4)-1)]; 
    integer i;
    
    // Escritura secuencial
    always @ (posedge CLK) begin
    
        if (RST == 1) begin //Si se resetea, todo se borra
                for (i = 0; i < (SIZE*4); i = i + 1) begin
                    DataMem [i] = 'h0; 
                end
                RD = 32'hx;
        end
        else begin //Si no
        
            if (EN == 1) begin
                if (MemWrite==1) begin //Escritura
                    
                    if (ByteORwordS==0) begin //Escribe palabras
                        DataMem[A+OFFSET] = WD[7:0];
                        DataMem[A+1+OFFSET] = WD[15:8];
                        DataMem[A+2+OFFSET] = WD[23:16];
                        DataMem[A+3+OFFSET] = WD[31:24];
                    end
                    else begin //Escribe bytes
                        DataMem[A+OFFSET] = WD[7:0];
                    end
                    
                end
            
            end 
                
        end
             
            
    end

    //Lectura combinacional
    always @* begin
        if (EN == 1) begin
            if (MemWrite==0) begin //Lectura
                        
                if (ByteORword==0) begin //Lee palabras
                    RD = {DataMem[A+3+OFFSET],DataMem[A+2+OFFSET],DataMem[A+1+OFFSET],DataMem[A+OFFSET]};
                end
                else begin //Lee bytes
                    RD = {24'b0,DataMem[A+OFFSET]};
                end
            
            end
        end
    
    end

endmodule