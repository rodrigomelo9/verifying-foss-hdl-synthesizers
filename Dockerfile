ARG IMAGE="ghdl/synth:beta"

FROM $IMAGE AS base

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    git \
    iverilog \
    python3 \
    python3-pip \
    python3-setuptools \
    verilator \
 && apt-get autoclean && apt-get clean && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists

RUN pip3 install -e 'git+https://gitlab.com/rodrigomelo9/pyfpga#egg=pyfpga'
