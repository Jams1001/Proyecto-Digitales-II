module fsm
#(parameter UMBRALES_L_H = 8)
(
    input clk,
    input reset,
    input init,
    input [UMBRALES_L_H-1:0] umbral_L,
    input [UMBRALES_L_H-1:0] umbral_H,
    input empty_fifo_0,
    input empty_fifo_1,
    input empty_fifo_2,
    input empty_fifo_3,
    input empty_fifo_4,
    input empty_fifo_5,
    input empty_fifo_6,
    input empty_fifo_7,
    output reg [2:0] state,
    output reg [2:0] nxt_state,
    output reg [UMBRALES_L_H-1:0] umbral_L_out,
    output reg [UMBRALES_L_H-1:0] next_umbral_L_out,
    output reg [UMBRALES_L_H-1:0] umbral_H_out,
    output reg [UMBRALES_L_H-1:0] next_umbral_H_out,
    //output reg next_idle,
    output reg idle_out
);
    reg [7:0] FIFO_empties;
   
    parameter RESET = 0;    //000
    parameter INIT =1; //001
    parameter IDLE = 2;  //010
    parameter ACTIVE = 4;    //100
    
    always @(posedge clk) 
    begin
        if (reset==1) 
        begin
            state <= RESET;
            umbral_L_out<=8'b00000000;
            umbral_H_out<=8'b00000000;
            idle_out <= 0;
        end
        else 
        begin
            state <= nxt_state;
            umbral_L_out <= next_umbral_L_out;
            umbral_H_out <= next_umbral_H_out;
            //idle_out <= next_idle;
        end
    end
    always @(*) begin
        nxt_state = state;
      //  next_idle = idle_out;
        next_umbral_L_out = umbral_L_out;
        next_umbral_H_out = umbral_H_out;
        FIFO_empties[0] = empty_fifo_0; 
        FIFO_empties[1] = empty_fifo_1; 
        FIFO_empties[2] = empty_fifo_2; 
        FIFO_empties[3] = empty_fifo_3; 
        FIFO_empties[4] = empty_fifo_4; 
        FIFO_empties[5] = empty_fifo_5; 
        FIFO_empties[6] = empty_fifo_6; 
        FIFO_empties[7] = empty_fifo_7; 
        case(state)
            RESET:
                begin
                    if (reset==0) nxt_state = INIT;  
                    else nxt_state = RESET;
                end 

            INIT: 
                begin
                    if (reset==1) nxt_state = RESET; 
                    else if (init==0) nxt_state = IDLE; 
                    else if (reset==0 && init==1)
                    begin
                        next_umbral_L_out = umbral_L;
                        next_umbral_H_out = umbral_H;
                        nxt_state = INIT; 
                    end 

                end 
            IDLE: 
                begin
                    idle_out = 1;
                    if (reset==1) nxt_state = RESET;
                    else if (init==1) nxt_state = INIT;
                    else if (FIFO_empties == 'b11111111) nxt_state = IDLE;
                    else nxt_state = ACTIVE;
                end
            ACTIVE: 
            begin         
                    nxt_state = ACTIVE;
                    idle_out = 0;
                    if (reset==1) nxt_state = RESET;
                    else if (init==1) nxt_state = INIT;
                    else if (FIFO_empties == 'b11111111) nxt_state = IDLE;
                end
            default: nxt_state = RESET; 
        endcase    
    end
endmodule