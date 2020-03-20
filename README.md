# Yosys versus: a project to check the FOSS synthesizer against vendors EDA tools

The aim of this project is to provide feedback about things supported by the vendor EDA tools,
which presents problems in Yosys.

> Disclaimer: it is an independent project, not endorsed by the Yosys project.

## System prepare (Debian based distributions and probably others GNU/Linux systems)

* Install Yosys following [https://github.com/YosysHQ/yosys#setup](this) instructions.
* Install PyFPGA following [https://gitlab.com/rodrigomelo9/pyfpga#installation](this) instructions.
* To run ISE examples: `export PATH=<ISE_ROOT_PATH>/ISE/bin/lin64:$PATH`
* To run Vivado examples: `export PATH=<VIVADO_ROOT_PATH>/bin:$PATH`

## License

Yosys-versus is distributed under the same [ISC](LICENSE) license used by Yosys.
