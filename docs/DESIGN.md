# Technical design

A combinational winner selector first seeks requesters whose age meets the configured limit; among those it chooses the oldest. Otherwise, it selects the highest two-bit priority. Ties are visited from a rotating round-robin starting point. When the service sink stalls, the selected requester is locked until the grant handshake completes. Waiting age counters saturate at 255 and reset on service or withdrawal.

## Scope boundary

Arbitrates request identity only; no AXI transaction payload, DDR timing, memory controller, bandwidth counters, or QoS policy registration. Fair service requires the downstream to eventually accept requests and masters to maintain stable requests while stalled.
