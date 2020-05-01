#!/usr/bin/make

prepare:
	docker build -t verifying-foss-hdl-synthesizers -f Dockerfile .
	make -C xilinx prepare
	make -C FPGADesignElements prepare

verify-ghdl:
	make -C xilinx ghdl-yosys

verify-yosys:
	make -C xilinx yosys-vivado
	make -C FPGADesignElements yosys-vivado
