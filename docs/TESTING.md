# Test procedure

1. Install Icarus Verilog and run `make test` in the repository root.
2. Confirm a zero exit code and PASS output.
3. Install Yosys and run `make synth` to check synthesizability and inspect generic mapping statistics.
4. Match the tested commit to the CI workflow and `docs/RESULTS.md`.

Directed tests: priority selection, stable grant while sink stalls and higher-priority work arrives, age-based starvation avoidance and count accuracy.

Device timing, power, CDC and physical implementation require separate qualification.
