`include "fifo.v"
`include "probador.v"
`include "fifo_synth.v"

module BancoPruebas_fifo();

	parameter tamano_direcion = 3;
	parameter tamano_datos = 10;
	wire [tamano_datos-1:0] data_in;
	wire [tamano_datos-1:0] data_out, data_out_synth;
    wire full, empty, almost_full,  almost_empty, error;

    fifo #(.tamano_datos(10),.tamano_direcion(3))
        fifo_bp (/*AUTOINST*/
	       // Outputs
		   .almost_empty	(almost_empty),
		   .almost_full	(almost_full),
	       .full		(full),
	       .empty		(empty),
	       .error			(error),
	       .data_out		(data_out[tamano_datos-1:0]),
	       // Inputs
	       .clk			(clk),
	       .reset			(reset),
	       .write_enable		(write_enable),    
	       .read_enable		(read_enable),  
	       .data_in			(data_in[tamano_datos-1:0]));

    fifo_synth fifo_synthbp (/*AUTOINST*/
	       // Outputs
		   .almost_empty	    (almost_empty_synth),
		   .almost_full	         (almost_full_synth),
	       .full			    (full_synth),
	       .empty		        (empty_synth),
	       .error				(error),
	       .data_out_synth		(data_out_synth[tamano_datos-1:0]),
	       // Inputs
	       .clk			(clk),
	       .reset			(reset),
	       .write_enable		(write_enable),
	       .read_enable		(read_enable),
	       .data_in			(data_in[tamano_datos-1:0]));

    probador#(.tamano_datos(10),.tamano_direcion(3))
        probadorbp (/*AUTOINST*/
			// Outputs
			.clk			(clk),
			.write_enable		(write_enable),
			.read_enable		(read_enable),
			.reset			(reset),
			.data_in		(data_in[tamano_datos-1:0]),
			// Inputs
			.full			(full),
			.empty			(empty),
			.error			(error),
			.data_out		(data_out[tamano_datos-1:0]),
			.data_out_synth	(data_out_synth[tamano_datos-1:0]));
endmodule
