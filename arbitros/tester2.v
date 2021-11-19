module tester2 (
    output reg clk, empty , reset,
    output reg [3:0] almost_full,
    output reg [11:0] fifo_out,
    input pop, pop_estr,
    input [3:0] push, push_estr
);

always #1 clk <= ~clk;

initial begin 
    empty = 0;
    reset = 1;
    almost_full = 0;
    fifo_out = 0;
    clk = 0;
end


initial begin
    $dumpfile("arbitro2.vcd");
    $dumpvars;
    repeat(2) @(posedge clk);
    reset = 0;
    fifo_out <= 12'b001010010110;
    @(posedge clk);
    fifo_out <= 12'b000110010110;
    @(posedge clk);
    fifo_out <= 12'b010000100101;
    @(posedge clk);
    fifo_out <= 12'b100000100100;
    @(posedge clk);
    fifo_out <= 12'b111010100101;
    @(posedge clk);
    almost_full[2] <= 1;
    fifo_out <= 12'b101010100101;
    repeat(5) @(posedge clk);
    $finish;
end
    
endmodule