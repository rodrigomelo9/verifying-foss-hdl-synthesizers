#!/usr/bin/make

ISE=/opt/Xilinx/ise
VIVADO=/opt/Xilinx/vivado

vpath %.zip downloads

all: iverilog

#
# Downloads
#

xstug_examples.zip:
	wget -P downloads -c www.xilinx.com/txpatches/pub/documentation/misc/xstug_examples.zip

ug901-vivado-synthesis-examples.zip:
	wget -P downloads -c www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug901-vivado-synthesis-examples.zip

#
# Prepare examples
#

examples: xstug_examples.zip ug901-vivado-synthesis-examples.zip
	mkdir -p examples
	unzip -o -d examples downloads/xstug_examples.zip
	rm -fr examples/ise
	mv examples/xstug_examples examples/ise
	unzip -o -d examples/vivado downloads/ug901-vivado-synthesis-examples.zip
	@echo "Applying patches to solve errors"
	patch examples/ise/HDL_Coding_Techniques/dsp/EvenSymTranspConvFIR_verilog/EvenSymTranspConvFIR.v < support/EvenSymTranspConvFIR.diff
	patch examples/ise/HDL_Coding_Techniques/dsp/OddSymTranspConvFIR_verilog/OddSymTranspConvFIR.v   < support/OddSymTranspConvFIR.diff

#
# Collecting Verilog files
#

VERILOGS  = $(shell find examples/ -type f -name '*.v')

# Filtering Files with iverilog complains
## Syntax errors in ports declarations
VERILOGS := $(filter-out examples/vivado/xor_top.v                                                              , $(VERILOGS))
VERILOGS := $(filter-out examples/vivado/sfir_even_symmetric_systolic_top.v                                     , $(VERILOGS))
VERILOGS := $(filter-out examples/vivado/sfir_shifter.v                                                         , $(VERILOGS))
## Is a VHDL package with stranger things
VERILOGS := $(filter-out examples/vivado/procedure_package_1.v                                                  , $(VERILOGS))
## Is a zip file
VERILOGS := $(filter-out examples/vivado/tristates_3.v                                                          , $(VERILOGS))
## Invalid code (missing generate statement), well solved in bytewrite_writefirst.v
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/rams/bytewrite_writefirst_test2.v                   , $(VERILOGS))
## 24: error: Array RAM needs an array index here.
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/rams/rams_25.v                                      , $(VERILOGS))

# Filtering Files with unsupported Yosys features
## The primitive keyword is unsupported
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/user_defined_primitives/udp_sequential_1.v       , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/user_defined_primitives/udp_sequential_2.v       , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/user_defined_primitives/udp_combinatorial_1.v    , $(VERILOGS))

# Filtering duplicated Files
## find -name '*.v' -type f -printf '%p %f\n' | sort -t ' ' -k 2,2 | uniq -f 1 --all-repeated=separate | cut -d' ' -f1
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/black_box/black_box_1.v                             , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/rams/bytewrite_ram_1b.v                             , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/dsp/OddSymTranspConvFIR_verilog/DelayLine.v         , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/dynamic_shift_registers/dynamic_shift_registers_1.v , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/dsp/OddSymTranspConvFIR_verilog/FilterStage.v       , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/system_tasks/finish_ignored_1.v                  , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/system_tasks/finish_supported_1.v                , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/functions_tasks/functions_1.v                    , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/functions_tasks/functions_constant.v             , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/parameter/parameter_1.v                          , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/parameter/parameter_generate_for_1.v             , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/registers/registers_1.v                             , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/shift_registers/shift_registers_0.v                 , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/shift_registers/shift_registers_1.v                 , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/Verilog_Language_Support/functions_tasks/tasks_1.v                        , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/tristates/tristates_1.v                             , $(VERILOGS))
VERILOGS := $(filter-out examples/ise/HDL_Coding_Techniques/tristates/tristates_2.v                             , $(VERILOGS))

#
# iVerilog analysis
#

IVERILOG_EXTRA= support/blackboxes.v -yexamples/ise/HDL_Coding_Techniques/dsp/EvenSymTranspConvFIR_verilog

iverilog: examples
	@echo "Analysing with iVerilog"
	@$(foreach FILE, $(VERILOGS), $(shell iverilog $(IVERILOG_EXTRA) $(FILE)))

#
# Clean
#

clean:
	rm -fr a.out examples

clean-all: clean
	rm -fr downloads
