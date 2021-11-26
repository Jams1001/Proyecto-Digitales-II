`include "fifo.v"
`include "probador.v"
`include "fifo_synth.v"

module BancoPruebas_fifo();

	parameter TAMANO_DIRECCION = 8;
	parameter TAMANO_DATOS = 10;
	wire [TAMANO_DATOS-1:0] data_in;
	wire [TAMANO_DATOS-1:0] data_out, data_out_synth;
	wire [2:0] wr_ptr, rd_ptr;
    wire full, empty, almost_full,  almost_empty, error;
	wire [7:0] umbral_bajo, umbral_alto;

    fifo #(.TAMANO_DATOS(10),.TAMANO_DIRECCION(8))
        fifo_bp (/*AUTOINST*/
	       // Outputs
		   .almost_empty	(almost_empty),
		   .almost_full	(almost_full),
	       .full		(full),
	       .empty		(empty),
	       .error			(error),
	       .data_out		(data_out[TAMANO_DATOS-1:0]),
		   .wr_ptr			(wr_ptr),
		   .rd_ptr			(rd_ptr),
	       // Inputs
	       .clk			(clk),
	       .reset			(reset),
	       .write_enable		(write_enable),    
	       .read_enable		(read_enable),
		   .umbral_bajo		(umbral_bajo),
		   .umbral_alto	    (umbral_alto),
	       .data_in			(data_in[TAMANO_DATOS-1:0]));

    fifo_synth fifo_synthbp (/*AUTOINST*/
	       // Outputs
		   .almost_empty	    (almost_empty_synth),
		   .almost_full	         (almost_full_synth),
	       .full			    (full_synth),
	       .empty		        (empty_synth),
	       .error				(error),
	       .data_out_synth		(data_out_synth[TAMANO_DATOS-1:0]),
		   .wr_ptr				(wr_ptr),
		   .rd_ptr				(rd_ptr),
	       // Inputs
	       .clk			(clk),
	       .reset			(reset),
	       .write_enable		(write_enable),
	       .read_enable		(read_enable),
		   .umbral_bajo		(umbral_bajo),
		   .umbral_alto	    (umbral_alto),
	       .data_in			(data_in[TAMANO_DATOS-1:0]));

    probador#(.TAMANO_DATOS(10),.TAMANO_DIRECCION(8))
        probadorbp (/*AUTOINST*/
			// Outputs
			.clk			(clk),
			.write_enable		(write_enable),
			.read_enable		(read_enable),
			.reset			(reset),
			.data_in		(data_in[TAMANO_DATOS-1:0]),
			.umbral_bajo		(umbral_bajo),
		    .umbral_alto	    (umbral_alto),
			
			// Inputs
			.full			(full),
			.empty			(empty),
			.error			(error),
			.data_out		(data_out[TAMANO_DATOS-1:0]),
			.data_out_synth	(data_out_synth[TAMANO_DATOS-1:0]),
			.wr_ptr			(wr_ptr),
			.rd_ptr			(rd_ptr));
endmodule
