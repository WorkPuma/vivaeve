# Interface Specifications

## Overview

This section documents all interfaces used by the SFNextGen-v2 integration, including input sources, transformation processes, and output destinations.

## Interface Architecture

```
Salesforce Platform Events → MuleSoft Processing → HL7 Messages → NextGen Office
                                    ↓
                              SFTP File Transfer
                                    ↓
                              Optional API Delivery
```

## Interface Components

### 1. Input Interfaces

#### [Salesforce Platform Events](./salesforce-events.md)
- Contact__e event structure and fields
- NextGenServiceAppointment__e event structure and fields
- Pub/Sub subscription configuration
- Event filtering and routing logic

### 2. Transformation Interfaces

#### [HL7 Message Formats](./hl7-messages.md)
- ADT^A04 (Patient Registration) message structure
- ADT^A08 (Patient Update) message structure
- SIU^S12 (New Appointment) message structure
- SIU^S14 (Modify Appointment) message structure
- SIU^S15 (Cancel Appointment) message structure

### 3. Output Interfaces

#### [SFTP Configuration](./sftp-interface.md)
- Connection parameters and authentication
- File naming conventions
- Directory structure
- Transfer protocols and security

#### [NextGen Office API](./nextgen-api.md)
- API endpoint specifications
- Authentication requirements
- Request/response formats
- Error handling procedures

## Data Flow Specifications

### Message Processing Flow

1. **Event Reception**: Salesforce Pub/Sub listener receives platform events
2. **Validation**: Event structure and required fields validation
3. **Transformation**: DataWeave transformation to HL7 format
4. **File Operations**: Local file creation and SFTP upload
5. **API Delivery**: Optional NextGen API submission
6. **Error Handling**: Comprehensive error logging and recovery

### Field Mapping

Detailed field mappings between Salesforce events and HL7 messages are documented in each specific interface specification.

## Security Considerations

- All sensitive data is handled according to HIPAA requirements
- SFTP connections use secure authentication
- API communications use encrypted channels
- Audit trails maintained for all data transfers

## Compliance Standards

- **HL7 v2.3**: All HL7 messages conform to version 2.3 standards
- **HIPAA**: Healthcare data handling compliance
- **NextGen Office**: Vendor-specific requirements and formats

---

*For detailed specifications of each interface, please refer to the individual documentation files in this directory.*
