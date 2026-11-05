# Technical design

A combinational winner selector first seeks requesters whose age meets the configured limit; among those it chooses the oldest. Otherwise, it selects the highest two-bit priority. Ties are visited from a rotating round-robin starting point. When the service sink stalls, the selected requester is locked until the grant handshake completes. Waiting age counters saturate at 255 and reset on service or withdrawal.

## Integration profile

The arbiter selects request identity using priority class, aging promotion and round-robin tie breaking; the downstream ready/valid interface controls grant acceptance.
