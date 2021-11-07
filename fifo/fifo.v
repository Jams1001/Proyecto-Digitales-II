`include "memory.v"
module fifo
#(parameter tamano_datos = 10,parameter tamano_direcion = 8)
(
    input clk, reset, write_enable, read_enable,
    input [tamano_datos-1:0] data_in,
    output full, empty, almost_full, almost_empty, error,
    output reg [2:0] wr_ptr, rd_ptr,
    output [tamano_datos-1:0] data_out
);
parameter MEM_WIDTH = 10;
parameter MEM_LENGHT = 8;

reg [tamano_datos-1:0] mem [0:tamano_direcion-1];
//reg [tamano_direcion-1:0] wr_ptr;
//reg [tamano_direcion-1:0] rd_ptr;
reg [tamano_direcion:0] contador; 

assign full = (contador == tamano_direcion);
assign empty = (contador == 0);  
assign error = (contador > tamano_direcion);
assign almost_empty = (contador == 1);
assign almost_full = (contador == tamano_direcion-1);


memory #(.MEM_WIDTH(10),.MEM_LENGHT(8))
        memory_fifo (/*AUTOINST*/
	        //Outputs
            .Fifo_Data_out	(data_out[tamano_datos-1:0]),
	        //Inputs
	        .clk			(clk),
           .read_addr       (rd_ptr),
           .write_addr      (wr_ptr),
           .write_enable    (write_enable),   
	       .read_enable		(read_enable),  
	       .Fifo_Data_in	(data_in[tamano_datos-1:0]));


//reset para sincronizar

always @(posedge clk) 
begin
    if (reset == 0) 
    begin
       wr_ptr <= 0;
       rd_ptr <= 0;
       contador <= 0;
    end
    //reset desactivado
    else
    begin
        //write
        if (write_enable == 1) 
        begin
            wr_ptr <= wr_ptr+1;
        end
        //read
        if (read_enable == 1) 
        begin
            //data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr+1;
        end
        //counter
        case ({write_enable, read_enable})
            0: contador <= contador;
            1: contador <= contador-1;
            2: contador <= contador+1;
            3: contador <= contador;
            default: contador <= contador;
        endcase
    end
end
endmodule 