`timescale 1ns / 1ps
// La función de este módulo es tomar un valor de 32 bits y
// a partir de este manejarlo para obtener una salida en base
// a una selección de la máscara o reacomodo requerido

// Entradas: morse: Valor de 32 de bits de entrada, instrucción actual
//           selec: Selección de tipo de inmediato de salida
// Salida: salida: Inmediato construido a partir de morse en base a selec

// Se introdujo este módulo para tomar la instrucción actual y obtener 
// el inmediato requerido para la ejecución de la instrucción
 module ExtensorDeSigno(morse, selec, salida
    );
	input [31:0] morse;
	input [2:0] selec;
	output reg [31:0] salida;
   always @*
      case (selec)
         3'b000: begin
         //Inmediato i
               salida[31] = morse[31];
               salida[30] = morse[31];
               salida[29] = morse[31];
               salida[28] = morse[31];
               salida[27] = morse[31];
               salida[26] = morse[31];
               salida[25] = morse[31];
               salida[24] = morse[31];
               salida[23] = morse[31];
               salida[22] = morse[31];
               salida[21] = morse[31];
               salida[20] = morse[31];
               salida[19] = morse[31];
               salida[18] = morse[31];
               salida[17] = morse[31];
               salida[16] = morse[31];
               salida[15] = morse[31];
               salida[14] = morse[31];
               salida[13] = morse[31];
               salida[12] = morse[31];
               salida[11] = morse[31];
               salida[10] = morse[30];
               salida[9] = morse[29];
               salida[8] = morse[28];
               salida[7] = morse[27];
               salida[6] = morse[26];
               salida[5] = morse[25];
               salida[4] = morse[24];
               salida[3] = morse[23];
               salida[2] = morse[22];
               salida[1] = morse[21];
               salida[0] = morse[20];
                                   
          end
         3'b001: 
                begin
         //shamt_i
               salida[31] = 0;
               salida[30] = 0;
               salida[29] = 0;
               salida[28] = 0;
               salida[27] = 0;
               salida[26] = 0;
               salida[25] = 0;
               salida[24] = 0;
               salida[23] = 0;
               salida[22] = 0;
               salida[21] = 0;
               salida[20] = 0;
               salida[19] = 0;
               salida[18] = 0;
               salida[17] = 0;
               salida[16] = 0;
               salida[15] = 0;
               salida[14] = 0;
               salida[13] = 0;
               salida[12] = 0;
               salida[11] = 0;
               salida[10] = 0;
               salida[9] = 0;
               salida[8] = 0;
               salida[7] = 0;
               salida[6] = 0;
               salida[5] = 0;
               salida[4] = morse[24];
               salida[3] = morse[23];
               salida[2] = morse[22];
               salida[1] = morse[21];
               salida[0] = morse[20];
               
         
         end
         3'b010: begin
         //Inmediato S
               salida[31] = morse[31];
               salida[30] = morse[31];
               salida[29] = morse[31];
               salida[28] = morse[31];
               salida[27] = morse[31];
               salida[26] = morse[31];
               salida[25] = morse[31];
               salida[24] = morse[31];
               salida[23] = morse[31];
               salida[22] = morse[31];
               salida[21] = morse[31];
               salida[20] = morse[31];
               salida[19] = morse[31];
               salida[18] = morse[31];
               salida[17] = morse[31];
               salida[16] = morse[31];
               salida[15] = morse[31];
               salida[14] = morse[31];
               salida[13] = morse[31];
               salida[12] = morse[31];
               salida[11] = morse[31];
               salida[10] = morse[30];
               salida[9] = morse[29];
               salida[8] = morse[28];
               salida[7] = morse[27];
               salida[6] = morse[26];
               salida[5] = morse[25];
               salida[4] = morse[11];
               salida[3] = morse[10];  
               salida[2] = morse[9];
               salida[1] = morse[8];
               salida[0] = morse[7];
         end
         3'b011: //Inmediato U ;
                begin
               salida[31] = morse[31];
               salida[30] = morse[30];
               salida[29] = morse[29];
               salida[28] = morse[28];
               salida[27] = morse[27];
               salida[26] = morse[26];
               salida[25] = morse[25];
               salida[24] = morse[24];
               salida[23] = morse[23];
               salida[22] = morse[22];
               salida[21] = morse[21];
               salida[20] = morse[20];
               salida[19] = morse[19];
               salida[18] = morse[18];
               salida[17] = morse[17];
               salida[16] = morse[16];
               salida[15] = morse[15];
               salida[14] = morse[14];
               salida[13] = morse[13];
               salida[12] = morse[12];
               salida[11] = 0;
               salida[10] = 0;
               salida[9] = 0;
               salida[8] = 0;
               salida[7] = 0;
               salida[6] = 0;
               salida[5] = 0;
               salida[4] = 0;
               salida[3] = 0;
               salida[2] = 0;
               salida[1] = 0;
               salida[0] = 0;
             end
         3'b100: //Inmediato B 
                begin
               salida[31] = morse[31];
               salida[30] = morse[31];
               salida[29] = morse[31];
               salida[28] = morse[31];
               salida[27] = morse[31];
               salida[26] = morse[31];
               salida[25] = morse[31];
               salida[24] = morse[31];
               salida[23] = morse[31];
               salida[22] = morse[31];
               salida[21] = morse[31];
               salida[20] = morse[31];
               salida[19] = morse[31];
               salida[18] = morse[31];
               salida[17] = morse[31];
               salida[16] = morse[31];
               salida[15] = morse[31];
               salida[14] = morse[31];
               salida[13] = morse[31];
               salida[12] = morse[31];
               salida[11] = morse[7];
               salida[10] = morse[30];
               salida[9] = morse[29];
               salida[8] = morse[28];
               salida[7] = morse[27];
               salida[6] = morse[26];
               salida[5] = morse[25];
               salida[4] = morse[11];
               salida[3] = morse[10];
               salida[2] = morse[9];
               salida[1] = morse[8];
               salida[0] = 0;
                 end
         3'b101: begin
         //Immediato J
               salida[31] = morse[31];
               salida[30] = morse[31];
               salida[29] = morse[31];
               salida[28] = morse[31];
               salida[27] = morse[31];
               salida[26] = morse[31];
               salida[25] = morse[31];
               salida[24] = morse[31];
               salida[23] = morse[31];
               salida[22] = morse[31];
               salida[21] = morse[31];
               salida[20] = morse[31];
               salida[19] = morse[19];
               salida[18] = morse[18];
               salida[17] = morse[17];
               salida[16] = morse[16];
               salida[15] = morse[15];
               salida[14] = morse[14];
               salida[13] = morse[13];
               salida[12] = morse[12];
               salida[11] = morse[20];
               salida[10] = morse[30];
               salida[9] = morse[29];
               salida[8] = morse[28];
               salida[7] = morse[27];
               salida[6] = morse[26];
               salida[5] = morse[25];
               salida[4] = morse[24];
               salida[3] = morse[23];
               salida[2] = morse[22];
               salida[1] = morse[21];
               salida[0] = 0;
         end
         3'b110: ;
         3'b111: begin
                   //cero
               salida[31] = 0;
               salida[30] = 0;
               salida[29] = 0;
               salida[28] = 0;
               salida[27] = 0;
               salida[26] = 0;
               salida[25] = 0;
               salida[24] = 0;
               salida[23] = 0;
               salida[22] = 0;
               salida[21] = 0;
               salida[20] = 0;
               salida[19] = 0;
               salida[18] = 0;
               salida[17] = 0;
               salida[16] = 0;
               salida[15] = 0;
               salida[14] = 0;
               salida[13] = 0;
               salida[12] = 0;
               salida[11] = 0;
               salida[10] = 0;
               salida[9] = 0;
               salida[8] = 0;
               salida[7] = 0;
               salida[6] = 0;
               salida[5] = 0;
               salida[4] = 0;
               salida[3] = 0;
               salida[2] = 0;
               salida[1] = 0;
               salida[0] = 0;
                end
         	
			default : salida = 0;
      endcase

endmodule