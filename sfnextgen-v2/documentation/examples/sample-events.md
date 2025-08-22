# Sample Platform Events and HL7 Messages

## Overview

This document provides sample Salesforce platform events and their corresponding HL7 message outputs for testing and validation purposes.

## Contact__e Platform Event Samples

### Sample 1: Patient Registration (A04)

#### Input: Salesforce Contact__e Event
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
    "CellPhone__c": "5559876543",
    "Email__c": "john.doe@email.com",
    "MailingStreet__c": "123 Main Street",
    "MailingCity__c": "Anytown",
    "MailingState__c": "NY",
    "MailingPostalCode__c": "12345",
    "Patient_Race__c": "WHITE",
    "Patient_Ethnicity__c": "NOT HISPANIC",
    "Language__c": "ENGLISH",
    "Marital_Status__c": "SINGLE"
  },
  "eventId": "e00xx0000000001AAA",
  "replayId": 12345
}
```

#### Output: ADT^A04 HL7 Message
```
MSH|^~\&|NEXTGEN OFFICE^FORESTHMS|FOREST HILLS MEDICAL SERVICES^1266378|FORESTHMS|FORESTHMS^1266378|20240115143022||ADT^A04|a1b2c3d4-e5f6-7890-abcd-ef1234567890|P|2.3
PID|1|123456|HF123456|HF123456|DOE^JOHN^MICHAEL||19850615|M||WHITE|123 MAIN STREET^^ANYTOWN^NY^12345||(555)123-4567^^^JOHN.DOE@EMAIL.COM^^^555^1234567~(555)987-6543^^^^^555^9876543||EN|SINGLE||||NOT HISPANIC
PV1|1|O|FOREST HILLS^^^1275017^^^^^FOREST HILLS||||1275017^^^1275017^^^^^FOREST HILLS||||1275017^^^1275017^^^^^FOREST HILLS|||||||||||||||||||||||N|||||1266378;FOREST HILLS MEDICAL SERVICES;FORESTHMS
GT1|1|123456|DOE^JOHN^MICHAEL||123 MAIN STREET^^ANYTOWN^NY^12345|(555)123-4567^^^JOHN.DOE@EMAIL.COM||19850615000000|M||SELF|||||||||OTHER
```

### Sample 2: Patient Update (A08)

#### Input: Salesforce Contact__e Event
```json
{
  "event": {
    "Event_Type__c": "A08",
    "Update_Source__c": "Salesforce",
    "HealthFusion_Patient_Record_ID__c": "HF789012",
    "FirstName__c": "Jane",
    "LastName__c": "Smith",
    "Date_of_Birth__c": "1990-03-22T00:00:00.000Z",
    "Patient_Gender__c": "F",
    "Phone__c": "5555551234",
    "Email__c": "jane.smith@email.com",
    "MailingStreet__c": "456 Oak Avenue",
    "MailingCity__c": "Springfield",
    "MailingState__c": "CA",
    "MailingPostalCode__c": "90210",
    "Patient_Race__c": "ASIAN",
    "Language__c": "ENGLISH",
    "Marital_Status__c": "MARRIED"
  },
  "eventId": "e00xx0000000002AAA",
  "replayId": 12346
}
```

#### Output: ADT^A08 HL7 Message
```
MSH|^~\&|NEXTGEN OFFICE^FORESTHMS|FOREST HILLS MEDICAL SERVICES^1266378|FORESTHMS|FORESTHMS^1266378|20240115143522||ADT^A08|b2c3d4e5-f6g7-8901-bcde-f23456789012|P|2.3
PID|1|789012|HF789012|HF789012|SMITH^JANE^||19900322|F||ASIAN|456 OAK AVENUE^^SPRINGFIELD^CA^90210||(555)555-1234^^^JANE.SMITH@EMAIL.COM^^^555^5551234||EN|MARRIED||||PATIENT DECLINED
PV1|1|O|FOREST HILLS^^^1275017^^^^^FOREST HILLS||||1275017^^^1275017^^^^^FOREST HILLS||||1275017^^^1275017^^^^^FOREST HILLS|||||||||||||||||||||||N|||||1266378;FOREST HILLS MEDICAL SERVICES;FORESTHMS
GT1|1|789012|SMITH^JANE^||456 OAK AVENUE^^SPRINGFIELD^CA^90210|(555)555-1234^^^JANE.SMITH@EMAIL.COM||19900322000000|F||SELF|||||||||OTHER
```

## NextGenServiceAppointment__e Platform Event Samples

### Sample 1: New Appointment (S12)

#### Input: Salesforce NextGenServiceAppointment__e Event
```json
{
  "event": {
    "Event_Type__c": "S12",
    "Update_Source__c": "Salesforce",
    "Placer_Appointment_ID__c": "APT-12345",
    "ContactId__c": "003xx000004TmiQAAS",
    "HealthFusion_Patient_Record_ID__c": "HF123456",
    "Patient_First_Name__c": "John",
    "Patient_Last_Name__c": "Doe",
    "Patient_Middle_Name__c": "Michael",
    "Patient_DOB__c": "1985-06-15T00:00:00.000Z",
    "Patient_Gender__c": "M",
    "Patient_Phone__c": "5551234567",
    "Email__c": "john.doe@email.com",
    "Patient_Street__c": "123 Main Street",
    "Patient_City__c": "Anytown",
    "Patient_State__c": "NY",
    "Patient_Zip__c": "12345",
    "Patient_Race__c": "WHITE",
    "Patient_Language__c": "ENGLISH",
    "Start_DateTime__c": "2024-01-15T14:00:00.000Z",
    "End_DateTime__c": "2024-01-15T15:00:00.000Z",
    "Duration_Value__c": 60,
    "Appointment_Type__c": "OFFICE VISIT",
    "Appointment_Reason__c": "ROUTINE CHECKUP",
    "Appointment_Status__c": "SCHEDULED",
    "Provider_NPI__c": "1234567890",
    "Provider_First_Name__c": "SARAH",
    "Provider_Last_Name__c": "JOHNSON",
    "Location_ID__c": "LOC001",
    "Location_Name__c": "MAIN CLINIC"
  },
  "eventId": "e00xx0000000003AAA",
  "replayId": 12347
}
```

#### Output: SIU^S12 HL7 Message
```
MSH|^~\&|HEALTHFUSION^1266378|NEXTGENOFFICE^1266378|FORESTHMS|FORESTHMS^1266378|20240115143022||SIU^S12|APT-12345|P|2.3
SCH|APT-12345||||||ROUTINE CHECKUP|OFFICE VISIT|60|MIN|^^^20240115140000^20240115150000||||1234567890^JOHNSON^SARAH||||||||||||SCHEDULED
PID|1|123456|123456|HF123456|DOE^JOHN^MICHAEL||19850615|M||WHITE|123 MAIN STREET^^ANYTOWN^NY^12345||(555)123-4567^^^JOHN.DOE@EMAIL.COM^^^555^1234567||EN|||||PATIENT DECLINED
PV1|1|O|^^^LOC001^^^^^MAIN CLINIC||||1234567890^JOHNSON^SARAH||||1275017^^^1275017^^^^^FOREST HILLS||||||||APT-12345||||||||||||||||||||1266378;FOREST HILLS MEDICAL SERVICES;FORESTHMS|||||20240115140000|20240115150000
RGS|1
AIL|1||LOC001^^^MAIN CLINIC
AIP|1||1234567890^JOHNSON^SARAH
```

### Sample 2: Appointment Modification (S14)

#### Input: Salesforce NextGenServiceAppointment__e Event
```json
{
  "event": {
    "Event_Type__c": "S14",
    "Update_Source__c": "Salesforce",
    "Placer_Appointment_ID__c": "APT-12345",
    "NextGen_ID__c": "NGO-67890",
    "ContactId__c": "003xx000004TmiQAAS",
    "Patient_First_Name__c": "John",
    "Patient_Last_Name__c": "Doe",
    "Patient_DOB__c": "1985-06-15T00:00:00.000Z",
    "Patient_Gender__c": "M",
    "Start_DateTime__c": "2024-01-15T15:00:00.000Z",
    "End_DateTime__c": "2024-01-15T16:00:00.000Z",
    "Duration_Value__c": 60,
    "Appointment_Type__c": "OFFICE VISIT",
    "Appointment_Reason__c": "FOLLOW UP",
    "Appointment_Status__c": "RESCHEDULED",
    "Provider_NPI__c": "1234567890",
    "Provider_First_Name__c": "SARAH",
    "Provider_Last_Name__c": "JOHNSON",
    "Location_ID__c": "LOC001",
    "Location_Name__c": "MAIN CLINIC"
  },
  "eventId": "e00xx0000000004AAA",
  "replayId": 12348
}
```

#### Output: SIU^S14 HL7 Message
```
MSH|^~\&|HEALTHFUSION^1266378|NEXTGENOFFICE^1266378|FORESTHMS|FORESTHMS^1266378|20240115144022||SIU^S14|NGO-67890|P|2.3
SCH||NGO-67890|||||FOLLOW UP|OFFICE VISIT|60|MIN|^^^20240115150000^20240115160000||||1234567890^JOHNSON^SARAH||||||||||||RESCHEDULED
PID|1|123456|123456|HF123456|DOE^JOHN^||19850615|M||PATIENT DECLINED|^^|||^^^|||EN|||||PATIENT DECLINED
PV1|1|O|^^^LOC001^^^^^MAIN CLINIC||||1234567890^JOHNSON^SARAH||||1275017^^^1275017^^^^^FOREST HILLS||||||||NGO-67890||||||||||||||||||||1266378;FOREST HILLS MEDICAL SERVICES;FORESTHMS|||||20240115150000|20240115160000
RGS|1
AIL|1||LOC001^^^MAIN CLINIC
AIP|1||1234567890^JOHNSON^SARAH
```

### Sample 3: Appointment Cancellation (S15)

#### Input: Salesforce NextGenServiceAppointment__e Event
```json
{
  "event": {
    "Event_Type__c": "S15",
    "Update_Source__c": "Salesforce",
    "NextGen_ID__c": "NGO-67890",
    "ContactId__c": "003xx000004TmiQAAS",
    "Patient_First_Name__c": "John",
    "Patient_Last_Name__c": "Doe",
    "Patient_DOB__c": "1985-06-15T00:00:00.000Z",
    "Patient_Gender__c": "M",
    "Appointment_Status__c": "CANCELLED",
    "Provider_NPI__c": "1234567890",
    "Provider_First_Name__c": "SARAH",
    "Provider_Last_Name__c": "JOHNSON"
  },
  "eventId": "e00xx0000000005AAA",
  "replayId": 12349
}
```

#### Output: SIU^S15 HL7 Message
```
MSH|^~\&|HEALTHFUSION^1266378|NEXTGENOFFICE^1266378|FORESTHMS|FORESTHMS^1266378|20240115145022||SIU^S15|NGO-67890|P|2.3
SCH||NGO-67890|||||||||^^^|||||||||||||||||CANCELLED
PID|1|123456|123456|HF123456|DOE^JOHN^||19850615|M||PATIENT DECLINED|^^|||^^^|||EN|||||PATIENT DECLINED
PV1|1|O|^^^^^^||||1234567890^JOHNSON^SARAH||||1275017^^^1275017^^^^^FOREST HILLS||||||||NGO-67890||||||||||||||||||||1266378;FOREST HILLS MEDICAL SERVICES;FORESTHMS|||||
RGS|1
AIL|1||^^^
AIP|1||1234567890^JOHNSON^SARAH
```

## Testing Scenarios

### Scenario 1: Complete Patient Registration Flow
1. Send Contact__e event with Event_Type__c = "A04"
2. Verify ADT^A04 message generation
3. Confirm SFTP file upload
4. Validate NextGen API delivery (if enabled)

### Scenario 2: Patient Information Update
1. Send Contact__e event with Event_Type__c = "A08"
2. Verify ADT^A08 message generation
3. Confirm updated information in HL7 message

### Scenario 3: Appointment Lifecycle
1. Send NextGenServiceAppointment__e with Event_Type__c = "S12" (New)
2. Send NextGenServiceAppointment__e with Event_Type__c = "S14" (Modify)
3. Send NextGenServiceAppointment__e with Event_Type__c = "S15" (Cancel)
4. Verify appropriate SIU messages generated for each step

### Scenario 4: Error Handling
1. Send event with missing required fields
2. Verify error logging and handling
3. Confirm no invalid messages are sent to NextGen

## File Naming Examples

### ADT Files
- `ADT04_a1b2c3d4-e5f6-7890-abcd-ef1234567890.hl7`
- `ADT08_b2c3d4e5-f6g7-8901-bcde-f23456789012.hl7`

### SIU Files
- `SIU12_c3d4e5f6-g7h8-9012-cdef-345678901234.hl7`
- `SIU14_d4e5f6g7-h8i9-0123-defg-456789012345.hl7`
- `SIU15_e5f6g7h8-i9j0-1234-efgh-567890123456.hl7`
