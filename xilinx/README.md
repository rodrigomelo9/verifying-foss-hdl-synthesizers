# Yosys and GHDL vs the Xilinx tools (ISE/Vivado)

Here, synthesizable examples for ISE and Vivado, provided by Xilinx, are downloaded, unzipped,
patched (in some cases), filtered (some files with problems or duplicated are removed from the
list) and synthesized/implemented with Yosys, ISE and Vivado.

## Instructions

* Prepare the examples with `make` or `make prepare`.
* Verify the examples with `make verify`, or:
  * `make verify-verilog` for Verilog files.
  * `make verify-vhdl` for VHDL files.
* Run synthesis with `make <TARGET>`, where `<TARGET>` can be:
  * `yosys`: generic Yosys synthesis.
  * `yosys-ise`: Yosis synthesis with ISE as backend.
  * `yosys-vivado`: Yosis synthesis with Vivado as backend.
  * `ise-verilog`: synthesis with ISE (xst).
  * `vivado-verilog`: synthesis with Vivado.
  * `ghdl-synth`: generic GHDL synthesis.
  * `ghdl-yosys`: synthesis using the ghdl-yosys-plugin.
  * `ise-vhdl`: synthesis with ISE (xst).
  * `vivado-vhdl`: synthesis with Vivado.
* Report erros with `make report-erros` (there must be reports).
* Remove with `make clean` and `make clean-all`.
* The default operation is synthesis (`syn`) but can be changed to implementation (`imp`) using
`make TASK=imp <TARGET>`.

## Yosys remarks

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
