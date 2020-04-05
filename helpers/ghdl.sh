#!/bin/bash

set -e

STD=$1
FILE=$2
NAME=$3

DOCKER_CMD="$(command -v winpty) docker run --rm -it -v /$(pwd)://wrk -w //wrk ghdl/synth:beta"

FLAGS="-fsynopsys -fexplicit -frelaxed --std=$STD"

echo "# Analysis with 'ghdl -a'"
$DOCKER_CMD ghdl -a $FLAGS $FILE
echo "# Elaboration with 'ghdl -e'"
$DOCKER_CMD ghdl -e $FLAGS $NAME
echo "# Runnig with 'ghdl -r'"
$DOCKER_CMD ghdl -r $FLAGS $NAME

echo "# Synthesis with 'ghdl --synth'"
$DOCKER_CMD ghdl --synth $FLAGS $NAME

echo "# Synthesis with ghdl-yosys-plugin"
YOSYS_CMD="'ghdl $FLAGS $NAME; synth_xilinx -family xc7; write_edif -pvector bra yosys.edif'"
eval $DOCKER_CMD yosys -Q -m ghdl -p $YOSYS_CMD
