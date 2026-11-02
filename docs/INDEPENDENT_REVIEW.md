# Independent technical review and improvement plan

## What was verified in this environment

- `make test`: 12/12 unit tests passed (2026-11-02).
- Tests exercise AES-GCM, tamper detection, TCP/IPv4 round-trip, replay handling, FFDHE2048 handshake, and configuration validation.
- This is **not** proof of end-to-end correctness: privileged Linux namespace integration and physical inline routing were not run here.

## Important issues to resolve before submission

1. **Originality:** This folder is based on another student's work. Do not submit it unchanged or claim authorship of code you did not write. Reimplement or meaningfully extend the parts you understand, with attribution according to course rules.
2. **Assignment alignment:** Obtain the exact network assignment PDF/rubric and check topology, allowed libraries, mandatory screenshots, naming, and whether PSK authentication is allowed.
3. **Security configuration:** Both sample config files contain the same public demo PSK. Generate a fresh 256-bit secret for each demonstration; do not commit or distribute the real secret.
4. **End-to-end evidence:** Run `sudo ./tests/test_integration.sh` on a suitable Linux VM and capture logs, packet traces, and the command exit status. Do not state this test passed unless actually observed.
5. **Environment:** Full daemon compilation requires OpenSSL 3 and libnetfilter_queue development headers, plus nftables and root/network namespace privileges for integration.
6. **Network limitations:** Packet expansion by a 16-byte tag affects MTU; fragments are unsupported; implicit counters tolerate only bounded reordering; TCP/IP headers remain visible; no automatic rekey.
7. **Threat model:** A strong PSK is needed to authenticate the handshake. Without it, ephemeral DH alone does not stop an active man-in-the-middle.

## Suggested original enhancements

- Add reproducible pcap evidence with clearly marked encrypted and restored packets.
- Add negative end-to-end tests: incorrect PSK, altered tag, loss/reordering, and daemon crash with fail-closed firewall behavior.
- Measure throughput and latency overhead versus unprotected TCP and discuss the experimental conditions.
- Draw a topology with actual interface names, addresses, routing tables, and nftables rule placement.
- Explain nonce construction and why packet retransmission must use a fresh counter.

## Suggested oral defense questions

1. Why is AES-GCM preferable to encryption without authentication?
2. Why must the 96-bit nonce never repeat under one key?
3. What is the purpose of the PSK in the Diffie-Hellman handshake?
4. Why are IP and TCP checksums recalculated after encryption?
5. Why can an inline link fail when the MTU is too small?
6. What happens if packets arrive out of order or a captured packet is replayed?

## Submission evidence table

| Evidence | Current status |
|---|---|
| Unit tests | PASS: 12/12 locally |
| Linux namespace integration | NOT RUN here |
| Full daemon build with real NFQUEUE | NOT VERIFIED here |
| Sanitizer execution | NOT VERIFIED here |
| Traffic capture proving plaintext absent on protected hop | NOT VERIFIED here |
| Instructor rubric conformity | UNKNOWN until rubric is supplied |
