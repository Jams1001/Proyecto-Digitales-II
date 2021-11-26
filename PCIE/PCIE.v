`include "contadores.v"
`include "fifo.v"
`include "arbitro1.v"
`include "arbitro2.v"
`include "fsm.v"

module PCIE
#(parameter UMBRALES_L_H = 8,
parameter TAMANO_DATOS = 12)
(
	input push_probador,
	input [3:0] pop_probador,
	input [11:0] data_in,
	input reset,
	input clk,
	input req,
	input [2:0] idx,
	input [UMBRALES_L_H-1:0] umbral_L,
	input [UMBRALES_L_H-1:0] umbral_H,
	output [TAMANO_DATOS-1:0] data_out4,
	output [TAMANO_DATOS-1:0] data_out5,
	output [TAMANO_DATOS-1:0] data_out6,
	output [TAMANO_DATOS-1:0] data_out7
); 

    //parameter TAMANO_DIRECCION = 8;

	// #### CABLES ####
    // Cables de Fifo in (Primer fifo amarillo)
	wire empty_in;
    wire full_in; 
    wire almost_full_in; 
    wire almost_empty_in; 
    wire error_in; 
    wire [2:0] wr_ptr_in; 
    wire [2:0] rd_ptr_in; 
    wire [TAMANO_DATOS-1:0] data_out_in;  

	// Cables de Fifo in2  (Fifo 'celeste')
	wire empty_in2;
    wire full_in2; 
    wire almost_full_in2; 
    wire almost_empty_in2; 
    wire error_in2; 
    wire [2:0] wr_ptr_in2; 
    wire [2:0] rd_ptr_in2; 
    reg [TAMANO_DATOS-1:0] data_in2;
    wire [TAMANO_DATOS-1:0] data_out_in2;
    wire write_enable_in2;
    wire read_enable_in2;
    
    //  Árbitro 1 y Árbitro 2
    wire [3:0] almost_full_arbitro2;
	wire pop_arbitro2;
    wire [3:0] push_arbitro2;
	wire [3:0] pop_arbitro1;
	wire [3:0] push_arbitro1; 
	wire [3:0] almost_empty_arbitro1;  // Conectado a almost_empty de los fifos
	wire [3:0] almost_full_arbitro1;
	wire [3:0] empty_arbitro1;

	// Umbrales
	wire [7:0] umbral_alto;
	wire [7:0] umbral_bajo;
	
    // Fifo 0
    wire full_0; 
    //wire empty_0; 
    wire error_0; 
    wire [2:0] wr_ptr_0; 
    wire [2:0] rd_ptr_0; 
    wire [TAMANO_DATOS-1:0] data_out_0;
	
    // Fifo 1
    wire full_1; 
    //wire empty_1; 
    wire error_1; 
    wire [2:0] wr_ptr_1; 
    wire [2:0] rd_ptr_1; 
    wire [TAMANO_DATOS-1:0] data_out_1;


    // Fifo 2
    wire full_2; 
    //wire empty_2; 
    wire error_2; 
    wire [2:0] wr_ptr_2; 
    wire [2:0] rd_ptr_2; 
    wire [TAMANO_DATOS-1:0] data_out_2;
    
    // Fifo 3
    wire full_3; 
    //wire empty_3; 
    wire error_3; 
    wire [2:0] wr_ptr_3; 
    wire [2:0] rd_ptr_3; 
    wire [TAMANO_DATOS-1:0] data_out_3;
	


	// Fifo 4
    wire full_4; 
    wire empty_4;
	wire almost_empty_4; 
    wire error_4; 
    wire [2:0] wr_ptr_4; 
    wire [2:0] rd_ptr_4; 

	// Fifo 5
    wire full_5; 
    wire empty_5;
	wire almost_empty_5; 
    wire error_5; 
    wire [2:0] wr_ptr_5; 
    wire [2:0] rd_ptr_5; 

	// Fifo 6
    wire full_6; 
    wire empty_6;
	wire almost_empty_6; 
    wire error_6; 
    wire [2:0] wr_ptr_6; 
    wire [2:0] rd_ptr_6; 
	
	// Fifo 7
    wire full_7; 
    wire empty_7;
	wire almost_empty_7; 
    wire error_7; 
    wire [2:0] wr_ptr_7; 
    wire [2:0] rd_ptr_7; 

	// Contador
	wire [4:0] data;
	wire valid;

	// FSM
	wire req;
	wire IDLE;
	wire [2:0] idx;

// #### INSTANCIAS ####
fifo fifoin(/*AUTOINST*/
	    // Outputs
	    .full			(full_in),
	    .empty			(empty_in),
	    .almost_full		(almost_full_in),
	    .almost_empty		(almost_empty_in),
	    .error			(error_in),
	    .wr_ptr			(wr_ptr_in[2:0]),
	    .rd_ptr			(rd_ptr_in[2:0]),
		.umbral_bajo	(umbral_bajo),
	    .umbral_alto	(umbral_alto),
	    .data_out			(data_out_in[TAMANO_DATOS-1:0]),
	    // Inputs
	    .clk			(clk),
	    .reset			(reset),
	    .write_enable		(push_probador),
	    .read_enable		(pop_arbitro2),
	    .data_in			(data_in[11:0]));

fifo fifo0(/*AUTOINST*/
	   // Outputs
	   .full			(full_0),
	   .empty			(empty_arbitro1[0]),
	   .almost_full			(almost_full_arbitro2[0]),
	   .almost_empty		(almost_empty_arbitro1[0]),
	   .error			(error_0),
	   .wr_ptr			(wr_ptr_0[2:0]),
	   .rd_ptr			(rd_ptr_0[2:0]),
	   .umbral_bajo		(umbral_bajo),
	   .umbral_alto		(umbral_alto),
	   .data_out			(data_out_0[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(push_arbitro2[0]),
	   .read_enable			(pop_arbitro1[0]),
	   .data_in			(data_out_in));
       
fifo fifo1(/*AUTOINST*/
	   // Outputs
	   .full			(full_1),
	   .empty			(empty_arbitro1[1]),
	   .almost_full			(almost_full_arbitro2[1]),
	   .almost_empty		(almost_empty_arbitro1[1]),
	   .error			(error_1),
	   .wr_ptr			(wr_ptr_1[2:0]),
	   .rd_ptr			(rd_ptr_1[2:0]),
	   .umbral_bajo		(umbral_bajo),
	   .umbral_alto		(umbral_alto),
	   .data_out			(data_out_1[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(push_arbitro2[1]),
	   .read_enable			(pop_arbitro1[1]),
	   .data_in			(data_out_in));

fifo fifo2(/*AUTOINST*/
	   // Outputs
	   .full			(full_2),
	   .empty			(empty_arbitro1[2]),
	   .almost_full			(almost_full_arbitro2[2]),
	   .almost_empty		(almost_empty_arbitro1[2]),
	   .error			(error_2),
	   .wr_ptr			(wr_ptr_2[2:0]),
	   .rd_ptr			(rd_ptr_2[2:0]),
	   .umbral_bajo		(umbral_bajo),
	   .umbral_alto		(umbral_alto),
	   .data_out			(data_out_2[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(push_arbitro2[2]),
	   .read_enable			(pop_arbitro1[2]),
	   .data_in			(data_out_in));

fifo fifo3(/*AUTOINST*/
	   // Outputs
	   .full			(full_3),
	   .empty			(empty_arbitro1[3]),
	   .almost_full			(almost_full_arbitro2[3]),
	   .almost_empty		(almost_empty_arbitro1[3]),
	   .error			(error_3),
	   .wr_ptr			(wr_ptr_3[2:0]),
	   .rd_ptr			(rd_ptr_3[2:0]),
	   .umbral_bajo		(umbral_bajo),
	   .umbral_alto		(umbral_alto),
	   .data_out			(data_out_3[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(push_arbitro2[3]),
	   .read_enable			(pop_arbitro1[3]),
	   .data_in			(data_out_in));

arbitro2 arbitro_2(/*AUTOINST*/
		   // Inputs
		   .clk			(clk),
		   .empty		(empty_in),
		   .reset		(reset),
           .class       (data_in[11:10]),
           .almost_full (almost_full_arbitro2),
           // Outputs
           .pop         (pop_arbitro2),
           .push        (push_arbitro2));

fifo fifoin2(/*AUTOINST*/					
				// Outputs
		.full			(full_in2),
		.empty			(empty_in2),
		.almost_full		(almost_full_in2),
		.almost_empty		(almost_empty_in2),
		.error			(error_in2),
		.wr_ptr			(wr_ptr_in2[2:0]),
		.rd_ptr			(rd_ptr_in2[2:0]),
		.umbral_bajo		(umbral_bajo),
	   .umbral_alto		(umbral_alto),
		.data_out			(data_out_in2),
	     // Inputs
	     .clk			(clk),
	     .reset			(reset),
	     .write_enable		(!reset),  // siempre activados cuando reset bajo
	     .read_enable		(!reset),
	     .data_in			(data_in2));

always @(*) begin			// Mux para seleccionar cual salida va a Fifo_in2
	case (pop_arbitro1)
		4'b0001: begin
			data_in2 = data_out_0;
		end
		4'b0010: begin
			data_in2 = data_out_1;
		end
		4'b0100: begin
			data_in2 = data_out_2;
		end
		4'b1000: begin
			data_in2 = data_out_3;
		end
		default: data_in2 = 0;
	endcase
end

arbitro1 arbitro_1(/*AUTOINST*/
		   // Outputs
		   .push		(push_arbitro1),
		   .pop			(pop_arbitro1),
		   // Inputs
		   .clk			(clk),
		   .reset		(reset),
		   .dest		(data_out_in2[9:8]),
		   .almost_full		(almost_full_arbitro1),
		   .empty		(empty_arbitro1));		 
		   

fifo fifo4(/*AUTOINST*/
	   // Outputs
	   .full			(full_4),
	   .empty			(empty_4),
	   .almost_full			(almost_full_arbitro1[0]),
	   .almost_empty		(almost_empty_4),
	   .error			(error_4),
	   .wr_ptr			(wr_ptr_4[2:0]),
	   .rd_ptr			(rd_ptr_4[2:0]),
	   	.umbral_bajo		(umbral_bajo),
	   .umbral_alto		(umbral_alto),
	   .data_out			(data_out4),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(push_arbitro1[0]),
	   .read_enable			(pop_probador[0]), 				
	   .data_in			(data_out_in2));
	   
fifo fifo5(/*AUTOINST*/
	   // Outputs
	   .full			(full_5),
	   .empty			(empty_5),
	   .almost_full			(almost_full_arbitro1[1]),
	   .almost_empty		(almost_empty_5),
	   .error			(error_5),
	   .wr_ptr			(wr_ptr_5[2:0]),
	   .rd_ptr			(rd_ptr_5[2:0]),
		.umbral_bajo		(umbral_bajo),
	   .umbral_alto		(umbral_alto),
	   .data_out			(data_out5),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(push_arbitro1[1]),
	   .read_enable			(pop_probador[1]), // POP QUE VIENE DEL PROBADOR
	   .data_in			(data_out_in2));
	   
fifo fifo6(/*AUTOINST*/
	   // Outputs
	   .full			(full_6),
	   .empty			(empty_6),
	   .almost_full			(almost_full_arbitro1[2]),
	   .almost_empty		(almost_empty_6),
	   .error			(error_6),
	   .wr_ptr			(wr_ptr_6[2:0]),
	   .rd_ptr			(rd_ptr_6[2:0]),
	   	.umbral_bajo		(umbral_bajo),
	   .umbral_alto		(umbral_alto),
	   .data_out			(data_out6),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(push_arbitro1[2]),
	   .read_enable			(pop_probador[2]), // POP QUE VIENE DEL PROBADOR
	   .data_in			(data_out_in2));

fifo fifo7(/*AUTOINST*/
	   // Outputs
	   .full			(full_7),
	   .empty			(empty_7),
	   .almost_full			(almost_full_arbitro1[3]),
	   .almost_empty		(almost_empty_7),
	   .error			(error_7),
	   .wr_ptr			(wr_ptr_7[2:0]),
	   .rd_ptr			(rd_ptr_7[2:0]),
	   	.umbral_bajo		(umbral_bajo),
	   .umbral_alto		(umbral_alto),
	   .data_out			(data_out7),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(push_arbitro1[3]),
	   .read_enable			(pop_probador[3]), // POP QUE VIENE DEL PROBADOR
	   .data_in			(data_out_in2));

contadores contadores1(/*AUTOINST*/
		     // Outputs
		     .data		(data[4:0]),
		     .valid		(valid),
		     // Inputs
		     .CLK		(clk),
		     .pop4		(pop_arbitro2), 	//ESTE POP 4 ES ELPOP AMARILLO HORIZONTAL
		     .pop0		(pop_probador[0]),
		     .pop1		(pop_probador[1]),
		     .pop2		(pop_probador[2]),
		     .pop3		(pop_probador[3]),
		     .req		(req),
		     .IDLE		(IDLE),
		     .idx		(idx[2:0]),
		     .reset		(reset));

fsm maquina(/*AUTOINST*/
	    // Outputs
	    //.state			(state[2:0]),
	    //.nxt_state			(nxt_state[2:0]),
	    .umbral_L_out		(umbral_bajo),
		.umbral_H_out       (umbral_alto),
	    //.next_umbral_LH_out		(next_umbral_LH_out[UMBRALES_L_H-1:0]),
	    .idle_out			(IDLE),
	    // Inputs
	    .clk			(clk),
	    .reset			(reset),
	    .init			(init),
	    .umbral_L		(umbral_L[UMBRALES_L_H-1:0]),
		.umbral_H	    (umbral_H[UMBRALES_L_H-1:0]),
		// Árbitro 1 usa los almost_empty de fifos 0-3 como condición de parar los pops
	    .empty_fifo_0		(empty_arbitro1[0]),	
	    .empty_fifo_1		(empty_arbitro1[1]),
	    .empty_fifo_2		(empty_arbitro1[2]),
	   .empty_fifo_3		(empty_arbitro1[3]),
	    .empty_fifo_4		(empty_4),
	    .empty_fifo_5		(empty_5),
	    .empty_fifo_6		(empty_6),
	    .empty_fifo_7		(empty_7));



endmodule
