module tester1 (
    output reg clk, reset,
    output reg [11:0] fifo_out,
    output reg [3:0] almost_full, empty,
    input wire [3:0] push, pop, push_estr, pop_estr
);

always #1 clk <= ~clk;


initial begin 
    empty = 4'b0100;
    reset = 1;
    almost_full = 0;
    fifo_out = 0;
    clk = 0;
end

initial begin
    $dumpfile("arbitro1.vcd");
    $dumpvars;
    repeat(2) @(posedge clk);
    reset = 0;
    fifo_out <= 12'b001010010110;
    repeat(4) @(posedge clk);       // 4 palabras a Fifo P0
    fifo_out <= 12'b101011110000;
    repeat (4) @(posedge clk);      // 2 palabras a Fifo P1
    empty <= 4'b0000;               // Fifo P1 se pone empty y se pasa a siguiente 
    fifo_out <= 12'b11101010000;
    @(posedge clk);
    fifo_out <= 12'b110000011110;
    @(posedge clk);
    fifo_out <= 12'b111100101001;
    @(posedge clk);
    fifo_out <= 12'b111100101001;
    @(posedge clk);
    fifo_out <= 12'b111100101001;
    @(posedge clk);
    almost_full[2] <= 1;
    fifo_out <= 12'b111100101001;
    repeat(5) @(posedge clk);
    $finish;
end
    
endmodule