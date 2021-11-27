all: synth PCIE

synth: pcie.ys
	yosys -s pcie.ys
	sed -i 's/PCIE/PCIE_estr/' PCIE_estr.v
	sed -i 's/data_out4/data_out4_estr/g' PCIE_estr.v
	sed -i 's/data_out5/data_out5_estr/g' PCIE_estr.v
	sed -i 's/data_out6/data_out6_estr/g' PCIE_estr.v
	sed -i 's/data_out7/data_out7_estr/g' PCIE_estr.v
	sed -i 's/arbitro1/arbitro1_estr/g' PCIE_estr.v
	sed -i 's/arbitro2/arbitro2_estr/g' PCIE_estr.v
	sed -i 's/contadores/contadores_estr/g' PCIE_estr.v
	sed -i 's/fifo/fifo_estr/g' PCIE_estr.v
	sed -i 's/fsm/fsm_estr/g' PCIE_estr.v

PCIE: testbench.v
	iverilog -o salida.o testbench.v
	vvp salida.o
	gtkwave resultados.vcd

a:	
	emacs --batch  testbench.v -f verilog-batch-auto

clean:
	rm -f *.o
	rm -f *.vcd






