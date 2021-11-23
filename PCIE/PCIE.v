`include "contadores.v"
`include "fifo.v"
`include "arbitro1.v"
`include "arbitro2.v"
module PCIE; 

    parameter TAMANO_DIRECCION = 8;
	parameter TAMANO_DATOS = 12;

    wire clk, reset;

    // Fifo in
	wire empty_in;
    wire full_in; 
    wire almost_full_in; 
    wire almost_empty_in; 
    wire error_in; 
    wire [2:0] wr_ptr_in; 
    wire [2:0] rd_ptr_in; 
    wire [TAMANO_DATOS-1:0] data_in;
    wire [TAMANO_DATOS-1:0] data_out_in;
    wire write_enable_in;
    wire read_enable_in;
    
    //  Almost_full fifos y Árbitro 2
    wire [3:0] almost_full_arbitro2;
    wire [3:0] write_enable_arbitro2;

    // Fifo 0
    wire empty_0;
    wire full_0; 
    wire almost_empty_0; 
    wire error_0; 
    wire [2:0] wr_ptr_0; 
    wire [2:0] rd_ptr_0; 
    wire [TAMANO_DATOS-1:0] data_out_0;
    wire read_enable_0;

    // Fifo 1
    wire empty_1;
    wire full_1; 
    wire almost_empty_1; 
    wire error_1; 
    wire [2:0] wr_ptr_1; 
    wire [2:0] rd_ptr_1; 
    wire [TAMANO_DATOS-1:0] data_out_1;
    wire read_enable_1;

    // Fifo 2
    wire empty_2;
    wire full_2; 
    wire almost_empty_2; 
    wire error_2; 
    wire [2:0] wr_ptr_2; 
    wire [2:0] rd_ptr_2; 
    wire [TAMANO_DATOS-1:0] data_out_2;
    wire read_enable_2;
    
    // Fifo 3
    wire empty_3;
    wire full_3; 
    wire almost_empty_3; 
    wire error_3; 
    wire [2:0] wr_ptr_3; 
    wire [2:0] rd_ptr_3; 
    wire [TAMANO_DATOS-1:0] data_out_3;
    wire read_enable_3;
        
fifo fifoin(/*AUTOINST*/
	    // Outputs
	    .full			(full_in),
	    .empty			(empty_in),
	    .almost_full		(almost_full_in),
	    .almost_empty		(almost_empty_in),
	    .error			(error_in),
	    .wr_ptr			(wr_ptr_in[2:0]),
	    .rd_ptr			(rd_ptr_in[2:0]),
	    .data_out			(data_out_in[TAMANO_DATOS-1:0]),
	    // Inputs
	    .clk			(clk),
	    .reset			(reset),
	    .write_enable		(write_enable_in),
	    .read_enable		(read_enable_in),
	    .data_in			(data_in[11:0]);

fifo fifo0(/*AUTOINST*/
	   // Outputs
	   .full			(full_0),
	   .empty			(empty_0),
	   .almost_full			(almost_full_arbitro2[0]),
	   .almost_empty		(almost_empty_0),
	   .error			(error_0),
	   .wr_ptr			(wr_ptr_0[2:0]),
	   .rd_ptr			(rd_ptr_0[2:0]),
	   .data_out			(data_out_0[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(write_enable_arbitro2[0]),
	   .read_enable			(read_enable_0),
	   .data_in			(data_out_in);
       
fifo fifo1(/*AUTOINST*/
	   // Outputs
	   .full			(full_1),
	   .empty			(empty_1),
	   .almost_full			(almost_full_arbitro2[1]),
	   .almost_empty		(almost_empty_1),
	   .error			(error_1),
	   .wr_ptr			(wr_ptr_1[2:0]),
	   .rd_ptr			(rd_ptr_1[2:0]),
	   .data_out			(data_out_1[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(write_enable_arbitro2[1]),
	   .read_enable			(read_enable_1),
	   .data_in			(data_out_in);

fifo fifo2(/*AUTOINST*/
	   // Outputs
	   .full			(full_2),
	   .empty			(empty)_2,
	   .almost_full			(almost_full_arbitro2[2]),
	   .almost_empty		(almost_empty_2),
	   .error			(error_2),
	   .wr_ptr			(wr_ptr_2[2:0]),
	   .rd_ptr			(rd_ptr_2[2:0]),
	   .data_out			(data_out_2[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(write_enable_arbitro2[2]),
	   .read_enable			(read_enable_2),
	   .data_in			(data_out_in);

fifo fifo3(/*AUTOINST*/
	   // Outputs
	   .full			(full_1),
	   .empty			(empty_1),
	   .almost_full			(almost_full_arbitro2[3]),
	   .almost_empty		(almost_empty_1),
	   .error			(error_1),
	   .wr_ptr			(wr_ptr_1[2:0]),
	   .rd_ptr			(rd_ptr_1[2:0]),
	   .data_out			(data_out_1[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(write_enable_arbitro2[3]),
	   .read_enable			(read_enable_1),
	   .data_in			(data_out_in);


arbitro2 arbitro_2(/*AUTOINST*/
		   // Inputs
		   .clk			(clk),
		   .empty		(empty_in),
		   .reset		(reset),
           .class       (data_in[11:10]),
           .almost_full (almost_full_arbitro2[0]),
           // Outputs
           .pop         (read_enable_in),
           .push        (write_enable_arbitro2));


fifo fifoin2(/*AUTOINST*/
	     // Outputs
	     .full			(full),
	     .empty			(empty),
	     .almost_full		(almost_full),
	     .almost_empty		(almost_empty),
	     .error			(error),
	     .wr_ptr			(wr_ptr[2:0]),
	     .rd_ptr			(rd_ptr[2:0]),
	     .data_out			(data_out[TAMANO_DATOS-1:0]),
	     // Inputs
	     .clk			(clk),
	     .reset			(reset),
	     .write_enable		(write_enable),
	     .read_enable		(read_enable),
	     .data_in			(data_in[TAMANO_DATOS-1:0]));



fifo fifo4(/*AUTOINST*/
	   // Outputs
	   .full			(full),
	   .empty			(empty),
	   .almost_full			(almost_full),
	   .almost_empty		(almost_empty),
	   .error			(error),
	   .wr_ptr			(wr_ptr[2:0]),
	   .rd_ptr			(rd_ptr[2:0]),
	   .data_out			(data_out[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(write_enable),
	   .read_enable			(read_enable),
	   .data_in			(data_in[TAMANO_DATOS-1:0]));
fifo fifo5(/*AUTOINST*/
	   // Outputs
	   .full			(full),
	   .empty			(empty),
	   .almost_full			(almost_full),
	   .almost_empty		(almost_empty),
	   .error			(error),
	   .wr_ptr			(wr_ptr[2:0]),
	   .rd_ptr			(rd_ptr[2:0]),
	   .data_out			(data_out[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(write_enable),
	   .read_enable			(read_enable),
	   .data_in			(data_in[TAMANO_DATOS-1:0]));
fifo fifo6(/*AUTOINST*/
	   // Outputs
	   .full			(full),
	   .empty			(empty),
	   .almost_full			(almost_full),
	   .almost_empty		(almost_empty),
	   .error			(error),
	   .wr_ptr			(wr_ptr[2:0]),
	   .rd_ptr			(rd_ptr[2:0]),
	   .data_out			(data_out[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(write_enable),
	   .read_enable			(read_enable),
	   .data_in			(data_in[TAMANO_DATOS-1:0]));
fifo fifo7(/*AUTOINST*/
	   // Outputs
	   .full			(full),
	   .empty			(empty),
	   .almost_full			(almost_full),
	   .almost_empty		(almost_empty),
	   .error			(error),
	   .wr_ptr			(wr_ptr[2:0]),
	   .rd_ptr			(rd_ptr[2:0]),
	   .data_out			(data_out[TAMANO_DATOS-1:0]),
	   // Inputs
	   .clk				(clk),
	   .reset			(reset),
	   .write_enable		(write_enable),
	   .read_enable			(read_enable),
	   .data_in			(data_in[TAMANO_DATOS-1:0]));


arbitro1 arbitro_1(/*AUTOINST*/
		   // Outputs
		   .push		(push[3:0]),
		   .pop			(pop[3:0]),
		   // Inputs
		   .clk			(clk),
		   .reset		(reset),
		   .dest		(dest[1:0]),
		   .almost_full		(almost_full[3:0]),
		   .empty		(empty[3:0]));



contadores contador1(/*AUTOINST*/
		     // Outputs
		     .data		(data[4:0]),
		     .valid		(valid),
		     // Inputs
		     .CLK		(CLK),
		     .pop4		(pop4),
		     .pop0		(pop0),
		     .pop1		(pop1),
		     .pop2		(pop2),
		     .pop3		(pop3),
		     .req		(req),
		     .IDLE		(IDLE),
		     .idx		(idx[2:0]),
		     .reset		(reset));



endmodule
