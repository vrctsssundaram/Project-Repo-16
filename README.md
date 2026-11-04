# MemQoS-Arbiter4

Four-requester memory-service arbiter with priority and starvation-aging control.

## Features

- Per-requester two-bit priority class
- Eight-bit waiting-age threshold that promotes long-waiting requests
- Round-robin tie breaking and held selection under downstream stall
- Grant-valid/ready control and 32-bit accepted-grant counter

## Verification

Run `make test` and `make synth`. Interface, design, test procedure and measurements appear under `docs/`.

This is an independently testable RTL control primitive with an explicit scope boundary; device qualification is separate.

Project owner: Sundaram S S.
