module arbitro1 (
    input clk, reset,
    input [1:0] dest,
    input [3:0] almost_full, empty,  // probablemente se deba usar almost_empty por retardos
    output reg [3:0] push, pop
);

// Pesos para prioridad de cada FIFO al que se hace pop
parameter WEIGHT_P0 = 4; 
parameter WEIGHT_P1 = 3;   
parameter WEIGHT_P2 = 2;
parameter WEIGHT_P3 = 1;   

reg [2:0] peso;

integer i = 0;
always @(posedge clk)begin
    if (reset) begin
        pop <= 0; push <= 0;
        i <= 0; peso <= WEIGHT_P0;
    end
    
    else begin
        // No pop ni push si todos los transmisores empty o un receptor almost_full
        if (&empty || |almost_full) begin   
            pop <= 0;
            push <= 0;
        end else begin
            case (i) 
                // Case prioridad pop P0
                0:begin  // Pop 4 veces o la cantidad de palabras si son menos de 4
                    if (peso > 1 && !empty[i]) begin
                        pop <= 4'b0001;
                        peso <= peso-1;
                    end else begin

                        // Pasar a siguiente fifo 
                        if (empty[i+1]) begin 
                            case (empty)
                                4'b0110: begin
                                    i <= 3;
                                    peso <= WEIGHT_P3;
                                end
                                4'b1110: peso <= WEIGHT_P0;
                                default: begin
                                    i <= 2;
                                    peso <= WEIGHT_P2;
                                end
                            endcase  
                        end else begin
                            i++;
                            peso <= WEIGHT_P1;
                        end 
                    end
                end
                // Case prioridad pop P1
                1:begin  // Pop 3 veces o la cantidad de palabras si son menos de 3
                    if (peso > 1 && !empty[i]) begin
                        pop <= 4'b0010;
                        peso <= peso-1;
                    end else begin

                        // Pasar a siguiente fifo    0100, 1100, 1101
                        if (empty[i+1]) begin
                            case (empty)
                                4'b1100: begin
                                    i <= 0;
                                    peso <= WEIGHT_P0;
                                end
                                4'b1101: peso <= WEIGHT_P1;
                                default: begin      // siguiente fifo está vacío
                                    i <= 3;
                                    peso <= WEIGHT_P3;
                                end
                            endcase  
                        end else begin
                            i++;
                            peso <= WEIGHT_P2;
                        end 
                    end                 
                end
                // Case prioridad pop P2
                2:begin  // Pop 2 veces o la cantidad de palabras si son menos de 2
                    if (peso > 1 && !empty[i]) begin  //  1000, 1001, 1011, 
                        pop <= 4'b0100;
                        peso <= peso-1;
                    end else begin

                        // Pasar a siguiente fifo 
                        if (empty[i+1]) begin
                            case (empty)
                                4'b1001: begin
                                    i <= 1;
                                    peso <= WEIGHT_P1;
                                end
                                4'b1011: peso <= WEIGHT_P2;
                                default: begin
                                    i <= 0;
                                    peso <= WEIGHT_P0;
                                end
                            endcase  
                        end else begin
                            i++;
                            peso <= WEIGHT_P3;
                        end 
                    end
                end
                // Case prioridad pop P3
                3:begin  // Pop 1 vez 
                    pop <= 4'b1000;
                    // Pasar a siguiente fifo     
                    if (empty[0]) begin
                        case (empty)
                            4'b0011: begin         // próximos dos fifos vacíos
                                i <= 2;
                                peso <= WEIGHT_P2;
                            end
                            4'b0111: peso <= WEIGHT_P3;  // el resto de fifos vacíos
                            default: begin          
                                i <= 1;
                                peso <= WEIGHT_P1;
                            end
                        endcase  
                    end else begin
                        i <= 0;                    // siguiente fifo no está vacío
                        peso <= WEIGHT_P0;
                    end      
                end 
                default: pop <= 4'b0000; 
            endcase
            
            // case para push
            case (dest)
                0: push <= 4'b0001;
                1: push <= 4'b0010; 
                2: push <= 4'b0100;
                3: push <= 4'b1000;
                default: push <= 4'b0000;
            endcase
        end
    end  
end
endmodule