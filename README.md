# Verifying FOSS HDL-synthesizers 

![Verification Status](https://github.com/rodrigomelo9/verifying-foss-hdl-synthesizers/workflows/verify/badge.svg)

The aim of this project is to provide feedback about things supported by the vendor EDA tools,
which presents problems for Yosys and/or GHDL.

## System prepare (Debian based distributions and probably others GNU/Linux systems)

* Install Yosys following [these](https://github.com/YosysHQ/yosys#setup) instructions.
* Install PyFPGA following [these](https://gitlab.com/rodrigomelo9/pyfpga#installation) instructions.
* Install iverilog and verilator.
* Install Docker following [these](https://docs.docker.com/install) instructions (to use GHDL).
* To run ISE: `export PATH=<ISE_ROOT_PATH>/ISE/bin/lin64:$PATH`
* To run Vivado: `export PATH=<VIVADO_ROOT_PATH>/bin:$PATH`

## License

Yosys-versus is distributed under [ISC](LICENSE) license.
