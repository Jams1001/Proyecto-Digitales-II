module contadores( 
    input CLK, 
    /* 
    Cada pop está asociado a un FIFO. pop4 = El pop del fifo amarillo de abajo,
    horizontal. pop0-3, son los pops que se le hacen a los 4 fifos de arriba 
    (FFO-3).  
    */
    input pop4, pop0, pop1, pop2, pop3,                      
    input req,
    input IDLE,
    input [2:0] idx,
    input reset,
    input [4:0] empty, 
    /* 
    Solo se va a leer un contador a la vez, según el index lo indique.
    data es el reg por el que se va a sacar el cntFF de interés.  
    */
    output reg [7:0] data,
    output reg valid);
    /* 
    cntFF = Counter FIFO = Da la cuenta de las palabras que salen de ese FIFO.
    (FIFOS azules de derecha a izquierda).
    */   
    reg [7:0] cntFF4;   
    reg [4:0] cntFF0;   
    reg [4:0] cntFF1;   
    reg [4:0] cntFF2;
    reg [4:0] cntFF3; 

    always @(*) begin
        if (!req || !IDLE) begin    
            valid = 0;
            data = 5'b0;  
        end
        else begin
            valid = 1;
            if (idx == 3'b000) begin
                data = cntFF0;
            end 
            else if (idx == 3'b001) begin
                data = cntFF1;
            end 
            else if (idx == 3'b010) begin
                data = cntFF2;
            end
            else if (idx == 3'b011) begin
                data = cntFF3;
            end  
            else if (idx == 3'b100) begin
                data = cntFF4;
            end
            else begin
                data = 5'b0;
            end
        end
    end
    always @(posedge CLK)begin
        if(!reset) begin
            if(pop4 && !empty[4]) begin               // contador de fifoin
                cntFF4 <= cntFF4 + 1;
            end
            if(pop0 && !empty[0]) begin
                cntFF0 <= cntFF0 + 1;
            end
            if(pop1 && !empty[1]) begin
                cntFF1 <= cntFF1 + 1;
            end
            if(pop2 && !empty[2]) begin
                cntFF2 <= cntFF2 + 1;
            end
            if(pop3 && !empty[3]) begin
                cntFF3 <= cntFF3 + 1;
            end
        end
        else begin
            cntFF4 = 5'b0;
            cntFF0 = 5'b0;
            cntFF1 = 5'b0;
            cntFF2 = 5'b0;
            cntFF3 = 5'b0;
        end
    end
endmodule