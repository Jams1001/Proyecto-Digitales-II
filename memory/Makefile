r: testbench.v tester.v memory.v
	iverilog -o salida testbench.v
	vvp salida
	gtkwave resultados.vcd
	rm -rf salida resultados.vcd

t:
	echo '`timescale 1ns/1ns\n\n`include "module.v" \n`include "tester.v" \n\nmodule testbench; \n\n\twire CLK; \n\nmodule moduleINST(/*AUTOINST*/   \n);\n\ntester testerINST(/*AUTOINST*/   \n);\n\nendmodule' > testbench.v		

a:	
	emacs --batch  testbench.v -f verilog-batch-auto
	
s: 
	echo '# read design\nread_verilog module.v\n#hierarchy -check -top counter\n# the high-level stuff\nproc; opt; fsm; opt; memory; opt\n# mapping to internal cell library\ntechmap; opt\n# mapping flip-flops to cmos_cells.lib\ndfflibmap -liberty cmos_cells.lib\n# mapping logic to cmos_cells.lib\nabc -liberty cmos_cells.lib\n# cleanup\nclean\n# show\nshow -lib cmos_cells.v\n# write synsthesized design\nwrite_verilog moduleS.v\n' > synthesis_module.ys
	

s1:	synthesis_memory.ys
	yosys -s synthesis_memory.ys
	sed -i 's/module memory/module memoryS/' memoryS.v