`timescale 1ns/1ns

`include "cmos_cells.v"
`include "memory.v"
`include "memoryS.v"  
`include "tester.v" 

module testbench(); 

	parameter MEM_WIDTH = 10;     
	parameter MEM_LENGHT = 8;
	wire [9:0] fifo_Data_out, fifo_Data_outS, fifo_Data_in;
	wire write_enable, read_enable, clk;
	wire [3:0] read_addr, write_addr;  

memory memoryINST(/*AUTOINST*/
		  // Outputs
		  .fifo_Data_out	(fifo_Data_out[MEM_WIDTH-1:0]),
		  // Inputs
		  .fifo_Data_in		(fifo_Data_in[MEM_WIDTH-1:0]),
		  .read_addr		(read_addr[3:0]),
		  .write_addr		(write_addr[3:0]),
		  .write_enable		(write_enable),
		  .read_enable		(read_enable),
		  .clk			(clk));

memoryS memorySINST(/*AUTOINST*/
		    // Outputs
		    .fifo_Data_out	(fifo_Data_outS[9:0]),
		    // Inputs
		    .clk		(clk),
		    .fifo_Data_in	(fifo_Data_in[9:0]),
		    .read_addr		(read_addr[3:0]),
		    .read_enable	(read_enable),
		    .write_addr		(write_addr[3:0]),
		    .write_enable	(write_enable));


tester testerINST(/*AUTOINST*/
		  // Outputs
		  .fifo_Data_in		(fifo_Data_in[9:0]),
		  .read_addr		(read_addr[3:0]),
		  .write_addr		(write_addr[3:0]),
		  .write_enable		(write_enable),
		  .read_enable		(read_enable),
		  .clk			(clk),
		  // Inputs
		  .fifo_Data_out	(fifo_Data_out[9:0]),
		  .fifo_Data_outS	(fifo_Data_outS));

endmodule
