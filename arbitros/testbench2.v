`timescale 1ns/1ns
`include "arbitro2.v"
`include "tester2.v"

module testebench ();

wire clk, empty, reset, pop;  
wire [3:0] almost_full, push;
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
tester2 probador(/*AUTOINST*/
		 // Outputs
		 .clk			(clk),
		 .empty			(empty),
		 .reset			(reset),
		 .almost_full		(almost_full[3:0]),
		 .fifo_out		(fifo_out[11:0]),
		 // Inputs
		 .pop			(pop),
		 .push			(push));


endmodule
