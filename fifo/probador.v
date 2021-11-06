module probador
#(parameter tamano_datos = 10,parameter tamano_direcion = 3)
(
	output reg clk, write_enable, read_enable, reset,
	output reg [tamano_datos-1:0] data_in,
	input full, empty, error, almost_empty, almost_full,
	input [tamano_datos-1:0] data_out,
	input [tamano_datos-1:0] data_out_synth
);
	initial begin
	$dumpfile("fifo.vcd");
	$dumpvars;

	{write_enable, read_enable, reset} <= 0;
	data_in <= 0;

	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	
    @(posedge clk);
	reset <= ~reset;
    write_enable <= 1;
	data_in <= 10'b0010010001;
	
	@(posedge clk);
	data_in <= 10'b0001001010;

	@(posedge clk);
	data_in <= 10'b0010010011;

	@(posedge clk);
	data_in <= 10'b0001000110;

	@(posedge clk);
	data_in <= 10'b0010110101;

	@(posedge clk);
	data_in <= 10'b0101100100;

	@(posedge clk);
	data_in <= 10'b0111100101;

	@(posedge clk);
	data_in <= 10'b1001100110;

	@(posedge clk);
    write_enable <= ~write_enable;
    read_enable <= ~read_enable;

	@(posedge clk);
	

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);
	

	$finish;
	end
	initial clk <= 1;
	always #1 clk <= ~clk;
endmodule