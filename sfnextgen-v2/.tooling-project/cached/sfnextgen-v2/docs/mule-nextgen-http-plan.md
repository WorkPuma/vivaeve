# MuleSoft – NextGen HTTP Integration Implementation & Validation Plan

## 1. Properties Configuration

**File:** `src/main/resources/config.properties`

- All required NextGen properties are defined (see below).
- Property names strictly match integration documentation.
- These enable clean referencing and future maintainability.

**Sample:**
```
nextgen.url=https://prod-ehr.prod.ngo.nextgenaws.net/messaging/mcservice
nextgen.auth=Basic aW50ZXJncmF0aW9uc2RlbW86TkdPX1BldGVyUGFu
nextgen.x-process=MULESOFT,HUB
nextgen.content-type=text/plain
nextgen.Priority=M
nextgen.Node=MC1
nextgen.accountnumber=foresthms
nextgen.x-api-key=7Bp8toQzQhzKvcsd6K7o
nextgen.username=MulesoftHUB_NGO
```

## 2. Mule Flow Configuration

**File:** `src/main/mule/sfnextgen-v2.xml`

### a. HL7 Payload Set

- The HL7 message is constructed as a single string and set as the outbound payload.
- No transformations, encoding, or wrapping are performed afterward.
- Logger captures this payload for audit.

### b. Conditional Execution

- The HTTP Request to NextGen is only made when `vars.sentToNextgen` is true.
- Otherwise, only a log action occurs.

### c. HTTP Request Connector

- POSTs HL7 to `${nextgen.url}` with timeout 60000ms.
- **Headers:**
    - All required headers are injected using Mule property expressions or as constant values:
      - Authorization: `p('nextgen.auth')`
      - x-process: `p('nextgen.x-process')`
      - Priority: `p('nextgen.Priority')`
      - Node: `p('nextgen.Node')`
      - accountnumber: `p('nextgen.accountnumber')`
      - x-api-key: `p('nextgen.x-api-key')`
      - username: `p('nextgen.username')`
      - content-type: `"text/plain"`
    - No extra/custom headers (e.g., **no Content-Length**).
- **Payload:** Raw HL7 string from the payload variable.

### d. Logging

- Logs outgoing payload and NextGen API response for traceability.

---

## 3. Validation Steps

1. **Review all HTTP requests** to NextGen within the Mule flow for conformance.
2. **Test with a real HL7 message.**
    - Confirm downstream processing.
    - Inspect NextGen’s response and verify headers and payload via logs.
3. **Negative test:** Set `vars.sentToNextgen=false` to ensure HL7 is logged but not sent.
4. **Check log outputs:** 
    - HL7 logged as plain text without alteration.
    - No JSON wrapping, encoding, or line break manipulation.
    - Headers as required.
5. **Properties:** 
    - All configuration changes must be made in `config.properties` for cleanliness and traceability.

---

## 4. Recommendations

- **Centralize and Document:** All property usage should match the keys in `config.properties`—avoid duplication or “magic” values in-flow.
- **Error Handling:** Consider extending with error handling logic based on HTTP status codes.
- **Documentation:** Maintain this plan and a flow diagram in `docs/` for onboarding and auditability.

---

## 5. Flow Diagram

```mermaid
flowchart TD
    A[Generate HL7 String (payload)] --> B[Logger: HL7 MESSAGE GENERATED]
    B --> C{sentToNextgen?}
    C -- No --> F[Logger: Not sending, payload only logged]
    C -- Yes --> D[HTTP Request to NextGen API]
    D --> E[Logger: Full NextGen Response]
```

---

### Summary Table

| Header         | Value / Source                      |
|----------------|------------------------------------|
| Authorization  | p('nextgen.auth')                  |
| x-process      | p('nextgen.x-process')             |
| Priority       | p('nextgen.Priority')              |
| Node           | p('nextgen.Node')                  |
| accountnumber  | p('nextgen.accountnumber')         |
| x-api-key      | p('nextgen.x-api-key')             |
| username       | p('nextgen.username')              |
| content-type   | "text/plain" (string literal)      |

---

**This plan ensures strict adherence to integration requirements, traceability, maintainability, and easy handoff to development or operations.**