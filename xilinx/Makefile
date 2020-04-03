#!/usr/bin/make

ISE=/opt/Xilinx/ise
VIVADO=/opt/Xilinx/vivado
TASK=imp

vpath %.zip downloads

all: iverilog

#
# Prepare
#

xstug_examples.zip:
	wget -P downloads -c www.xilinx.com/txpatches/pub/documentation/misc/xstug_examples.zip

ug901-vivado-synthesis-examples.zip:
	wget -P downloads -c www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug901-vivado-synthesis-examples.zip

examples: xstug_examples.zip ug901-vivado-synthesis-examples.zip
	mkdir -p examples
	unzip -o -d examples downloads/xstug_examples.zip
	rm -fr examples/ise
	mv examples/xstug_examples examples/ise
	unzip -o -d examples/vivado downloads/ug901-vivado-synthesis-examples.zip
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

#
# Collecting Verilog files
#

VERILOGS  = $(shell find examples/ -type f -name '*.v' | sort)


# Filtering Files with iverilog complains
## Syntax errors in ports declarations
VERILOGS_TO_FILTER  = examples/vivado/xor_top.v
VERILOGS_TO_FILTER += examples/vivado/sfir_even_symmetric_systolic_top.v
VERILOGS_TO_FILTER += examples/vivado/sfir_shifter.v
## Is a VHDL package with stranger things
VERILOGS_TO_FILTER += examples/vivado/procedure_package_1.v
## Is a zip file
VERILOGS_TO_FILTER += examples/vivado/tristates_3.v
### Invalid code (missing generate statement), well solved in bytewrite_writefirst.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/rams/bytewrite_writefirst_test2.v
## 24: error: Array RAM needs an array index here.
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/rams/rams_25.v
# Filtering Files with unsupported Yosys features
## The primitive keyword is unsupported
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/user_defined_primitives/udp_sequential_1.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/user_defined_primitives/udp_sequential_2.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/user_defined_primitives/udp_combinatorial_1.v
## Filtering others not synthesizable
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/assign_deassign/assign_deassign_good.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/assign_deassign/assign_deassign_reject_2.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/assign_deassign/assign_deassign_reject_1.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/assign_deassign/assign_deassign_reject_3.v
# Filtering duplicated Files
## find -name '*.v' -type f -printf '%p %f\n' | sort -t ' ' -k 2,2 | uniq -f 1 --all-repeated=separate | cut -d' ' -f1
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/black_box/black_box_1.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/rams/bytewrite_ram_1a.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/rams/bytewrite_ram_1b.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/dsp/OddSymTranspConvFIR_verilog/DelayLine.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/dsp/OddSymTranspConvFIR_verilog/FilterStage.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/dynamic_shift_registers/dynamic_shift_registers_1.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/system_tasks/finish_ignored_1.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/system_tasks/finish_supported_1.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/functions_tasks/functions_1.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/functions_tasks/functions_constant.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/parameter/parameter_1.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/parameter/parameter_generate_for_1.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/registers/registers_1.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/shift_registers/shift_registers_0.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/shift_registers/shift_registers_1.v
VERILOGS_TO_FILTER += examples/ise/Verilog_Language_Support/functions_tasks/tasks_1.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/tristates/tristates_1.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/tristates/tristates_2.v
# Filtering files which are anyway analyzed because are included
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/dsp/EvenSymTranspConvFIR_verilog/DelayLine.v
VERILOGS_TO_FILTER += examples/ise/HDL_Coding_Techniques/dsp/EvenSymTranspConvFIR_verilog/FilterStage.v
# Filtering examples with $finish
## It is supported by all the tools (and fails)
VERILOGS_TO_FILTER += examples/vivado/finish_supported_1.v
## Yosys abort and ISE/Vivado ignore it
VERILOGS_TO_FILTER += examples/vivado/finish_ignored_1.v
# Can't be implemented and unuseful for synthesis
VERILOGS_TO_FILTER += examples/vivado/black_box_1.v

VERILOGS := $(filter-out $(VERILOGS_TO_FILTER), $(VERILOGS))

NO_OF_VERILOGS = $(words $(VERILOGS))

#
# iVerilog analysis
#

IVERILOG_EXTRA = \
support/blackboxes.v \
-yexamples/ise/HDL_Coding_Techniques/dsp/EvenSymTranspConvFIR_verilog

iverilog:
	@echo "Analysing $(NO_OF_VERILOGS) files with iVerilog"
	@$(foreach FILE, $(VERILOGS), \
		echo "* $(FILE)"; \
		iverilog $(IVERILOG_EXTRA) $(FILE); \
	)
	@echo "DONE"

#
# Synthesis with Yosys
#

# Filtering Files with Yosys complains
## Unsupported by Yosys and seems not standard (https://github.com/YosysHQ/yosys/issues/1800)
TO_FILTER_IN_YOSYS += examples/vivado/parameter_1.v
## True dual-port memories are not yet supported (https://github.com/YosysHQ/yosys/issues/1802)
TO_FILTER_IN_YOSYS += examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_2c.v
TO_FILTER_IN_YOSYS += examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_2d.v
TO_FILTER_IN_YOSYS += examples/ise/HDL_Coding_Techniques/rams/asymmetric_write_first_1.v
TO_FILTER_IN_YOSYS += examples/ise/HDL_Coding_Techniques/rams/asymmetric_write_first_2.v
TO_FILTER_IN_YOSYS += examples/ise/HDL_Coding_Techniques/rams/asymmetric_write_first_3.v
TO_FILTER_IN_YOSYS += examples/ise/HDL_Coding_Techniques/rams/rams_16.v
TO_FILTER_IN_YOSYS += examples/vivado/bytewrite_tdp_ram_rf.v
TO_FILTER_IN_YOSYS += examples/vivado/bytewrite_tdp_ram_readfirst2.v
TO_FILTER_IN_YOSYS += examples/vivado/bytewrite_tdp_ram_wf.v
TO_FILTER_IN_YOSYS += examples/vivado/bytewrite_tdp_ram_nc.v
TO_FILTER_IN_YOSYS += examples/vivado/rams_tdp_rf_rf.v
TO_FILTER_IN_YOSYS += examples/vivado/asym_ram_tdp_read_first.v
### This in particular never ends
TO_FILTER_IN_YOSYS += examples/vivado/asym_ram_tdp_write_first.v


VERILOGS_FOR_YOSYS  = $(filter-out $(TO_FILTER_IN_YOSYS), $(VERILOGS))

NO_OF_VERILOGS_FOR_YOSYS = $(words $(VERILOGS_FOR_YOSYS))

GENERAL_DEPS = \
-f examples/ise/HDL_Coding_Techniques/dsp/EvenSymTranspConvFIR_verilog/DelayLine.v \
-f examples/ise/HDL_Coding_Techniques/dsp/EvenSymTranspConvFIR_verilog/FilterStage.v

YOSYS_DEPS = \
$(GENERAL_DEPS) \
-f support/blackboxes.v

yosys yosys-ise yosys-vivado:
	mkdir -p reports/$@
	@echo "Analysing $(NO_OF_VERILOGS_FOR_YOSYS) files with $@"
	@$(foreach FILE, $(VERILOGS_FOR_YOSYS), \
		echo "* Analizyng $(FILE)"; \
		fpga-hdl2bit --outdir temp/yosys --tool $@ $(YOSYS_DEPS) --run $(TASK) $(FILE) > \
		$(addprefix reports/$@/, $(addsuffix .txt, $(notdir $(basename $(FILE))))); \
	)
	@echo "DONE"

#
# Synthesis with Xilinx tools
#

# Filtering Files with ISE complains
## Rejected by ISE:
## Mix of blocking and non-blocking assignments to variable <o> is not a recommended coding practice.
## INFO - You can change the severity of this error message to warning using switch -change_error_to_warning "HDLCompiler:1511"
TO_FILTER_IN_ISE  = examples/ise/Verilog_Language_Support/rejected/blockingmix1.v
TO_FILTER_IN_ISE += examples/ise/Verilog_Language_Support/rejected/blockingmix2.v
## The INIT value is specified with an attribute, which is rejected by XST
TO_FILTER_IN_ISE += examples/ise/FPGA_Optimization/primitive_support/primitive_1.v


VERILOGS_FOR_ISE  = $(filter-out $(TO_FILTER_IN_ISE), $(VERILOGS))

NO_OF_VERILOGS_FOR_ISE = $(words $(VERILOGS_FOR_ISE))

ise:
	mkdir -p reports/$@
	@echo "Analysing $(NO_OF_VERILOGS_FOR_ISE) files with $@"
	@$(foreach FILE, $(VERILOGS_FOR_ISE), \
		echo "* Analizyng $(FILE)"; \
		fpga-hdl2bit --outdir temp/ise --tool $@ $(GENERAL_DEPS) --run $(TASK) $(FILE) > \
		$(addprefix reports/$@/, $(addsuffix .txt, $(notdir $(basename $(FILE))))); \
	)
	@echo "DONE"

# Filtering Files with Vivado complains
## Unsupported RAM template
TO_FILTER_IN_VIVADO  = examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_3.v
TO_FILTER_IN_VIVADO += examples/ise/HDL_Coding_Techniques/rams/asymmetric_write_first_1.v
TO_FILTER_IN_VIVADO += examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_2d.v
TO_FILTER_IN_VIVADO += examples/ise/HDL_Coding_Techniques/rams/asymmetric_write_first_3.v
TO_FILTER_IN_VIVADO += examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_4.v
TO_FILTER_IN_VIVADO += examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_2c.v
TO_FILTER_IN_VIVADO += examples/ise/HDL_Coding_Techniques/rams/asymmetric_write_first_2.v
# ISE attribute unsupported on Vivado
## CRITICAL WARNING: [Synth 8-5397] Deprecated attribute BUFFER_TYPE found on pin clk.
## Please use IO_BUFFER_TYPE or CLOCK_BUFFER_TYPE. BUFFER_TYPE will not be supported in future releases.
TO_FILTER_IN_VIVADO += examples/ise/Verilog_Language_Support/attributes/vlgattrib2001_1.v


VERILOGS_FOR_VIVADO  = $(filter-out $(TO_FILTER_IN_VIVADO), $(VERILOGS))

NO_OF_VERILOGS_FOR_VIVADO = $(words $(VERILOGS_FOR_VIVADO))

vivado:
	mkdir -p reports/$@
	@echo "Analysing $(NO_OF_VERILOGS_FOR_VIVADO) files with $@"
	@$(foreach FILE, $(VERILOGS_FOR_VIVADO), \
		echo "* Analizyng $(FILE)"; \
		fpga-hdl2bit --outdir temp/vivado --tool $@ $(GENERAL_DEPS) --run $(TASK) $(FILE) > \
		$(addprefix reports/$@/, $(addsuffix .txt, $(notdir $(basename $(FILE))))); \
	)
	@echo "DONE"

#
# Report Errors
#

report-errors:
	@$(foreach DIR,$(wildcard reports/*), \
		echo "*\n* $(DIR)\n*"; \
		grep -rin "ERROR:" $(DIR); \
		grep -rin "Aborted" $(DIR); \
	)

#
# Clean
#

clean:
	rm -fr a.out temp

clean-all: clean
	rm -fr downloads examples reports
