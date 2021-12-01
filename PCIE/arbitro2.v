module arbitro2 (
    input empty, reset, empty_in_delay, clk,
    input [1:0] class,
    input [3:0] almost_full,
    output reg pop,
    output reg [3:0] push
);

reg [3:0] almost_full_delay;

always @(*)begin
    if (reset) begin
        pop <= 0; push <= 0;
    end
    
    else begin
        if (empty || |almost_full) begin 
            pop <= 0;
        end else pop <= 1;

        // push  usa entradas delayed  ya que se pone en bajo luego del último pop 
        if (empty_in_delay || |almost_full_delay) push <= 0;
        else begin
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

always @(posedge clk) begin  // generar almost full retardado
    if (reset) almost_full_delay <= 0;
    else almost_full_delay <= almost_full;
end
endmodule