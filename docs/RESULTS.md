# Verification record

Date: 05 November 2026
Source revision tested: `00654775f5bd119a5403abc38807d80bab4671d4`
Hosted verification: https://github.com/vrctsssundaram/Project-Repo-16/actions/runs/41901746863

| Measurement | Recorded result |
|---|---|
| SystemVerilog compilation | **PASS** (Icarus Verilog, `-g2012 -Wall`) |
| Directed self-checking simulation | **PASS** (exit code 0) |
| Directed checks | priority selection, stable grant while sink stalls and higher-priority work arrives, age-based starvation avoidance and count accuracy |
| Generic Yosys synthesis | **PASS**; 1,174 technology-independent cells |
| FPGA/ASIC mapped utilization | Not measured |
| Static timing, maximum clock, power | Not measured |
| Physical hardware throughput | Not measured |

The generic cell count is from the hosted Yosys top-module statistics, not device-specific resource utilization. The tests exercise directed bounded cases; they are not exhaustive, formal, or silicon-level verification.
