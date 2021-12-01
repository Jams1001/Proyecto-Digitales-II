module probador6_7
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
end

initial begin
	$dumpfile("pruebas6_7.vcd");
	$dumpvars;
    @(posedge clk);
    reset <= 0;
    init <= 1;
    req <= 1;
    umbral_H <= 7;
    umbral_L <= 1;

    // Class a F0 y datos con destino a F4
    @(posedge clk)
    data_in <= 12'b000011111111;
    push_probador = 1;
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
    @(posedge clk)
    push_probador <= 0;

    // Comenzar pops
    @(posedge clk);
    pop_probador<= 4'b0011;
    repeat(4) @(posedge clk); // pop 4 palabras de f4 y f5
    pop_probador<= 0;
    repeat(4) @(posedge clk);
    pop_probador <= 4'b1100; // pop 4 palabras de f6 y f7
    repeat(4) @(posedge clk);
    pop_probador <= 0;

    #50 $finish; 
end

endmodule