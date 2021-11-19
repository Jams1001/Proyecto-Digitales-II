`timescale 1ns/1ns
`include "arbitro1.v"
//`include "arbitro2_estr.v"
`include "tester1.v"
`include "cmos_cells.v"

module testbench1 ();

wire clk, reset;  
wire [3:0] almost_full, push, empty, pop;
wire [11:0] fifo_out;


arbitro1 arbiter1(/*AUTOINST*/
		  // Outputs
		  .push			(push[3:0]),
		  .pop			(pop[3:0]),
		  // Inputs
		  .clk			(clk),
		  .reset		(reset),
		  .dest			(fifo_out[9:8]),
		  .almost_full		(almost_full[3:0]),
		  .empty		(empty[3:0]));

tester1 probador(/*AUTOINST*/
		 // Outputs
		 .clk			(clk),
		 .reset			(reset),
		 .fifo_out		(fifo_out[11:0]),
		 .almost_full		(almost_full[3:0]),
		 .empty			(empty[3:0]),
		 // Inputs
		 .push			(push[3:0]),
		 .pop			(pop[3:0]));


    
endmodule
