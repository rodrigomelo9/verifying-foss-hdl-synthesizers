#!/bin/bash

set -e

STD=$1
FILE=$2
NAME=$3

FLAGS="-fsynopsys -fexplicit -frelaxed --std=$STD"

echo "# Analysis with 'ghdl -a'"
ghdl -a $FLAGS $FILE
echo "# Elaboration with 'ghdl -e'"
ghdl -e $FLAGS $NAME
echo "# Runnig with 'ghdl -r'"
ghdl -r $FLAGS $NAME

echo "# Synthesis with 'ghdl --synth'"
ghdl --synth $FLAGS $NAME

echo "# Synthesis with ghdl-yosys-plugin"
YOSYS_CMD="'ghdl $FLAGS $NAME; synth_xilinx -family xc7; write_edif -pvector bra yosys.edif'"
eval yosys -Q -m ghdl -p $YOSYS_CMD
