#!/usr/bin/make

ISE=/opt/Xilinx/ise
VIVADO=/opt/Xilinx/vivado
TASK=imp

include Makeyosys
include Makeghdl

all: prepare

prepare:
	wget -P examples -c www.xilinx.com/txpatches/pub/documentation/misc/xstug_examples.zip
	wget -P examples -c www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug901-vivado-synthesis-examples.zip
	unzip -o -d examples examples/xstug_examples.zip
	rm -fr examples/ise
	mv examples/xstug_examples examples/ise
	unzip -o -d examples/vivado examples/ug901-vivado-synthesis-examples.zip
	# diff -u ORIGINAL UPDATED > support/patch.diff
	@echo "Applying patches to solve errors"
	# Verilogs
	patch examples/ise/HDL_Coding_Techniques/dsp/EvenSymTranspConvFIR_verilog/EvenSymTranspConvFIR.v < support/EvenSymTranspConvFIR.diff
	patch examples/ise/HDL_Coding_Techniques/dsp/OddSymTranspConvFIR_verilog/OddSymTranspConvFIR.v   < support/OddSymTranspConvFIR.diff
	# VHDLs
	patch examples/ise/VHDL_Language_Support/file_type_support/fileread_endfile.vhd                  < support/fileread_endfile.diff
	patch examples/ise/HDL_Coding_Techniques/rams/rams_20c.vhd                                       < support/rams_20c.diff
	patch examples/ise/HDL_Coding_Techniques/rams/ram_protected_sharedvar.vhd                        < support/ram_protected_sharedvar.diff
	patch examples/ise/VHDL_Language_Support/nonlrm_supported/nonlrm_bufferout.vhd                   < support/nonlrm_bufferout.diff
	patch examples/ise/VHDL_Language_Support/nonlrm_supported/nonlrm_outbuffer.vhd                   < support/nonlrm_outbuffer.diff
	patch examples/vivado/rams_init_file.vhd                                                         < support/rams_init_file.diff
	patch examples/vivado/roms_1.vhd                                                                 < support/roms_1.diff

verify: verify-verilog verify-vhdl

report-errors:
	@$(foreach DIR,$(wildcard reports/*), \
		echo "*\n* $(DIR)\n*"; \
		grep -rnE "ERROR|error:" $(DIR); \
		grep -rin "Aborted"      $(DIR); \
	)

clean:
	rm -fr a.out temp core *.edif

clean-all: clean
	rm -fr examples reports
