o: testbench2.v
	iverilog -o salida testbench2.v
	vvp salida
	gtkwave resultados.vcd

synth: arbitro2.ys
	yosys -s arbitro2.ys
	sed -i 's/arbitro2/arbitro2_estr/' arbitro2_estr.v
	sed -i 's/pop/pop_estr/g' arbitro2_estr.v
	sed -i 's/push/push_estr/' arbitro2_estr.v

clean:
	rm -f *.o
