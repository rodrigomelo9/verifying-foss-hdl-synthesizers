# Verifying FOSS HDL-synthesizers

![Yosys Verification](https://github.com/rodrigomelo9/verifying-foss-hdl-synthesizers/workflows/yosys/badge.svg)
![GHDL Verification](https://github.com/rodrigomelo9/verifying-foss-hdl-synthesizers/workflows/ghdl/badge.svg)
![ghdl-yosys-plugin Verification](https://github.com/rodrigomelo9/verifying-foss-hdl-synthesizers/workflows/ghdl-yosys-plugin/badge.svg)

The aim of this project is to provide feedback about things supported by the vendor EDA tools, which presents [issues](issues.md) for [Yosys](https://github.com/YosysHQ/yosys), [GHDL](https://github.com/ghdl/ghdl) or [ghdl-yosys-plugin](https://github.com/ghdl/ghdl-yosys-plugin). This is performed, running the tools against several examples from different sources:
* [xilinx](xilinx): Verilog and VHDL examples for ISE and Vivado, provided by Xilinx.
* [FPGADesignElements](FPGADesignElements): a [online book](https://github.com/laforest/FPGADesignElements) containing a library of FPGA Verilog design modules.

Firstly, the examples are checked with commercial tools such as ISE, Vivado and Quartus, to check if they are synthesizable.
Secondly, they are analyzed with tools like iVerilog and GHDL to detect non-standard constructions.
Then, the tools under test are employed. If an issue is detected, it is reported and the file is ignored until fixed.
To simplify tools and options handling, `fpga-hdl2bit` from the [PyFPGA](https://gitlab.com/rodrigomelo9/pyfpga) project is used (when supported).

A Dockerfile, based on `ghdl/synth:beta` from the [ghdl/docker](https://github.com/ghdl/docker) project (which supports the three tools under test), is provided.
It is employed for the CI of the repository and can be used to run in any GNU/Linux with [Docker installed](https://docs.docker.com/install) on:
* `make build` creates the needed Docker image.
* `make prepare` downloads the examples (they are not part of the repository).
* `bash helpers/docker_run.sh make verify-yosys` to verify `yosys`.
* `bash helpers/docker_run.sh make verify-ghdl` to verify `ghdl --synth`.
* `bash helpers/docker_run.sh make verify-ghdl-yosys` to verify `ghdl-yosys-plugin`.

## License

Yosys-versus is distributed under [ISC](LICENSE) license.
