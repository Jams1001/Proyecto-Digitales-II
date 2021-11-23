all: t1 t2 t3 t4 t5

t1:
	yosys -p "read_verilog fsm.v" -p "hierarchy -check -top fsm" -p " proc; opt; fsm; opt; memory; opt" -p "techmap; opt" -p "dfflibmap -liberty cmos_cells.lib" -p "abc -liberty cmos_cells.lib" -p "clean" -p "write_verilog fsm_synth.v"
t2:
	sed -i 's/fsm/fsm_synth/' fsm_synth.v
t3:
	iverilog -o Bin BancoPruebas_fsm.v cmos_cells.v
t4:
	vvp Bin
t5:
	gtkwave fsm.vcd
clean:
	rm -r *.vcd *.o *.out Bin 