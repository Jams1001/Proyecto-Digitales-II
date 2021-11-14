`timescale 1ns/1ns

`include "contadores.v"
`include "contadoresS.v"
`include "cmos_cells.v"
`include "tester.v" 

module testbench; 

	wire CLK, pop4, pop0, pop1, pop2, pop3, req, reset, valid, validS; 
	wire [2:0] idx;
	wire [4:0] data, dataS;

contadores contadoresINST(/*AUTOINST*/
			  // Outputs
			  .data			(data[4:0]),
			  .valid		(valid),
			  // Inputs
			  .CLK			(CLK),
			  .pop4			(pop4),
			  .pop0			(pop0),
			  .pop1			(pop1),
			  .pop2			(pop2),
			  .pop3			(pop3),
			  .req			(req),
			  .idx			(idx[2:0]),
			  .reset		(reset));
contadoresS contadoresSINST(/*AUTOINST*/
			    // Outputs
			    .data		(dataS[4:0]),
			    .valid		(validS),
			    // Inputs
			    .CLK		(CLK),
			    .idx		(idx[2:0]),
			    .pop0		(pop0),
			    .pop1		(pop1),
			    .pop2		(pop2),
			    .pop3		(pop3),
			    .pop4		(pop4),
			    .req		(req),
			    .reset		(reset));

tester testerINST(/*AUTOINST*/
		  // Outputs
		  .CLK			(CLK),
		  .pop4			(pop4),
		  .pop0			(pop0),
		  .pop1			(pop1),
		  .pop2			(pop2),
		  .pop3			(pop3),
		  .req			(req),
		  .reset		(reset),
		  .idx			(idx[2:0]),
		  // Inputs
		  .data			(data[4:0]),
		  .valid		(valid));

endmodule
