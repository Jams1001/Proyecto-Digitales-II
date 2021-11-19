arbitro2: testbench2.v
	iverilog -o salida testbench2.v
	vvp salida
	gtkwave arbitro2.vcd

arbitro1: testbench1.v
	iverilog -o salida testbench1.v
	vvp salida
	gtkwave arbitro1.vcd

synth1: arbitro1.ys
	yosys -s arbitro1.ys
	sed -i 's/arbitro1/arbitro1_estr/' arbitro1_estr.v
	sed -i 's/pop/pop_estr/g' arbitro1_estr.v
	sed -i 's/push/push_estr/' arbitro1_estr.v


clean:
	rm -f *.o

