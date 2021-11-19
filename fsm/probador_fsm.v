module probador_fsm
#(parameter UMBRALES_L_H = 8)
(
    input [2:0] state,
    input [2:0] nxt_state,
    input [UMBRALES_L_H-1:0] umbral_LH_out,
    input [UMBRALES_L_H-1:0] next_umbral_LH_out,
    input [2:0] state_synth,
    input [2:0] nxt_state_synth,
    input [UMBRALES_L_H-1:0] umbral_LH_out_synth,
    input [UMBRALES_L_H-1:0] next_umbral_LH_out_synth,
    output reg reset,
    output reg clk,
    output reg init,
    output reg [UMBRALES_L_H-1:0] umbral_LH,
    output reg empty_fifo_0,
    output reg empty_fifo_1,
    output reg empty_fifo_2,
    output reg empty_fifo_3,
    output reg empty_fifo_4,
    output reg empty_fifo_5,
    output reg empty_fifo_6,
    output reg empty_fifo_7
);
  initial begin

    $dumpfile("fsm.vcd");
    $dumpvars();
    reset <= 0;
    init<=0;
    umbral_LH<=8'b00000000;
    empty_fifo_0 <= 1;
    empty_fifo_1 <= 1;
    empty_fifo_2 <= 1;
    empty_fifo_3 <= 1;
    empty_fifo_4 <= 1;
    empty_fifo_5 <= 1;
    empty_fifo_6 <= 1;
    empty_fifo_7 <= 1;
    @(posedge clk);
    reset <= 0;
    @(posedge clk);
    reset <= 1;
    @(posedge clk);
    umbral_LH<=8'b00001110;
    @(posedge clk);
    init<=1;
    umbral_LH<=8'b00000001;
    @(posedge clk);
    init<=1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    empty_fifo_0 <= 0;
    empty_fifo_1 <= 1;
    empty_fifo_2 <= 1;
    empty_fifo_3 <= 0;
    empty_fifo_4 <= 1;
    empty_fifo_5 <= 0;
    empty_fifo_6 <= 1;
    empty_fifo_7 <= 0;
    @(posedge clk);
    @(posedge clk);
    umbral_LH<=8'b00001111;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    umbral_LH<=8'b00001010;
    @(posedge clk);
    @(posedge clk);
    reset <= 0;
    @(posedge clk);
    @(posedge clk);
    $finish;
  end
  initial clk <= 0;
  always #1 clk <= ~clk;
endmodule