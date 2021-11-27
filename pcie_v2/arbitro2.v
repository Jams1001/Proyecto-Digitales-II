module arbitro2 (
    input empty, reset,
    input [1:0] class,
    input [3:0] almost_full,
    output reg pop,
    output reg [3:0] push
);

//reg [1:0] selector;

always @(*)begin
    if (reset) begin
        pop <= 0; push <= 0;
    end
    
    else begin
        if (empty || |almost_full) begin 
            pop <= 0;
            push <= 0;
        end else begin
            pop <= 1;
            case (class)
                0: push <= 4'b0001;
                1: push <= 4'b0010; 
                2: push <= 4'b0100;
                3: push <= 4'b1000;
                default: push <= 4'b0000;
            endcase
        end
    end
    
end
endmodule