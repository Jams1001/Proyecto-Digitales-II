module probador_fsm
#(parameter UMBRALES_L_H = 8)
(
    input [2:0] state,
    input [2:0] nxt_state,
    input [UMBRALES_L_H-1:0] umbral_L_out,
    input [UMBRALES_L_H-1:0] next_umbral_L_out,
    input [UMBRALES_L_H-1:0] umbral_H_out,
    input [UMBRALES_L_H-1:0] next_umbral_H_out,
    input [2:0] state_synth,
    input [2:0] nxt_state_synth,
    input [UMBRALES_L_H-1:0] umbral_L_out_synth,
    input [UMBRALES_L_H-1:0] next_umbral_L_out_synth,
    input [UMBRALES_L_H-1:0] umbral_H_out_synth,
    input [UMBRALES_L_H-1:0] next_umbral_H_out_synth,
  //  input next_idle,
    input idle_out,
   // input next_idle_synth,
		input idle_out_synth,
    output reg reset,
    output reg clk,
    output reg init,
    output reg [UMBRALES_L_H-1:0] umbral_L,
    output reg [UMBRALES_L_H-1:0] umbral_H,
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
    reset <= 1;
    init<=0;
    umbral_L<=8'b00000000;
    umbral_H<=8'b00000000;
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
    reset <= 0;
    init <=1;
    @(posedge clk);
    umbral_L<=8'b00001110;
    umbral_H<=~umbral_L;
    @(posedge clk);
    init <=0;
    umbral_L<=8'b00000001;
    umbral_H<=~umbral_L;
    @(posedge clk);
 
    @(posedge clk);
    @(posedge clk);
    init <= 1;
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
    umbral_L<=8'b00001111;
    umbral_H<=~umbral_L;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    umbral_L<=8'b00001010;
    umbral_H<=~umbral_L;
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