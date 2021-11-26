module probador
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
    umbral_H <= 6;
    umbral_L <= 1;
end


initial begin
	$dumpfile("resultados.vcd");
	$dumpvars;

    #100;
    $finish; 
end

endmodule