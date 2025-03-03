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
    // Destino a fifo4
    data_in <= 12'b000011111011;  
    reset <= 0;
    init <= 1;
    req <= 1;
    push_probador = 1;
    umbral_H <= 6;
    umbral_L <= 0;
    //@(posedge clk);
    @(posedge clk);
    data_in <= 12'b000011111110; 
    umbral_H <= 5;                  //Necesarios 5 push para almost full
    umbral_L <= 1;                  //Necesarios 1 pops para almost empty
    @(posedge clk);
    init <= 0;
    idx = 3'b100;  
    @(posedge clk);
    @(posedge clk); 
    data_in <= 12'b000011111110;  
    @(posedge clk);
    // f4 ya almost_full, dest a f5
    data_in <= 12'b000111110110;    
    @(posedge clk);  
    @(posedge clk);
    data_in <= 12'b000111111101;
    @(posedge clk);  
    @(posedge clk);
    @(posedge clk);
    data_in <= 12'b001010111011; 
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
    data_in <= 12'b001111011011;  
    @(posedge clk);
    repeat(5) @(posedge clk); 
    pop_probador <= 4'b0010;  // pop a fifo5 almost_full
    @(posedge clk);
    pop_probador <= 0;
    repeat(5) @(posedge clk);
    pop_probador <= 4'b0100; // pop a fifo6 almost_full 
    @(posedge clk);
    // HASTA AQUÍ LLEGA EL PUNTO 3 DE LA PRUEBA 
    // (FIFO 7 QUEDA ALMOST FULL PARA LUEGO LLENAR LOS AMARILLOS)
    data_in <= 12'b011111100001;
    @(posedge clk);
    pop_probador <= 0; 
    repeat(3) @(posedge clk);
    data_in <= 12'b101111100001; 
    repeat(4) @(posedge clk);
    data_in <= 12'b111111100001;
    push_probador <= 0;           // Parar de meter datos
    repeat(4) @(posedge clk);
    pop_probador <= 4'b1111;      // Comienzan a vaciarse fifos
    repeat(4) @(posedge clk);
    pop_probador <= 4'b1000;
    #50 $finish; 
end

endmodule