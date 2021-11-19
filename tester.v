module tester( 
    output reg CLK, 
    output reg pop4, pop0, pop1, pop2, pop3,                      
    output reg req,
    output reg IDLE,
    output reg reset,
    output reg [2:0] idx,
    input wire [4:0] data,
    input wire valid);

    initial begin
        CLK <= 0;
        pop4 <= 0; pop0 <= 0; pop1 <= 0; pop2 <= 0; pop3 <= 0;
        req <= 0;
        reset <= 0;
        IDLE <= 0;
    end
    
    always #1 CLK <= ~CLK;
    
	initial begin
	$dumpfile("contadores.vcd");
	$dumpvars;
    @(posedge CLK);
    reset <= 1;
    @(posedge CLK);
    pop4 <= 1; 
    @(posedge CLK);
    pop0 <= 1;	
    @(posedge CLK);
    pop1 <= 1;
    @(posedge CLK);
    pop2 <= 1;	
    @(posedge CLK);
    pop3 <= 1;	
    @(posedge CLK);
    req <= 1;
    IDLE <= 1;
    @(posedge CLK);	
    @(posedge CLK);
    idx <= 3'b000;
    @(posedge CLK);
    @(posedge CLK);
    idx <= 3'b001;
    @(posedge CLK);	
    @(posedge CLK);
    idx <= 3'b010;
    @(posedge CLK);	
    @(posedge CLK);
    idx <= 3'b011;
    @(posedge CLK);	
    @(posedge CLK);
    idx <= 3'b100;
    @(posedge CLK);	
    @(posedge CLK);
    pop4 <= 0; pop0 <= 0; pop1 <= 0; pop2 <= 0; pop3 <= 0;
    @(posedge CLK);	
    @(posedge CLK);
	#10 $finish;
    
	end

endmodule 