# Interface summary

| Item | Meaning |
|---|---|
| `req_valid[3:0]` | Pending request from each master |
| `req_priority[7:0]` | Two-bit priority per requester; port 0 in bits 1:0 |
| `cfg_age_limit[7:0]` | Service promotion threshold; zero means one cycle |
| `grant_valid`, `grant_id[1:0]` | Selected requester, held through downstream stalls |
| `req_ready[3:0]` | One-hot acknowledgment on service acceptance |
| `grant_count` | Accepted service grants |

## Assumptions and limitations

Arbitrates request identity only; no AXI transaction payload, DDR timing, memory controller, bandwidth counters, or QoS policy registration. Fair service requires the downstream to eventually accept requests and masters to maintain stable requests while stalled.
