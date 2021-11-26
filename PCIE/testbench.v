`timescale 1ns/1ns
`include "PCIE.v"
`include "PCIE_estr.v"
`include "probador.v"
`include "cmos_cells.v"

module testbench();

parameter TAMANO_DATOS = 12;
parameter UMBRALES_L_H = 8;

wire [TAMANO_DATOS-1:0] data_out4, data_out5, data_out6, data_out7;
wire [TAMANO_DATOS-1:0] data_out4_estr, data_out5_estr, data_out6_estr, data_out7_estr;
wire clk, reset, push_probador, req, init;
wire [3:0] pop_probador;
wire [2:0] idx;
wire [11:0] data_in;
wire [UMBRALES_L_H-1:0] umbral_L;
wire [UMBRALES_L_H-1:0] umbral_H;


PCIE transaction(/*AUTOINST*/
		 // Outputs
		 .data_out4		(data_out4[TAMANO_DATOS-1:0]),
		 .data_out5		(data_out5[TAMANO_DATOS-1:0]),
		 .data_out6		(data_out6[TAMANO_DATOS-1:0]),
		 .data_out7		(data_out7[TAMANO_DATOS-1:0]),
		 // Inputs
		 .init              (init),
		 .push_probador		(push_probador),
		 .pop_probador		(pop_probador[3:0]),
		 .data_in		(data_in[11:0]),
		 .reset			(reset),
		 .clk			(clk),
		 .req			(req),
		 .idx			(idx[2:0]),
		 .umbral_L		(umbral_L[UMBRALES_L_H-1:0]),
		 .umbral_H	(umbral_H[UMBRALES_L_H-1:0]));

PCIE_estr transaction_estr(/*AUTOINST*/
		 // Outputs
		 .data_out4_estr		(data_out4_estr[TAMANO_DATOS-1:0]),
		 .data_out5_estr		(data_out5_estr[TAMANO_DATOS-1:0]),
		 .data_out6_estr		(data_out6_estr[TAMANO_DATOS-1:0]),
		 .data_out7_estr		(data_out7_estr[TAMANO_DATOS-1:0]),
		 // Inputs
		 .init               (init),
		 .push_probador		(push_probador),
		 .pop_probador		(pop_probador[3:0]),
		 .data_in		(data_in[11:0]),
		 .reset			(reset),
		 .clk			(clk),
		 .req			(req),
		 .idx			(idx[2:0]),
		 .umbral_L		(umbral_L[UMBRALES_L_H-1:0]),
		 .umbral_H	    (umbral_H[UMBRALES_L_H-1:0]));

probador probador_INST(/*AUTOINST*/
		       // Outputs
		       .push_probador	(push_probador),
		       .pop_probador	(pop_probador[3:0]),
		       .data_in		(data_in[11:0]),
		       .reset		(reset),
		       .clk		(clk),
		       .req		(req),
		       .idx		(idx[2:0]),
			   .init    (init),
		       // Inputs
		       .umbral_L	(umbral_L[UMBRALES_L_H-1:0]),
			   .umbral_H	(umbral_H[UMBRALES_L_H-1:0]),
		       .data_out4	(data_out4[TAMANO_DATOS-1:0]),
		       .data_out5	(data_out5[TAMANO_DATOS-1:0]),
		       .data_out6	(data_out6[TAMANO_DATOS-1:0]),
		       .data_out7	(data_out7[TAMANO_DATOS-1:0]));



endmodule
