module probador1_5
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
    idx = 3'b100;
    umbral_H <= 7;
    umbral_L <= 1;
end

initial begin
	$dumpfile("pruebas1_5.vcd");
	$dumpvars;
    @(posedge clk);
    reset <= 0;
    init <= 1;
    req <= 1;
    umbral_H <= 6;
    umbral_L <= 2;

    // Class a F0 y datos con destino a F4
    @(posedge clk)
    data_in <= 12'b000011111111;
    push_probador = 1;
    umbral_H <= 5;
    umbral_L <= 1;
    @(posedge clk)
    data_in <= 12'b000011111110;
    init <= 0;
    @(posedge clk)
    data_in <= 12'b000011111100;
    @(posedge clk)
    data_in <= 12'b000011111000;
    
    // Class a F1 y datos con destino a F5
    @(posedge clk)
    data_in <= 12'b010111111111;
    @(posedge clk)
    data_in <= 12'b010111111110;
    @(posedge clk)
    data_in <= 12'b010111111100;
    @(posedge clk)
    data_in <= 12'b010111111000;
    
    @(posedge clk)  // Class a F2 con destino a F6
    data_in <= 12'b101011111111;
    @(posedge clk)
    data_in <= 12'b101011111110;
    @(posedge clk)
    data_in <= 12'b101011111100;
    @(posedge clk)
    data_in <= 12'b101011111000;
    
    @(posedge clk)  // Class a F3 con destino a F7
    data_in <= 12'b111111111111;
    @(posedge clk)
    data_in <= 12'b111111111110;
    @(posedge clk)
    data_in <= 12'b111111111100;
    @(posedge clk)
    data_in <= 12'b111111111000;

    // Agregar un quinto dato (para almost full) a cada fifo de salida
    @(posedge clk)
    data_in <= 12'b000011111111;
    @(posedge clk)
    data_in <= 12'b000111111110;
    @(posedge clk)
    data_in <= 12'b001011111100;
    @(posedge clk)
    data_in <= 12'b001111111000;

    @(posedge clk)
    push_probador <= 0;  // detener envío de palabras

    // Provocar almost full en todos los fifos de salida:
    repeat(4) @(posedge clk);
    pop_probador <= 4'b0001;  // Fifo 4 almost_full, pop a dato(s) de este
    @(posedge clk);
    pop_probador <= 4'b0011;  // Fifo 5 almost full, pop a dato(s) de este
    @(posedge clk);
    pop_probador <= 4'b0111;  // Fifo 6 almost full, pop a dato(s) de este
    @(posedge clk);
    @(posedge clk);

    // Ahora Fifo 7 almost full y se mantiene almost full para llenar fifos de entrada
    // Llenar Fifo 0 con 4 palabras
    @(posedge clk);
    pop_probador <= 4'b0110;  // fifo 4 ya vacío
    data_in <= 12'b001111111111;
    push_probador <= 1; // rehabilitar envío de palabras
    @(posedge clk);
    data_in <= 12'b001111101110;
    pop_probador <= 4'b0100;  // Fifo 5 ya vacío
    @(posedge clk);
    data_in <= 12'b001111111100;
    pop_probador <= 0;  // Fifo 6 ya vacío
    @(posedge clk);
    data_in <= 12'b001111101111;
   
    // Llenar Fifo 1 con 4 palabras 
    @(posedge clk)
    data_in <= 12'b011111111111;
    @(posedge clk)
    data_in <= 12'b011111111110;
    @(posedge clk)
    data_in <= 12'b011111111100;
    @(posedge clk)
    data_in <= 12'b011111111000;

    @(posedge clk)  // Llenar Fifo 2 con 4 palabras 
    data_in <= 12'b101111111111;
    @(posedge clk)
    data_in <= 12'b101111111110;
    @(posedge clk)
    data_in <= 12'b101111111100;
    @(posedge clk)
    data_in <= 12'b101111111000;

    @(posedge clk)  // Llenar Fifo 3 con 4 palabras 
    data_in <= 12'b111111111111;
    @(posedge clk)
    data_in <= 12'b111111111110;
    @(posedge clk)
    data_in <= 12'b111111111100;
    @(posedge clk)
    data_in <= 12'b111111111000;

    @(posedge clk)  
    data_in <= 12'b001111111111;  // Palabra provocará almost full en Fifo 0
    // Vaciar Fifo 7 (todas las palabras para llenar entradas tienen destino a F7)
    pop_probador <= 4'b1000; 

    @(posedge clk);
    push_probador <= 0;  // finalizar envío de palabras
    repeat(4) @(posedge clk);
    pop_probador <= 0;
    @(posedge clk);
    pop_probador <= 4'b1000;
    repeat(17) @(posedge clk);
    pop_probador <= 0;
 
    #50 $finish; 
end

endmodule