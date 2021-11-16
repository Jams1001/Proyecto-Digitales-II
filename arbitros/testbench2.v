`timescale 1ns/1ns
`include "arbitro2.v"
`include "arbitro2_estr.v"
`include "tester2.v"
`include "cmos_cells.v"

module testebench ();

wire clk, empty, reset, pop, pop_estr;  
wire [3:0] almost_full, push, push_estr;
wire [11:0] fifo_out;
    
arbitro2 arbiter2(/*AUTOINST*/
		   // Inputs
		  .clk			(clk),
		  .empty		(empty),
		  .reset		(reset),
          .class        (fifo_out[11:10]),
          .almost_full  (almost_full),
          // Outputs
          .pop          (pop),
          .push         (push)
          );

arbitro2_estr arbiter2_es(/*AUTOINST*/
			  // Outputs
			  .pop_estr		(pop_estr),
			  .push_estr		(push_estr[3:0]),
			  // Inputs
			  .almost_full		(almost_full[3:0]),
			  .\class 		(fifo_out[11:10]),
			  .clk			(clk),
			  .empty		(empty),
			  .reset		(reset));

tester2 probador(/*AUTOINST*/
		 // Outputs
		 .clk			(clk),
		 .empty			(empty),
		 .reset			(reset),
		 .almost_full		(almost_full[3:0]),
		 .fifo_out		(fifo_out[11:0]),
		 // Inputs
		 .pop			(pop),
		 .pop_estr		(pop_estr),
		 .push			(push[3:0]),
		 .push_estr		(push_estr));


endmodule
