`timescale 1ns / 1ps
// La funci�n de este m�dulo es asignar valores a distintas se�ales
// de control en funci�n de la instrucci�n que se est� ejecutando
// actualmente y de las banderas de la ALU.

// Entradas: opcode: Indica el tipo de instrucci�n a ejecutar
//           funct7: Utilizado en caso de operaciones tipo R
//           funct3: Utilizado en caso de operaciones tipo R
//           rd: Registro de destino
//           Z: Bandera de control, es 1 cuando Output=0
//           ABCD: Bandera de control, es 1 cuando Output=0xABCD
// Salidas:  PCDIRR: Selector de mux, decide qu� se le suma a PCOut
//           Sel1: Selector de mux, decide qu� se le escribe a Register File
//           RegSrc2: Selector de mux, decide qu� registro se lee en Register File
//           RegWrite: Habilita la escritura de RegisterFile
//           MemWrite: Habilita la escritura de DataMemory
//           MemtoReg: Selector de mux, decide si se toma el valor
//                     le�do de memoria o el resultado de la ALU
//           ByteORword: Es 1 si se va a leer un byte, si no se lee una palabra
//           ByteORwordS: Es 1 si se va a escribir un byte, si no se escribe una palabra
//           ALUSrc: Selector de mux, decide si se toma el valor del
//                   extensor de signo o del Register File para el
//                   operando B de la ALU
//           Jalr: Selector de mux, decide si se sobreescribe el valor de PC con
//                 la salida de la ALU o DataMemory
//           GPIOOn: Habilita la escritura en la GPIO
//           ImmSrc: Selecciona el tipo de manejo que se le va a dar al inmediato
//                   de la instrucci�n
//           ALUControl: Selecciona la operaci�n a realizar en la ALU

// Se introdujo este m�dulo para calcular todas las se�ales de control
// necesarias para el funcionamiento adecuado de los diferentes dispositivos
// y as� ejecutar las instrucciones.

module UC ( 

input [6:0]opcode,
input [31:25] funct7,   //en caso de operaciones tipo R
input [14:12] funct3,   //en caso de operaciones tipo R
input [4:0] rd,         //registro de destino
input Z, ABCD, //bandera que entra de la ALU
output reg [1:0] PCDIRR,
output reg [1:0] Sel1,
output reg RegSrc2, RegWrite, MemWrite, MemtoReg, ByteORword, ByteORwordS,ALUSrc, Jalr, GPIOOn,
output reg [2:0] ImmSrc,ALUControl

);

always @* begin
    case (opcode)
    
        7'b0110111: //opcode para instrucci�n tipo U
                begin
                
                // se hace para la instrucci�n lui y para la instrucci�n li que
                // es una instrucci�n lui pero se le suma 1 al inmediato
                
                    PCDIRR = 2'b01;
                    RegSrc2 = 1'bX;
                    Sel1 = 2'b10;
                    RegWrite = 1'b1;
                    ImmSrc = 3'b011;
                    ALUSrc = 1'bX;
                    ALUControl = 3'bXXX;
                    MemWrite = 1'b0;
                    MemtoReg = 1'bX;
                    ByteORword = 1'b0;
                    ByteORwordS = 1'b0;
                    Jalr = 1'b0;
                    GPIOOn = 0;
                
               
                end
                
         7'b1101111: //opcode para instrucci�n tipo J
         
                begin
                
                //tambi�n se tiene la variante de j
                //j es un jal (jal x0,imm)
                //se usa para isntrucciones tipo jal 
                
                if (rd==5'b00000)//se tiene una operaci�n j
                
                    begin
                    
                    PCDIRR = 2'b10;
                    RegSrc2 = 1'bX;
                    Sel1 = 2'b00;
                    RegWrite = 1'b1;
                    ImmSrc = 3'b101;
                    ALUSrc = 1'bX;
                    ALUControl = 3'bXXX;
                    MemWrite = 1'b0;
                    MemtoReg = 1'b0;
                    ByteORword = 1'b0;
                    ByteORwordS = 1'b0;
                    Jalr = 1'b0;
                    GPIOOn = 0;
                    
                    end
                
                else //instrucci�n jal normal
                    begin
                    
                    PCDIRR = 2'b10;
                    RegSrc2 = 1'bX;
                    Sel1 = 2'b00;
                    RegWrite = 1'b1;
                    ImmSrc = 3'b101;
                    ALUSrc = 1'bX;
                    ALUControl = 3'bXXX;
                    MemWrite = 1'b0;
                    MemtoReg = 1'b0;
                    ByteORword = 1'b0;
                    ByteORwordS = 1'b0;
                    Jalr = 1'b0;
                    GPIOOn = 0;
                    
                    end
               
                end
                
        7'b1100111: //para la instrucci�n jalr 
        
        
            begin
            
                PCDIRR = 2'bXX;
                RegSrc2 = 1'bX;
                Sel1 = 2'b00;
                RegWrite = 1'b1;
                ImmSrc = 3'b000;
                ALUSrc = 1'b1;
                ALUControl = 3'b000; //SUMA
                MemWrite = 1'b0;
                MemtoReg = 1'b0;
                ByteORword = 1'b0;
                ByteORwordS = 1'b0;
                Jalr = 1'b1;
                GPIOOn = 0;
            
            
            end
                
        7'b0110011: //opcode para instrucci�n tipo R
                begin
                
                //se tienen en las instrucciones tipo R a add y sub
                case(funct7) //el funct3 identifica la instrucci�n
                
                    7'b0000000://caso para add
                        begin
                           
                            PCDIRR = 2'b01;
                            RegSrc2 = 1'b0;
                            Sel1 = 2'b01;
                            RegWrite = 1'b1;
                            ImmSrc = 3'bXXX;
                            ALUSrc = 1'b0;
                            ALUControl = 3'b000;//SUMA;
                            MemWrite = 1'b0;
                            MemtoReg = 1'b0;
                            ByteORword = 1'b0;
                            ByteORwordS = 1'b0;
                            Jalr = 1'b0;
                            GPIOOn = 0;
                            
                           
                        end
                        
                    7'b0100000: //caso para sub
                        begin
                        
                            PCDIRR = 2'b01;
                            RegSrc2 = 1'b0;
                            Sel1 = 2'b01;
                            RegWrite = 1'b1;
                            ImmSrc = 3'bXXX;
                            ALUSrc = 1'b0;
                            ALUControl = 3'b001;//RESTA;
                            MemWrite = 1'b0;
                            MemtoReg = 1'b0;
                            ByteORword = 1'b0;
                            ByteORwordS = 1'b0;
                            Jalr = 1'b0;
                            GPIOOn = 0;
                            
                            
                        end
                
                endcase
                end
                
        7'b0010011: //opcode para instrucci�n tipo I
        
                begin
                
                //Se tienen las intrucciones addi, lw, srai, andi, xori, slli y lbu 
                //que son instrucciones de tipo I, el funct3 ayuda a identificar 
                //instrucci�n es
                
                case(funct3)
                
                3'b000: //Instrucci�n addi y variante de la addi, mv
                //se tiene la variante de mv
                begin 
                
                //caso para un addi 
                
    
                 PCDIRR = 2'b01;
                 RegSrc2 = 1'bX;
                 Sel1 = 2'b01;
                 RegWrite = 1'b1;
                 ImmSrc = 3'b000;
                 ALUSrc = 1'b1;
                 ALUControl = 3'b000;//SUMA
                 MemWrite = 1'b0;
                 MemtoReg = 1'b0;
                 ByteORword = 1'b0;
                 ByteORwordS = 1'b0;
                 Jalr = 1'b0;
                 GPIOOn = 0;
                            
                
                end
                
                
                3'b101: //Instrucci�n srai
                
                begin
                            PCDIRR = 2'b01;
                            RegSrc2 = 1'bX;
                            Sel1 = 2'b01;
                            RegWrite = 1'b1;
                            ImmSrc = 3'b001;
                            ALUSrc = 1'b1;
                            ALUControl = 3'b110; //SHIFT DER;
                            MemWrite = 1'b0;
                            MemtoReg = 1'b0;
                            ByteORword = 1'b0;
                            ByteORwordS = 1'b0;
                            Jalr = 1'b0;
                            GPIOOn = 0;
                            
                
                end
                
                3'b111: //Instrucci�n andi
                
                begin
                            PCDIRR = 2'b01;
                            RegSrc2 = 1'bX;
                            Sel1 = 2'b01;
                            RegWrite = 1'b1;
                            ImmSrc = 3'b000;
                            ALUSrc = 1'b1;
                            ALUControl = 3'b010; //AND;
                            MemWrite = 1'b0;
                            MemtoReg = 1'b0;
                            ByteORword = 1'b0;
                            ByteORwordS = 1'b0;
                            Jalr = 1'b0;
                            GPIOOn = 0;
                            
                
                end
                
                3'b100: //Instrucci�n xori
                
                begin
                            PCDIRR = 2'b01;
                            RegSrc2 = 1'bX;
                            Sel1 = 2'b01;
                            RegWrite = 1'b1;
                            ImmSrc = 3'b000;
                            ALUSrc = 1'b1;
                            ALUControl = 3'b100;//XOR;
                            MemWrite = 1'b0;
                            MemtoReg = 1'b0;
                            ByteORword = 1'b0;
                            ByteORwordS = 1'b0;
                            Jalr = 1'b0;
                            GPIOOn = 0;
                            
                
                end
                
                3'b001: //Instrucci�n slli
                
                begin
                            PCDIRR = 2'b01;
                            RegSrc2 = 1'bX;
                            Sel1 = 2'b01;
                            RegWrite = 1'b1;
                            ImmSrc = 3'b001;
                            ALUSrc = 1'b1;
                            ALUControl = 3'b101; //SHIFT IZQ;
                            MemWrite = 1'b0;
                            MemtoReg = 1'b0;
                            ByteORword = 1'b0;
                            ByteORwordS = 1'b0;
                            Jalr = 1'b0;
                            GPIOOn = 0;
                            
                
                end
                
                endcase
                
              
                end
         
         7'b0000011: //opcode para instrucci�n tipo LOAD
         
                begin
                
                //se tienen las instrucciones lbu,lw
                case(funct3)
                
                3'b100://caso para lbu
                begin
                     PCDIRR = 2'b01;
                     RegSrc2 = 1'bX;
                     Sel1 = 2'b01;
                     RegWrite = 1'b1;
                     ImmSrc = 3'b000;
                     ALUSrc = 1'b1;
                     ALUControl = 3'b000;//SUMA; 
                     MemWrite = 1'b0;
                     MemtoReg = 1'b1;
                     ByteORword = 1'b1;
                     ByteORwordS = 1'b0;
                     Jalr = 1'b0;
                     GPIOOn = 0;
                       
                     
                end
                
                3'b010://caso para lw
                begin
                     PCDIRR = 2'b01;
                     RegSrc2 = 1'bX;
                     Sel1 = 2'b01;
                     RegWrite = 1'b1;
                     ImmSrc = 3'b000;
                     ALUSrc = 1'b1;
                     ALUControl = 3'b000; //SUMA;
                     MemWrite = 1'b0;
                     MemtoReg = 1'b1;
                     ByteORword = 1'b0;
                     ByteORwordS = 1'b0;
                     Jalr = 1'b0;
                     GPIOOn = 0;
                        
                     
                end
                
                endcase
                end    
                   
         7'b0100011: //opcode para instrucci�n tipo S
                begin
                
                
                //se tienen las instrucciones sb y sw
                case(funct3)
                
                3'b000:
                
                     begin //caso para sb
               
                     PCDIRR = 2'b01;
                     RegSrc2 = 1'b0;
                     Sel1 = 2'bXX;
                     RegWrite = 1'b0;
                     ImmSrc = 3'b010;
                     ALUSrc = 1'b1;
                     ALUControl = 3'b000; //SUMA;
                     MemWrite = ~ABCD;
                     MemtoReg = 1'bX;
                     ByteORword = 1'b0;
                     ByteORwordS = 1'b1;
                     Jalr = 1'b0;
                     GPIOOn = ABCD;
                     
                
                end
                
                3'b010: 
                begin //caso para sw
                
                     PCDIRR = 2'b01;
                     RegSrc2 = 1'b0;
                     Sel1 = 2'b01;
                     RegWrite = 1'b0;
                     ImmSrc = 3'b010;
                     ALUSrc = 1'b1;
                     ALUControl = 3'b000; //SUMA;
                     MemWrite = ~ABCD;
                     MemtoReg = 1'b0;
                     ByteORword = 1'b0;
                     ByteORwordS = 1'b0;
                     Jalr = 1'b0;
                     GPIOOn = ABCD;
                     
                
                end
                endcase
         
                
                
                end
                
          7'b1100011: //opcode para instrucci�n tipo B
                begin
                
                //la instrucci�n tipo B que se necesita es la operaci�n BNE
                //el compare se realiza 
                if (Z==0) //se realiza el branch
                
                    begin
                
                        PCDIRR = 2'b10;
                        RegSrc2 = 1'b0;
                        Sel1 = 2'bXX;
                        RegWrite = 1'b0;
                        ImmSrc = 3'b100;
                        ALUSrc = 1'b0;
                        ALUControl = 3'b001; //RESTA
                        MemWrite = 1'b0;
                        MemtoReg = 1'b0;
                        ByteORword = 1'b0;
                        ByteORwordS = 1'b0;
                        Jalr = 1'b0;
                        GPIOOn = 0;
                    
                    end
                
                else begin
                
                //se�ales de control para cuando rs1 si es igual a rs2
                //es decir, no se realiza el branch
                
                        PCDIRR = 2'b01;
                        RegSrc2 = 1'b0;
                        Sel1 = 2'bXX;
                        RegWrite = 1'b0;
                        ImmSrc = 3'b100;
                        ALUSrc = 1'b0;
                        ALUControl = 3'b001; //RESTA
                        MemWrite = 1'b0;
                        MemtoReg = 1'b0;
                        ByteORword = 1'b0;
                        ByteORwordS = 1'b0;
                        Jalr = 1'b0;
                        GPIOOn = 0;
                        
                end
                
                end
          default:
          begin
                PCDIRR = 2'b01;
                Jalr = 1'b0;
                GPIOOn = 0;
          end
         
    endcase 
    
    end
endmodule
