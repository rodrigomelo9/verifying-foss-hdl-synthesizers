# Yosys vs FPGA Design Elements (online book)

Here, verilog examples of this online book are downloaded and synthesized/implemented with
Yosys/Vivado.

## Instructions

* Prepare the examples with `make` or `make prepare`.
* Verify the examples with `make verify`, or:
  * `make iverilog`.
  * `make verilator`.
* Run synthesis with `make <TARGET>`, where `<TARGET>` can be:
  * `yosys-vivado`: Yosis synthesis with Vivado as backend.
  * `ise`: synthesis with ISE (xst).
  * `vivado`: synthesis with Vivado.
  * `quartus`: synthesis with Quartus.
* Report erros with `make report-erros` (there must be reports).
* Remove with `make clean` and `make clean-all`.
* The default operation is implementation (`imp`) but can be changed to synthesis (`syn`) using
`make TASK=syn <TARGET>`.
