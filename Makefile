IVERILOG ?= iverilog
VVP ?= vvp
YOSYS ?= yosys
.PHONY: test synth clean
test:
	mkdir -p build
	$(IVERILOG) -g2012 -Wall -s tb_memqos_arbiter4 -o build/sim rtl/memqos_arbiter4.sv tb/tb_memqos_arbiter4.sv
	$(VVP) build/sim
synth:
	mkdir -p build
	$(YOSYS) -Q -T -l build/synthesis.log -p 'read_verilog -sv rtl/memqos_arbiter4.sv; hierarchy -check -top memqos_arbiter4; synth -top memqos_arbiter4; stat'
clean:
	rm -f build/sim
