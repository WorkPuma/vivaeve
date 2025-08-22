# Salesforce Platform Events

## Overview

The SFNextGen-v2 integration subscribes to two Salesforce platform events that trigger HL7 message generation and delivery to NextGen Office.

## Event Subscription Configuration

### Pub/Sub Configuration
- **Channel Subscription**: Real-time event processing
- **Replay Option**: Latest events only
- **Reconnection**: Automatic with 60-second frequency
- **Authentication**: OAuth User/Password flow

## Contact__e Platform Event

### Purpose
Processes patient demographic changes and triggers ADT (Admission, Discharge, Transfer) messages to NextGen Office.

### Event Structure

| Field Name | Type | Required | Description |
|------------|------|----------|-------------|
| `Event_Type__c` | String | Yes* | Message type: "A04" (Registration) or "A08" (Update) |
| `Update_Source__c` | String | Yes* | Source system identifier |
| `HealthFusion_Patient_Record_ID__c` | String | Yes* | Patient identifier in NextGen |
| `FirstName__c` | String | Yes* | Patient first name |
| `LastName__c` | String | Yes* | Patient last name |
| `MiddleName__c` | String | No | Patient middle name |
| `Date_of_Birth__c` | DateTime | Yes* | Patient date of birth |
| `Patient_Gender__c` | String | Yes* | Patient gender (M/F/U) |
| `Phone__c` | String | No | Primary phone number |
| `CellPhone__c` | String | No | Mobile phone number |
| `BusinessPhone__c` | String | No | Business phone number |
| `Email__c` | String | No | Email address |
| `MailingStreet__c` | String | No | Mailing address street |
| `MailingCity__c` | String | No | Mailing address city |
| `MailingState__c` | String | No | Mailing address state |
| `MailingPostalCode__c` | String | No | Mailing address postal code |
| `Patient_Race__c` | String | No | Patient race (defaults to "PATIENT DECLINED") |
| `Patient_Ethnicity__c` | String | No | Patient ethnicity code |
| `Patient_Ethnicity_Text__c` | String | No | Patient ethnicity description |
| `Language__c` | String | No | Preferred language (defaults to "EN") |
| `Marital_Status__c` | String | No | Marital status |

### Event Processing Logic

1. **Filtering**: Events with `Update_Source__c` = "NextGen Office" or null are skipped
2. **Validation**: Required fields are validated
3. **Routing**: Based on `Event_Type__c` value:
   - "A04" → ADT^A04 message (Patient Registration)
   - "A08" → ADT^A08 message (Patient Update)

### Sample Event Payload

```json
{
  "event": {
    "Event_Type__c": "A04",
    "Update_Source__c": "Salesforce",
    "HealthFusion_Patient_Record_ID__c": "HF123456",
    "FirstName__c": "John",
    "LastName__c": "Doe",
    "MiddleName__c": "Michael",
    "Date_of_Birth__c": "1985-06-15T00:00:00.000Z",
    "Patient_Gender__c": "M",
    "Phone__c": "5551234567",
    "Email__c": "john.doe@email.com",
    "MailingStreet__c": "123 Main St",
    "MailingCity__c": "Anytown",
    "MailingState__c": "NY",
    "MailingPostalCode__c": "12345",
    "Patient_Race__c": "WHITE",
    "Language__c": "ENGLISH"
  },
  "eventId": "e00xx0000000001AAA",
  "replayId": 12345
}
```

## NextGenServiceAppointment__e Platform Event

### Purpose
Processes appointment scheduling changes and triggers SIU (Scheduling Information Unsolicited) messages to NextGen Office.

### Event Structure

| Field Name | Type | Required | Description |
|------------|------|----------|-------------|
| `Event_Type__c` | String | Yes* | Message type: "S12" (New), "S14" (Modify), "S15" (Cancel) |
| `Update_Source__c` | String | Yes* | Source system identifier |
| `Placer_Appointment_ID__c` | String | Yes* | Appointment identifier |
| `NextGen_ID__c` | String | No | NextGen system appointment ID |
| `ContactId__c` | String | Yes* | Salesforce Contact ID |
| `HealthFusion_Patient_Record_ID__c` | String | No | Patient ID in NextGen |
| `Patient_First_Name__c` | String | Yes* | Patient first name |
| `Patient_Last_Name__c` | String | Yes* | Patient last name |
| `Patient_Middle_Name__c` | String | No | Patient middle name |
| `Patient_DOB__c` | DateTime | Yes* | Patient date of birth |
| `Patient_Gender__c` | String | Yes* | Patient gender |
| `Patient_Phone__c` | String | No | Patient phone number |
| `CellPhone__c` | String | No | Patient mobile phone |
| `Email__c` | String | No | Patient email |
| `Patient_Street__c` | String | No | Patient address street |
| `Patient_City__c` | String | No | Patient address city |
| `Patient_State__c` | String | No | Patient address state |
| `Patient_Zip__c` | String | No | Patient address zip code |
| `Patient_Race__c` | String | No | Patient race |
| `Patient_Ethnicity__c` | String | No | Patient ethnicity |
| `Patient_Language__c` | String | No | Patient language |
| `Start_DateTime__c` | DateTime | Yes* | Appointment start time |
| `End_DateTime__c` | DateTime | Yes* | Appointment end time |
| `Duration_Value__c` | Number | No | Appointment duration in minutes |
| `Appointment_Type__c` | String | No | Type of appointment |
| `Appointment_Reason__c` | String | No | Reason for appointment |
| `Appointment_Status__c` | String | Yes* | Current appointment status |
| `Provider_NPI__c` | String | Yes* | Provider NPI number |
| `Provider_First_Name__c` | String | Yes* | Provider first name |
| `Provider_Last_Name__c` | String | Yes* | Provider last name |
| `Location_ID__c` | String | No | Location identifier |
| `Location_Name__c` | String | No | Location name |

### Event Processing Logic

1. **Filtering**: Events with `Update_Source__c` = "NextGen Office" or null are skipped
2. **Validation**: Required fields are validated
3. **Routing**: Based on `Event_Type__c` value:
   - "S12" → SIU^S12 message (New Appointment)
   - "S14" → SIU^S14 message (Modify Appointment)
   - "S15" → SIU^S15 message (Cancel Appointment)

### Sample Event Payload

```json
{
  "event": {
    "Event_Type__c": "S12",
    "Update_Source__c": "Salesforce",
    "Placer_Appointment_ID__c": "APT-12345",
    "ContactId__c": "003xx000004TmiQAAS",
    "Patient_First_Name__c": "Jane",
    "Patient_Last_Name__c": "Smith",
    "Patient_DOB__c": "1990-03-22T00:00:00.000Z",
    "Patient_Gender__c": "F",
    "Start_DateTime__c": "2024-01-15T14:00:00.000Z",
    "End_DateTime__c": "2024-01-15T15:00:00.000Z",
    "Duration_Value__c": 60,
    "Appointment_Type__c": "OFFICE VISIT",
    "Appointment_Status__c": "SCHEDULED",
    "Provider_NPI__c": "1234567890",
    "Provider_First_Name__c": "Dr. Sarah",
    "Provider_Last_Name__c": "Johnson",
    "Location_ID__c": "LOC001",
    "Location_Name__c": "Main Clinic"
  },
  "eventId": "e00xx0000000002AAA",
  "replayId": 12346
}
```

## Error Handling

### Event Processing Errors
- Invalid event structure: Logged and skipped
- Missing required fields: Logged with field details
- Transformation errors: Captured with correlation ID

### Connectivity Issues
- Pub/Sub disconnection: Automatic reconnection with circuit breaker
- Authentication failures: Logged with retry mechanism
- Network timeouts: Exponential backoff retry strategy

## Monitoring and Logging

### Event Metrics
- Events processed per hour
- Event types distribution
- Processing success/failure rates
- Average processing time

### Log Entries
- Event reception with correlation ID
- Field validation results
- Transformation success/failure
- Delivery confirmation
