`timescale 1ns / 1ps
// La función de este módulo es actuar como el dispositivos de lectura
// y escritura de registros. Estos registros son correspondientes a los
// definidos en RISCV32, por lo que hay un total de 32 registros.
// El registro 0 siempre tiene el valor de 0, los demás registros tienen
// un valor inicial de 200, para evitar que algunas direcciones de memoria
// resulten negativas.
// La lectura es combinacional, mientras que la escritura es secuencial.

// Entradas: WD: Valor a escribir
//           A1: Registro de lectura 1
//           A2: Registro de lectura 2
//           A3: Registro de escritura
//           RegWrite: Activa la escritura
//           EN: Habilita el dispositivo
//           CLK: Señal de reloj
//           RST: Reinicia el dispositivo
// Salidas:  RD1: Valor leído 1
//           RD2: Valor leído 2

// Se introdujo este módulo para poder utilizar los registros necesarios
// en la ejecución de las diferentes instrucciones, de tal manera que se
// pudieran cargar valores en los registros y luego utilizarlos en otras 
// operaciones.
module RegisterFile( WD, A3, RD1,A1, RD2, A2, RegWrite, RST, EN, CLK);      

    input  [31:0]  WD; 
    input  [4:0]  A3, A1, A2; 
    input  RegWrite; 
    input  EN, CLK, RST; 
    
    output [31:0]  RD1, RD2; 
    
    reg  [31:0]  RD1, RD2;       
    reg [31:0]  regFile [0:31]; 
    integer i;  
//  Escritura secuencial
    always @ (posedge CLK) begin

        if (RST == 1) begin //Si se resetea, valor inicial 200
                for (i = 1; i < 32; i = i + 1) begin
                    regFile [i] = 32'd200; 
                end
                RD1 = 32'hx;
            end 
        else begin
            if (EN == 1) begin
                // Si se va a escribir
                if (RegWrite == 1) begin
                
                    regFile [A3] = WD;
                
                end
            end      
        end     
    end
// Lectura combinacional
    always @* begin
        
        //Se leen los registros y se asigna 0 al
        // registro 0
        if (EN == 1) begin
        
            regFile [0] = 32'h0;
            
            RD1 = regFile [A1]; 
                            
            RD2 = regFile [A2];
        end
    
    end

endmodule