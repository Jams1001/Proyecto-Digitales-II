module probador2
#(parameter UMBRALES_L_H = 8,
parameter TAMANO_DATOS = 12)
(
    output reg init,
	output reg push_probador,
	output reg [3:0] pop_probador,
	output reg [11:0] data_in,
	output reg reset,
	output reg clk,
    output reg req,
    output reg [2:0] idx,
	output reg [UMBRALES_L_H-1:0] umbral_L,
    output reg [UMBRALES_L_H-1:0] umbral_H,
	input [TAMANO_DATOS-1:0] data_out4,
	input [TAMANO_DATOS-1:0] data_out5,
	input [TAMANO_DATOS-1:0] data_out6,
	input [TAMANO_DATOS-1:0] data_out7
); 

always #1 clk <= ~clk;

initial begin 
    push_probador = 0; 
    pop_probador = 0;
    data_in = 0;
    init <= 0;
    reset = 1;
    clk = 0;
    req = 0;
    idx =0;


end


initial begin
	$dumpfile("resultados.vcd");
	$dumpvars;
    @(posedge clk);
    reset <= 0;
    init <= 1;
    req <= 1;
    @(posedge clk);
    umbral_H <= 6;
    umbral_L <= 0;
    @(posedge clk);
    umbral_H <= 5;                  //Necesarios 5 push para almost full
    umbral_L <= 1;                  //Necesarios 1 pops para almost empty
    @(posedge clk);
    init <= 0;  
    data_in <= 12'b000011111111;    //A partir de aquí sí son necesarios 2 posedge clks
    @(posedge clk);
    @(posedge clk); 
    push_probador = 1;
    data_in <= 12'b000011111110;
    @(posedge clk);
    @(posedge clk);  
    //pop_probador <= 4'b0000;
    @(posedge clk);
    @(posedge clk);  
    data_in <= 12'b000011111101;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk); 
    data_in <= 12'b000011111011; 
   // pop_probador <= 4'b0001;
    @(posedge clk);
    @(posedge clk);  
    data_in <= 12'b000111110111;    // dest a fifo5
    pop_probador <= 4'b0001;         
    @(posedge clk);
    @(posedge clk);  
    pop_probador <= 0;
    data_in <= 12'b010111101111;  
    @(posedge clk);
    @(posedge clk); 


    #100 $finish; 
end

endmodule