ARG IMAGE="ghdl/synth:beta"

#---

FROM $IMAGE AS base

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    iverilog \
    verilator \
 && apt-get autoclean && apt-get clean && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists

#---

ARG VIVADO_DIR="/opt/Xilinx/vivado"
ARG ISE_DIR="/opt/Xilinx/ise"
ARG QUARTUS_DIR="/opt/Intel/quartus"

ENV PATH $VIVADO_DIR/bin:$ISE_DIR/ISE/bin/lin64:$QUARTUS_DIR/quartus/bin:$PATH
