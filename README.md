# Verifying FOSS HDL-synthesizers 

![Verification Status](https://github.com/rodrigomelo9/verifying-foss-hdl-synthesizers/workflows/verify/badge.svg)

The aim of this project is to provide feedback about things supported by the vendor EDA tools,
which presents problems for Yosys or GHDL.

## System prepare (GNU/Linux systems)

* Install Docker following [these](https://docs.docker.com/install) instructions.
* `make prepare` (creates a Docker image and downloads examples).
* `bash helpers/docker_run.sh make verify-yosys` to verify `yosys` against several examples.
* `bash helpers/docker_run.sh make verify-ghdl` to verify `ghdl-yosys-plugin` against several examples.
* Read `README.md` of each sub-directory for more alternatives.

> **NOTE:** take in account that if you will use a vendor tool:
> * To run ISE: `export PATH=<ISE_ROOT_PATH>/ISE/bin/lin64:$PATH`
> * To run Vivado: `export PATH=<VIVADO_ROOT_PATH>/bin:$PATH`
> * To run Quartus: `export PATH=<QUARTUS_ROOT_PATH>/quartus/bin:$PATH`

## License

Yosys-versus is distributed under [ISC](LICENSE) license.
