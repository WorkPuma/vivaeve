%dw 2.0
output application/json

// Helper for field presence enforcement
fun requireField(val, name) =
  if (val == null or val == "")
    error("Required field " ++ name ++ " missing for UPDATE")
  else val

// Appointment/Patient ID helpers
fun getAppId() =
  vars.updateFields.NextGen_ID__c[0] default payload.data.payload.ChangeEventHeader.recordIds[0]

fun getPatientId() =
  vars.queryData[0].HealthFusion_Patient_Record_ID__c

---
{
  "Data": {
    "SIU_S15": {
      "MSH": {
        "MSH-10": vars.correlationId default "NO-CORRELATION-ID",
        "MSH-11": { "PT-01": p('mshsegment.PT-01') },
        "MSH-12": p('mshsegment.MSH-12'),
        "MSH-03": { "HD-01": p('mshsegment.MSH-03') },
        "MSH-04": { "HD-01": p('mshsegment.MSH-04') },
        "MSH-05": { "HD-01": p('mshsegment.MSH-05') },
        "MSH-06": {
          "HD-01": p('mshsegment.MSH-06-HD-01'),
          "HD-02": p('mshsegment.MSH-06-HD-02')
        },
        "MSH-07": {
          ("TS-01": payload.data.payload.LastModifiedDate)
            if ((payload.data.payload.LastModifiedDate?) and (payload.data.payload.LastModifiedDate != null))
        },
        "MSH-09": {
          "CM_MSG-02": p('mshsegment.MSH-09-MSG-02-s15'),
          "CM_MSG-01": p('mshsegment.MSH-09-MSG-01')
        }
      },
      "SCH": {
        // Placer/Filler Appointment IDs
        "SCH-01":
          if (vars.hl7MessageType == "UPDATE")
            { "EI-01": requireField(getAppId(), "Appointment ID (SCH-01)") }
          else
            if (getAppId() != null and getAppId() != "") { "EI-01": getAppId() } else null,
        "SCH-02":
          if (vars.hl7MessageType == "UPDATE")
            { "EI-01": requireField(getAppId(), "Appointment ID (SCH-02)") }
          else
            if (getAppId() != null and getAppId() != "") { "EI-01": getAppId() } else null,
        // Event Reason
        "SCH-06": {
          "CE-01":
            if (payload.data.payload.Status? and payload.data.payload.Status != null)
              (payload.data.payload.Status as String {class: "upper"} replace / / with "_")
            else
              "OTH",
          "CE-02": (payload.data.payload.Status default "Other"),
          "CE-03": "HL70306"
        },
        // Duration (number)
        ("SCH-09": vars.duration as Number)
          if ((vars.duration?) and (vars.duration != null)),
        "SCH-08": {
          ("CE_0277-01": vars.appointmentType default "Unknown")
        },
        "SCH-07": {
          ("CE_0276-01": payload.data.payload.Comments)
            if ((payload.data.payload.Comments?) and (payload.data.payload.Comments != null))
        },
        "SCH-11": [
          {
            "TQ-05": { "TS-01": (vars.scheduledEndTime as DateTime) as String {format: "yyyyMMddHHmmss"} default "99991231235959" },
            "TQ-04": { "TS-01": (vars.scheduledStartTime as DateTime) as String {format: "yyyyMMddHHmmss"} default "99991231230000" }
          }
        ],
        // Filler Contact Person (Provider)
        "SCH-16": {
          "XCN-02": (vars.providerLastName default "UNKNOWN"),
          "XCN-03": (vars.providerFirstName default "UNKNOWN"),
          "XCN-01": (vars.providerId as String default "0000000000")
        },
        // Entered By Person (Committing User)
        "SCH-20": {
          "XCN-02": "Salesforce",
          "XCN-03": "Salesforce",
          "XCN-01": "Salesforce"
        },
        // Appointment Reason/Cancel/NoShow, always non-null
        "SCH-25": {
          "CE_0278-01":
            if ((payload.data.payload.Status? and payload.data.payload.Status != null) and
                (payload.data.payload.Status == "Cancelled by Patient" or
                 payload.data.payload.Status == "Cancelled by Provider"))
              "Cancelled"
            else if (payload.data.payload.Status == "No Show")
              "No Show"
            else
              "Unknown"
        }
      },
      "PATIENT": [
        {
          "PID": {
            "PID-05":
              if (vars.queryData[0].LastName? and vars.queryData[0].LastName != null)
                [{
                    "XPN-02": vars.queryData[0].FirstName replace /[^a-zA-Z]/ with "",
                    // Middle name omitted unless required
                    "XPN-01": vars.queryData[0].LastName replace /[^a-zA-Z]/ with ""
                }]
              else
                [],
            "PID-04": [
              { "CX-01": (payload.data.payload.ContactId default "000000") }
            ],
            "PID-15": { "CE_0296-01": (vars.languageField default "EN") },
            "PID-03":
              if (vars.hl7MessageType == "UPDATE")
                [ { "CX-01": requireField(getPatientId(), "Patient ID (PID-03)") } ]
              else if (getPatientId() != null and getPatientId() != "")
                [ { "CX-01": getPatientId() } ]
              else
                [], // Omit the PID-03 if no key for CREATE
            "PID-13": [
              {
                "XTN-04": (vars.queryData[0].Email default "noemail@yourdomain.com"),
                "XTN-01": (vars.queryData[0].Phone default "000-000-0000")
              }
            ],
            "PID-01": 1,
            "PID-12": "+1",
            "PID-11": [
              {
                "XAD-05": (vars.queryData[0].MailingPostalCode default "00000"),
                "XAD-04": (vars.queryData[0].MailingState default "XX"),
                "XAD-06": (vars.queryData[0].MailingCountry default "USA"),
                "XAD-03": (vars.queryData[0].MailingCity default "UNKNOWN"),
                "XAD-01": (vars.queryData[0].MailingStreet default "UNKNOWN")
              }
            ],
            "PID-22": (vars.queryData[0].Patient_Ethnicity__c default "PATIENT DECLINED"),
            "PID-10": (vars.queryData[0].Patient_Race__c default "PATIENT DECLINED"),
            "PID-08":
              if ((vars.queryData[0].Patient_Gender_2__c?) and (vars.queryData[0].Patient_Gender_2__c != null))
                if (vars.queryData[0].Patient_Gender_2__c == "Female") "F"
                else if (vars.queryData[0].Patient_Gender_2__c == "Male") "M"
                else vars.queryData[0].Patient_Gender_2__c
              else "U",   // U for Unknown/Unspecified
            "PID-07": {
              "TS-01":
                if ((vars.queryData[0].Date_of_Birth__c?) and (vars.queryData[0].Date_of_Birth__c != null))
                  (vars.queryData[0].Date_of_Birth__c as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"})
                else
                  "19000101"
            }
          }
        }
      ],
      "PV1": {
        "PV1-01": 1,
        "PV1-02": "O",
        "PV1-03": "^^^" ++ (vars.appLocationId as String default "UNKNOWN") ++ "^^^^^" ++ (vars.appLocationName default "UNKNOWN"),
        "PV1-07": (vars.providerId as String default "0000000000") ++ "^" ++ (vars.providerLastName default "UNKNOWN") ++ "^" ++ (vars.providerFirstName default "UNKNOWN"),
        "PV1-19": getAppId() default "",
        "PV1-44": (vars.scheduledStartTime as DateTime) as String {format: "yyyyMMddHHmmss"},
        "PV1-45": (vars.scheduledEndTime as DateTime) as String {format: "yyyyMMddHHmmss"}
      },
      "RESOURCES": [
        {
          "RGS": { "RGS-01": 1 },
          "LOCATION_RESOURCE": [
            {
              "AIL": {
                "AIL-01": 1,
                "AIL-03": {
                  ("PL-01": vars.appLocationId as String default "UNKNOWN")
                    if ((vars.appLocationId?) and (vars.appLocationId != null)),
                  "PL-04": { ("HD-01": vars.appLocation default "UNKNOWN") }
                }
              }
            }
          ],
          "PERSONNEL_RESOURCE": [
            {
              "AIP": {
                "AIP-01": 1,
                "AIP-03": {
                  ("XCN-02": vars.providerLastName default "UNKNOWN"),
                  ("XCN-03": vars.providerFirstName default "UNKNOWN"),
                  ("XCN-01": vars.providerId as String default "0000000000")
                },
                "AIP-04": {
                  "CE-01": "DOCTOR",
                  "CE-02": "Doctor"
                }
              }
            }
          ]
        }
      ],
      "NTE": [
        {
          "NTE-03": [
            (payload.data.payload.CancellationReason)
              if ((payload.data.payload.CancellationReason?) and (payload.data.payload.CancellationReason != null))
          ]
        }
      ]
    }
  },
  "Id": "SIU_S15",
  "Name": "SIU_S15"
}