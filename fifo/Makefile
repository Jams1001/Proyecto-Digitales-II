all: t1 t2 t3 t4 t5 t6

t1:
	yosys -p "read_verilog fifo.v" -p "hierarchy -check -top fifo" -p " proc; opt; fsm; opt; memory; opt" -p "techmap; opt" -p "dfflibmap -liberty cmos_cells.lib" -p "abc -liberty cmos_cells.lib" -p "clean" -p "write_verilog fifo_synth.v"
t2:
	sed -i "s/fifo/fifo_synth/g" fifo_synth.v
t3:
	sed -i "s/data_out/data_out_synth/g" fifo_synth.v
t4:
	iverilog -o Bin BancoPruebas_fifo.v cmos_cells.v
t5:
	vvp Bin
t6:
	gtkwave fifo.vcd
clean:
	rm -r *.vcd *.o *.out Bin 