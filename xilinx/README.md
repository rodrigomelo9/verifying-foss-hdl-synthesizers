# Yosys vs the Xilinx tools (ISE/Vivado)

Here, synthesizable examples for ISE and Vivado, provided by Xilinx, are downloaded, unzipped,
patched (in some cases), filtered (some files with problems or duplicated are removed from the
list) and synthesized/implemented with Yosys, ISE and Vivado.

## Instructions

* The first time (or when there is a message about examples not found), run: `make examples`
* With `make` or `make iverilog` the list of selected Verilog files are analyzed with the iverilog
simulator.
* The targets for synthesis (`make <TARGET>`) are:
    * `yosys`: generic Yosys synthesis.
    * `yosys-ise`: Yosys synthesis to use ise as backend.
    * `yosys-vivado`: Yosys synthesis to use vivado as backend.
    * `ise`: synthesis using ise (xst).
    * `vivado`: synthesis using vivado.
* The default operation is implementation (`imp`) but can be changed to synthesis (`syn`) using:
`make TASK=syn <TARGET>`

## Remarks

* Unsupported non-standard things in Yosys (vs ISE/Vivado):
    * Specification of parameters without parenthesis in module instantiation.
    * Use of semicolon after an `end`/`endmodule`.
* Several asymmetric TDP rams which are supported by ISE are not supported by Vivado:
    * examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_3.v
    * examples/ise/HDL_Coding_Techniques/rams/asymmetric_write_first_1.v
    * examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_2d.v
    * examples/ise/HDL_Coding_Techniques/rams/asymmetric_write_first_3.v
    * examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_4.v
    * examples/ise/HDL_Coding_Techniques/rams/asymmetric_ram_2c.v
    * examples/ise/HDL_Coding_Techniques/rams/asymmetric_write_first_2.v
* Yosys don't supports TDP rams with more than one write port.

# ghdl-yosys-plugin

An additional makefile, called *Makeghdl*, is provided to test using
[this](https://github.com/ghdl/ghdl-yosys-plugin) plugin.
Targets like `examples`, `report-errors`, `clean` and `clean-all` are still solved by *Makefile*.

## Instructions

* The examples are still download with *Makefile*, running: `make examples`
* With `make -f Makeghdl` or `make -f Makeghdl ghdl` the list of selected VHDL files are analyzed
with the GHDL simulator.
* The targets for synthesis (`make -f Makeghdl <TARGET>`) are:
    * `gosys`: ghdl-yosys plugin using ISE as backend.
    * `ise`: synthesis using ise (xst).
* The default operation is implementation (`imp`) but can be changed to synthesis (`syn`) using:
`make -f Makeghdl TASK=syn <TARGET>`

## Remarks

* The employment of the plugin is solved using a Python script (`../helpers/gosys.py`).
* The script is run using the Docker image provided by the plugin project.
