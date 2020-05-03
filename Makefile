#!/usr/bin/make

build:
	docker build -t verifying-foss-hdl-synthesizers -f Dockerfile .

prepare:
	make -C xilinx prepare
	make -C FPGADesignElements prepare

verify-yosys:
	make -C xilinx $@
	make -C FPGADesignElements $@

verify-ghdl:
	make -C xilinx $@

verify-ghdl-yosys:
	make -C xilinx $@

clean-all:
	make -C xilinx $@
	make -C FPGADesignElements $@
