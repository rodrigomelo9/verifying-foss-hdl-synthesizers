#!/usr/bin/make

TASK=syn

all: prepare

#
# Prepare
#

prepare:
	git clone https://github.com/laforest/FPGADesignElements.git examples
	sed -i -E "s/parameter\s+WORD_WIDTH\s*=\s*0/parameter WORD_WIDTH = 8/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_COUNT\s*=\s*0/parameter WORD_COUNT = 2/g" examples/*.v
	sed -i -E "s/parameter\s+PULSE_LENGTH\s*=\s*0/parameter PULSE_LENGTH = 2/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_WIDTH_A\s*=\s*0/parameter WORD_WIDTH_A = 8/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_WIDTH_B\s*=\s*0/parameter WORD_WIDTH_B = 8/g" examples/*.v
	sed -i -E "s/parameter\s+ADDR_WIDTH\s*=\s*0/parameter ADDR_WIDTH = 3/g" examples/*.v
	sed -i -E "s/parameter\s+INPUT_ADDR_BASE\s*=\s*0/parameter INPUT_ADDR_BASE = 3/g" examples/*.v
	sed -i -E "s/parameter\s+OUTPUT_ADDR_WIDTH\s*=\s*0/parameter OUTPUT_ADDR_WIDTH = 3/g" examples/*.v
	sed -i -E "s/parameter\s+INPUT_COUNT\s*=\s*0/parameter INPUT_COUNT = 3/g" examples/*.v
	sed -i -E "s/parameter\s+BINARY_WIDTH\s*=\s*0/parameter BINARY_WIDTH = 8/g" examples/*.v
	sed -i -E "s/parameter\s+OUTPUT_WIDTH\s*=\s*0/parameter OUTPUT_WIDTH = 8/g" examples/*.v
	sed -i -E "s/parameter\s+OUTPUT_COUNT\s*=\s*0/parameter OUTPUT_COUNT = 8/g" examples/*.v
	sed -i -E "s/parameter\s+PIPE_DEPTH\s*=\s*0/parameter PIPE_DEPTH = 2/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_WIDTH_IN\s*=\s*0/parameter WORD_WIDTH_IN = 8/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_WIDTH_OUT\s*=\s*0/parameter WORD_WIDTH_OUT = 8/g" examples/*.v
	sed -i -E "s/parameter\s+IMPLEMENTATION\s*=\s*\"\"/parameter IMPLEMENTATION = \"MUX\"/g" examples/*.v
	sed -i -E "s/parameter\s+EDGE_TYPE\s*=\s*\"\"/parameter EDGE_TYPE = \"POS\"/g" examples/*.v

#
# Collecting Verilog files
#

VERILOGS  = $(shell find examples/ -type f -name '*.v' | sort)

# Filtering Files
## Not synthesizable
VERILOGS_TO_FILTER  = examples/Simulation_Clock.v

VERILOGS := $(filter-out $(VERILOGS_TO_FILTER), $(VERILOGS))

NO_OF_VERILOGS = $(words $(VERILOGS))

DEPS_TO_FILTER = \
examples/Adder_Subtractor_Binary.v \
examples/Address_Decoder_Behavioural.v \
examples/Annuller.v \
examples/Arithmetic_Predicates_Binary.v \
examples/Binary_to_One_Hot.v \
examples/Bit_Reducer.v \
examples/Bit_Shifter.v \
examples/Bitmask_Isolate_Rightmost_1_Bit.v \
examples/Bitmask_Thermometer_to_Rightmost_1_Bit.v \
examples/CarryIn_Binary.v \
examples/CDC_Synchronizer.v \
examples/Counter_Binary.v \
examples/Demultiplexer_One_Hot.v \
examples/Dyadic_Boolean_Operator.v \
examples/Hamming_Distance.v \
examples/Logarithm_of_Powers_of_Two.v \
examples/Multiplexer_Binary_Behavioural.v \
examples/Multiplexer_One_Hot.v \
examples/Multiplexer_Bitwise_2to1.v \
examples/Number_of_Trailing_Zeros.v \
examples/Population_Count.v \
examples/Priority_Arbiter.v \
examples/Pulse_Generator.v \
examples/Pulse_Latch.v \
examples/Register.v \
examples/Register_Toggle.v \
examples/Register_Pipeline.v \
examples/Word_Reducer.v \
examples/Word_Reverser.v

VERILOGS := $(filter-out $(DEPS_TO_FILTER), $(VERILOGS))
DEPS = $(addprefix -f , $(DEPS_TO_FILTER))

#
# analyze
#

analyze: iverilog verilator

iverilog:
	@echo "Analysing $(NO_OF_VERILOGS) files with iVerilog"
	@$(foreach FILE, $(VERILOGS), \
		echo "* $(FILE)"; \
		iverilog -Iexamples -yexamples $(FILE); \
	)
	@echo "DONE"

verilator:
	@echo "Analysing $(NO_OF_VERILOGS) files with Verilator"
	@$(foreach FILE, $(VERILOGS), \
		echo "* $(FILE)"; \
		verilator --lint-only -Iexamples $(FILE); \
	)
	@echo "DONE"

#
# Synthesis with Yosys
#

yosys-vivado:
	mkdir -p reports/$@
	@echo "Analysing $(NO_OF_VERILOGS) files with $@"
	@$(foreach FILE, $(VERILOGS), \
		echo "* Analizyng $(FILE)"; \
		fpga-hdl2bit --outdir temp/yosys --tool $@ --run $(TASK) $(DEPS) $(FILE) > \
		$(addprefix reports/$@/, $(addsuffix .txt, $(notdir $(basename $(FILE))))); \
	)
	@echo "DONE"

#
# Synthesis with vendor tools
#

ise vivado quartus:
	mkdir -p reports/$@
	@echo "Analysing $(NO_OF_VERILOGS) files with $@"
	@$(foreach FILE, $(VERILOGS), \
		echo "* Analizyng $(FILE)"; \
		fpga-hdl2bit --outdir temp/$@ --tool $@ --run $(TASK) $(DEPS) $(FILE) > \
		$(addprefix reports/$@/, $(addsuffix .txt, $(notdir $(basename $(FILE))))); \
	)
	@echo "DONE"

#
# Report
#

report-errors:
	@$(foreach DIR,$(wildcard reports/*), \
		echo "*\n* $(DIR)\n*"; \
		grep -rnE "ERROR|error:" $(DIR); \
		grep -rin "Aborted"      $(DIR); \
	)

#
# Clean
#

clean:
	rm -fr a.out temp

clean-all: clean
	rm -fr examples reports

#
# Verification
#

verify-yosys:
	@$(foreach FILE, $(VERILOGS), \
		fpga-hdl2bit --tool yosys-vivado --run $(TASK) $(DEPS) $(FILE) || exit 1; \
	)
