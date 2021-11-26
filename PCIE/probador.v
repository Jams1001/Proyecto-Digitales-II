module probador
#(parameter UMBRALES_L_H = 8,
parameter TAMANO_DATOS = 12)
(
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
    @(posedge clk);
    push_probador <= 1;
    reset <= 0;
    @(posedge clk);
    data_in <= 12'b010010100100;
    req <= 1;
    repeat(2) @(posedge clk);
    data_in <= 12'b010000010101;
    repeat(2) @(posedge clk);
    data_in <= 12'b010010100101;
    repeat(2) @(posedge clk);
    data_in <= 12'b110010001101;
    repeat(2) @(posedge clk);
    pop_probador <= 4'b1111;
    @(posedge clk);
    data_in <= 12'b010010101011;
    pop_probador <= 4'b1111;
    repeat(4) @(posedge clk);
    data_in <= 12'b010000001111;
    idx <= 3'b000;
    @(posedge clk);
    idx <= 3'b001;
    data_in <= 12'b010011000111;
    @(posedge clk);
    idx <= 3'b010;
    data_in <= 12'b010011111111;
    @(posedge clk);
    idx <= 3'b011;
    data_in <= 12'b010000111100;
    @(posedge clk)
    idx <= 3'b100;

    repeat(8) @(posedge clk);
    $finish; 
end

endmodule