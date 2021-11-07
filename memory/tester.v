module tester#(    
   parameter MEM_WIDTH = 10,       
   parameter MEM_LENGHT = 8)(
   output reg [9:0] Fifo_Data_in,
   output reg [3:0] read_addr, write_addr,       // two addresses (read_ptr y write_ptr)
   output reg write_enable, read_enable, clk,                  
   input wire [9:0] Fifo_Data_out, Fifo_Data_outS);


    initial begin 

        Fifo_Data_in = 0; 
        read_addr = 0;
        write_addr = 0;
        write_enable = 0;
        read_enable = 0;
        clk = 0;
    end
    
    always #1 clk <= ~clk;
    
	initial begin
	$dumpfile("resultados.vcd");
	$dumpvars;

	/* Plan de pruebas
    Por cada posedge, se llena una fila de memoria (push) hasta tres filas de memoria ([0, 1, 2])
    con wr_adrr en [3]. 
    Luego se hace pop al primer elemento en agregarse ([0]). read_adrr en [1].         
    */

    @(posedge clk);
    @(posedge clk);	
    @(posedge clk);
    write_enable <= 1;
    write_addr <= write_addr + 1;
	Fifo_Data_in <= 10'b0010010001;
	
	@(posedge clk);
    write_addr <= write_addr + 1;
	Fifo_Data_in <= 10'b0001001010;

	@(posedge clk);
    write_addr <= write_addr + 1;
	Fifo_Data_in <= 10'b0010010011;

	@(posedge clk);
    write_enable <= 0;                      
	Fifo_Data_in <= 10'b0001000110;

	@(posedge clk);
    read_enable <= 1;
    read_addr <= read_addr + 1;
	Fifo_Data_in <= 10'b0010110101;

	@(posedge clk);
    read_enable <= 1;
    read_addr <= read_addr + 1;
	Fifo_Data_in <= 10'b0101100100;

	@(posedge clk);
	Fifo_Data_in <= 10'b0111100101;

	@(posedge clk);
	Fifo_Data_in <= 10'b1001100110;


	#7 $finish;
    
	end

endmodule 