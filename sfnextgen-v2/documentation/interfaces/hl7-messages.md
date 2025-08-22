# HL7 Message Formats

## Overview

The SFNextGen-v2 integration generates HL7 v2.3 compliant messages for communication with NextGen Office. All messages follow standard HL7 formatting with pipe (|) delimited fields and carriage return (\r) segment separators.

## Message Types

### ADT Messages (Admission, Discharge, Transfer)
- **ADT^A04**: Patient Registration
- **ADT^A08**: Patient Information Update

### SIU Messages (Scheduling Information Unsolicited)
- **SIU^S12**: New Appointment Notification
- **SIU^S14**: Appointment Modification
- **SIU^S15**: Appointment Cancellation

## Common Message Structure

### MSH Segment (Message Header)
All messages include a standard MSH segment with the following structure:

```
MSH|^~\&|SENDING_APPLICATION^SENDING_FACILITY|RECEIVING_APPLICATION^RECEIVING_FACILITY|TIMESTAMP||MESSAGE_TYPE|MESSAGE_CONTROL_ID|PROCESSING_ID|VERSION
```

**Standard Values:**
- Sending Application: `NEXTGEN OFFICE^foresthms` or `HEALTHFUSION^1266378`
- Receiving Application: `FOREST HILLS MEDICAL SERVICES^1266378` or `FORESTHMS`
- Processing ID: `P` (Production)
- Version: `2.3`

## ADT^A04 Message (Patient Registration)

### Message Structure
```
MSH|^~\&|NextGen Office^foresthms|FOREST HILLS MEDICAL SERVICES^1266378|FORESTHMS|FORESTHMS^1266378|20240115143022||ADT^A04|MSG123456|P|2.3
PID|1|123456|HF123456|HF123456|DOE^JOHN^MICHAEL||19850615|M||WHITE|123 MAIN ST^^ANYTOWN^NY^12345||5551234567^^^john.doe@email.com|||EN|SINGLE||||PATIENT DECLINED
PV1|1|O|FOREST HILLS^^^1275017^^^^^FOREST HILLS||||1275017^^^1275017^^^^^FOREST HILLS||||1275017^^^1275017^^^^^FOREST HILLS|||||||||||||||||||||||N|||||1266378;FOREST HILLS MEDICAL SERVICES;FORESTHMS
GT1|1|123456|DOE^JOHN^MICHAEL||123 MAIN ST^^ANYTOWN^NY^12345|(555)123-4567^^^john.doe@email.com||19850615000000|M||SELF|||||||||OTHER
```

### Segment Descriptions

#### PID Segment (Patient Identification)
| Field | Position | Description | Example | Required |
|-------|----------|-------------|---------|----------|
| Segment ID | PID.0 | Always "PID" | PID | Yes |
| Set ID | PID.1 | Always "1" | 1 | Yes |
| Patient ID (External) | PID.2 | Patient ID without HF prefix | 123456 | Yes |
| Patient ID (Internal) | PID.3 | Patient ID with HF prefix | HF123456 | Yes |
| Alternate Patient ID | PID.4 | Same as PID.3 | HF123456 | Yes |
| Patient Name | PID.5 | LAST^FIRST^MIDDLE | DOE^JOHN^MICHAEL | Yes |
| Mother's Maiden Name | PID.6 | Empty | | No |
| Date of Birth | PID.7 | YYYYMMDD format | 19850615 | Yes |
| Sex | PID.8 | M/F/U | M | Yes |
| Patient Alias | PID.9 | Empty | | No |
| Race | PID.10 | Patient race or "PATIENT DECLINED" | WHITE | No |
| Patient Address | PID.11 | STREET^^CITY^STATE^ZIP | 123 MAIN ST^^ANYTOWN^NY^12345 | No |
| County Code | PID.12 | Empty | | No |
| Phone Numbers | PID.13 | Complex phone/email structure | See below | No |
| Primary Language | PID.15 | Language code | EN | No |
| Marital Status | PID.16 | Marital status | SINGLE | No |
| Ethnicity | PID.22 | Ethnicity code^description | PATIENT DECLINED | No |

#### PID.13 Phone Number Structure
```
(555)123-4567^^^john.doe@email.com^^^555^1234567~(555)987-6543^^^^^555^9876543
```
- Primary phone: `(555)123-4567^^^email^^^area^number`
- Cell phone (if present): `~(555)987-6543^^^^^area^number`

#### PV1 Segment (Patient Visit)
Standard NextGen Office visit information with location and provider details.

#### GT1 Segment (Guarantor)
Patient guarantor information, typically the patient themselves for self-pay.

## ADT^A08 Message (Patient Update)

### Message Structure
Identical to ADT^A04 but with message type `ADT^A08` in the MSH segment.

## SIU^S12 Message (New Appointment)

### Message Structure
```
MSH|^~\&|HEALTHFUSION^1266378|NEXTGENOFFICE^1266378|FORESTHMS|FORESTHMS^1266378|20240115143022||SIU^S12|APT123456|P|2.3
SCH|APT123456||||||OFFICE VISIT|ROUTINE|60|MIN|^^^20240115140000^20240115150000||||1234567890^JOHNSON^SARAH||||||||||||SCHEDULED
PID|1|123456|123456|HF123456|SMITH^JANE||19900322|F||PATIENT DECLINED|456 ELM ST^^SOMEWHERE^CA^90210||5559876543^^^jane.smith@email.com|||EN|||||PATIENT DECLINED
PV1|1|O|^^^LOC001^^^^^MAIN CLINIC||||1234567890^JOHNSON^SARAH||||1275017^^^1275017^^^^^FOREST HILLS||||||||APT123456||||||||||||||||||||1266378;FOREST HILLS MEDICAL SERVICES;FORESTHMS|||||20240115140000|20240115150000
RGS|1
AIL|1||LOC001^^^MAIN CLINIC
AIP|1||1234567890^JOHNSON^SARAH
```

### Segment Descriptions

#### SCH Segment (Schedule Activity Information)
| Field | Position | Description | Example | Required |
|-------|----------|-------------|---------|----------|
| Placer Appointment ID | SCH.1 | Appointment identifier | APT123456 | Yes |
| Filler Appointment ID | SCH.2 | Empty for new appointments | | No |
| Appointment Reason | SCH.7 | Reason for appointment | OFFICE VISIT | No |
| Appointment Type | SCH.8 | Type of appointment | ROUTINE | No |
| Duration | SCH.9 | Duration value | 60 | No |
| Duration Units | SCH.10 | Always "MIN" | MIN | No |
| Timing | SCH.11 | ^^^START^END format | ^^^20240115140000^20240115150000 | Yes |
| Provider | SCH.15 | NPI^LAST^FIRST | 1234567890^JOHNSON^SARAH | Yes |
| Status | SCH.25 | Appointment status | SCHEDULED | Yes |

#### RGS Segment (Resource Group)
Simple resource group indicator, always "RGS|1"

#### AIL Segment (Appointment Information - Location)
Location information for the appointment

#### AIP Segment (Appointment Information - Personnel)
Provider information for the appointment

## SIU^S14 Message (Modify Appointment)

### Message Structure
Similar to SIU^S12 but:
- Message type is `SIU^S14`
- SCH.1 is empty
- SCH.2 contains the NextGen appointment ID

## SIU^S15 Message (Cancel Appointment)

### Message Structure
Similar to SIU^S12 but:
- Message type is `SIU^S15`
- SCH.1 is empty
- SCH.2 contains the NextGen appointment ID
- SCH.25 status reflects cancellation

## Data Transformation Rules

### Field Formatting
- **Uppercase**: All text fields converted to uppercase
- **Phone Numbers**: Formatted as (XXX)XXX-XXXX
- **Dates**: YYYYMMDD format for dates, YYYYMMDDHHMMSS for timestamps
- **Empty Fields**: Represented as empty strings between delimiters

### Default Values
- **Race**: "PATIENT DECLINED" if not provided
- **Language**: "EN" if not provided or "ENGLISH"
- **Gender**: "U" for unknown if not M or F
- **Patient ID**: "HF" prefix added if not present

### Timezone Handling
- **Appointment Times**: Converted to America/New_York timezone
- **Birth Dates**: No timezone conversion (date only)
- **Message Timestamps**: Current system time in local timezone

## Validation Rules

### Required Field Validation
- Patient identifiers must be present
- Names cannot be empty
- Appointment times must be valid dates
- Provider information must be complete

### Data Quality Checks
- Phone numbers validated for 10-digit format
- Email addresses included when available
- Address components properly formatted
- Date formats strictly enforced

## Error Handling

### Transformation Errors
- Missing required fields logged with correlation ID
- Invalid data formats captured and reported
- Fallback values applied where appropriate

### Message Validation
- HL7 structure validation before delivery
- Segment order verification
- Field delimiter consistency checks
