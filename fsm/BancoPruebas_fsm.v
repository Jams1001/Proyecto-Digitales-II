`include "probador_fsm.v"
`include "fsm.v"
`include "fsm_synth.v"
module BancoPruebas_fsm();
  parameter UMBRALES_L_H=8;

  wire reset,clk,init;

  wire [UMBRALES_L_H-1:0] umbral_LH;

  wire empty_fifo_0,empty_fifo_1,empty_fifo_2,empty_fifo_3,empty_fifo_4,empty_fifo_5,empty_fifo_6,empty_fifo_7;

  wire [2:0] state;
  wire [2:0] nxt_state;
  wire [2:0] state_synth;
  wire [2:0] nxt_state_synth;

  wire [UMBRALES_L_H-1:0] umbral_LH_out;

  wire [UMBRALES_L_H-1:0] next_umbral_LH_out;

  wire [UMBRALES_L_H-1:0] umbral_LH_out_synth;

  wire [UMBRALES_L_H-1:0] next_umbral_LH_out_synth;

  fsm#(.UMBRALES_L_H(8)) 
  fsm_bp(/*AUTOINST*/
		   // Outputs
		   .state		(state[2:0]),
		   .nxt_state			(nxt_state[2:0]),
		   .umbral_LH_out		(umbral_LH_out[UMBRALES_L_H-1:0]),
		   .next_umbral_LH_out	(next_umbral_LH_out[UMBRALES_L_H-1:0]),
		   // Inputs
		   .clk				(clk),
		   .reset			(reset),
		   .init			(init),
		   .umbral_LH		(umbral_LH[UMBRALES_L_H-1:0]),
		   .empty_fifo_0 	(empty_fifo_0),
		   .empty_fifo_1 	(empty_fifo_1),
           .empty_fifo_2 	(empty_fifo_2),
           .empty_fifo_3 	(empty_fifo_3),
           .empty_fifo_4 	(empty_fifo_4),
           .empty_fifo_5 	(empty_fifo_5),
           .empty_fifo_6 	(empty_fifo_6),
           .empty_fifo_7 	(empty_fifo_7)
		);
  fsm_synth fsm_synth_bp(/*AUTOINST*/
			// Outputs
			.nxt_state			(nxt_state_synth[2:0]),
			.state		(state_synth[2:0]),
			.umbral_LH_out		(umbral_LH_out_synth[UMBRALES_L_H-1:0]),
			.next_umbral_LH_out	(next_umbral_LH_out_synth[UMBRALES_L_H-1:0]),
			// Inputs
			.clk			(clk),
			.init			(init),
			.reset			(reset),
			.umbral_LH		(umbral_LH[UMBRALES_L_H-1:0]),
			.empty_fifo_0 	(empty_fifo_0),
			.empty_fifo_1 	(empty_fifo_1),
			.empty_fifo_2 	(empty_fifo_2),
			.empty_fifo_3 	(empty_fifo_3),
			.empty_fifo_4 	(empty_fifo_4),
			.empty_fifo_5 	(empty_fifo_5),
			.empty_fifo_6 	(empty_fifo_6),
			.empty_fifo_7 	(empty_fifo_7)
			);
  probador_fsm#(.UMBRALES_L_H(8)) 
    probador_fsm_bp(/*AUTOINST*/
		      // Outputs
            .reset			(reset),
            .clk			(clk),
            .init			(init),
            .umbral_LH		(umbral_LH[UMBRALES_L_H-1:0]),
            .empty_fifo_0 	(empty_fifo_0),
            .empty_fifo_1 	(empty_fifo_1),
            .empty_fifo_2 	(empty_fifo_2),
            .empty_fifo_3 	(empty_fifo_3),
            .empty_fifo_4 	(empty_fifo_4),
            .empty_fifo_5 	(empty_fifo_5),
            .empty_fifo_6 	(empty_fifo_6),
            .empty_fifo_7 	(empty_fifo_7),
			// Inputs
			.state	(state[2:0]),
			.nxt_state	(nxt_state[2:0]),
			.umbral_LH_out		(umbral_LH_out[UMBRALES_L_H-1:0]),
		   	.next_umbral_LH_out	(next_umbral_LH_out[UMBRALES_L_H-1:0]),
			//synth
			.state_synth(state_synth[2:0]),
			.nxt_state_synth	(nxt_state_synth[2:0]),

			.umbral_LH_out_synth		(umbral_LH_out_synth[UMBRALES_L_H-1:0]),
			.next_umbral_LH_out_synth	(next_umbral_LH_out_synth[UMBRALES_L_H-1:0]));

endmodule