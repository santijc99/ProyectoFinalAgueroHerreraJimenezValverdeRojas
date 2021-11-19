`timescale 1ns / 1ps
// Objetivo de la prueba: Observar que el uut realice los distintos manejos
//                        de inmediato a una misma instrucción
// Estímulos: Se inicia la uut con un selec en 0 y morse con un valor
//            específico (7fdf0e71), este valor se mantiene constante 
//            Luego se cambia el valor de selec por todos los valores posibles
          
// Resultados esperados: Se espera observar que los valores adecuados de los
//                       manejos de inmediatos
//                       En secuencia se espera obtener: 000007fd, 0000001d,
//                       000007fc, 7fdf0000, 000007fc, 000f0ffc, 000f0ffc, 00000000
module ExtensorDeSignoTB;
//input
reg [31:0] morse;
reg [2:0] selec;

//output
wire [31:0] salida;

ExtensorDeSigno uut(
                   .morse(morse),
                   .selec(selec),
                   .salida(salida));
 integer k = 0;
 initial
 begin
 selec = 0;
 morse = 2145324657;
 for(k=0;k<8;k = k+1)
 begin
 #10 selec = k;
 end
 
 end

endmodule
