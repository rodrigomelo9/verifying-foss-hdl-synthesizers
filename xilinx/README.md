# Yosys vs the Xilinx tools (ISE/Vivado)

Here, synthesizable examples for ISE and Vivado, provided by Xilinx, are downloaded, unzipped,
patched (in some cases), filtered (some files with problems or duplicated are removed from the
list) and synthesized with Yosys, ISE and Vivado.

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
* The default operation is synthesis (`syn`) but can be changed to implementation (`imp`) using:
`make TASK=imp <TARGET>`

## Remarks

* Unsupported non-standard things in Yosys (vs ISE/Vivado):
    * Specification of parameters without parenthesis in module instantiation.
    * Use of semicolon after an `end`/`endmodule`.
* Several asymmetric rams which are supported by ISE are not supported by Vivado.
