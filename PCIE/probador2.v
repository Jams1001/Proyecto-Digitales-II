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
    // para cuando este datain llegue a fifoin2 (que manda dest), ya f4 almost_full
    data_in <= 12'b000111111011;  
    reset <= 0;
    init <= 1;
    req <= 1;
    push_probador = 1;
    umbral_H <= 6;
    umbral_L <= 0;
    //@(posedge clk);
    @(posedge clk);
    data_in <= 12'b000111111110; 
    umbral_H <= 5;                  //Necesarios 5 push para almost full
    umbral_L <= 1;                  //Necesarios 1 pops para almost empty
    @(posedge clk);
    init <= 0;  
    @(posedge clk);
    @(posedge clk); 
    data_in <= 12'b000111111110;  
    @(posedge clk);
    // Para cuando siguiente datain llegue a ser dest, f5 almost_full
    data_in <= 12'b001011110110;    
    @(posedge clk);  
    @(posedge clk);
    data_in <= 12'b001011111101;
    @(posedge clk);  
    @(posedge clk);
    data_in <= 12'b001110111011; 
    @(posedge clk);
    @(posedge clk);
    @(posedge clk); 
   // pop_probador <= 4'b0001;
    @(posedge clk);
    @(posedge clk);  
    data_in <= 12'b001111010111;             
    @(posedge clk);
    pop_probador <= 4'b0001;
    @(posedge clk);  
    pop_probador <= 0;
    data_in <= 12'b00111101101;  
    @(posedge clk);
    repeat(5) @(posedge clk); 
    pop_probador <= 4'b0010;  // pop a fifo5 almost_full
    @(posedge clk);
    pop_probador <= 0;
    repeat(5) @(posedge clk);
    pop_probador <= 4'b0100; // pop a fifo6 almost_full 
    @(posedge clk);
    pop_probador <= 0;
    repeat(5) @(posedge clk);
// HASTA AQUÍ LLEGA EL PUNTO 3 DE LA PRUEBA 
// (FIFO 7 QUEDA ALMOST FULL PARA LUEGO LLENAR LOS AMARILLOS)
    #3 $finish; 
end

endmodule