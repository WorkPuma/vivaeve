%dw 2.0
output application/json

fun makeLanguageCE(code) =
  if (code == null or code == "" )
    { "CE_0296-01": "EN", "CE_0296-02": "English", "CE_0296-03": "HL70296" }
  else
    { "CE_0296-01": upper(code),
      "CE_0296-02":
        if (upper(code) == "EN") "English"
        else if (upper(code) == "ES") "Spanish"
        else if (upper(code) == "FR") "French"
        else if (upper(code) == "RU") "Russian"
        else if (upper(code) == "ZH") "Chinese/Mandarin"
        else if (upper(code) == "AR") "Arabic"
        else if (upper(code) == "FA") "Farsi"
        else "Unknown",
      "CE_0296-03": "HL70296"
    }

---
{
  "Data": {
    "ADT_A04": {
      "MSH": {
        "MSH-10": uuid(),
        "MSH-11": {
          "PT-01": "P"
        },
        "MSH-12": "2.3",
        "MSH-03": {
          "HD-01": "NEXTGENOFFICE"
        },
        "MSH-04": {
          "HD-01": "NEXTGENOFFICE"
        },
        "MSH-05": {
          "HD-01": "NEXTGEN"
        },
        "MSH-06": {
          "HD-01": "NEXTGEN",
          "HD-02": "FACILITY"
        },
        "MSH-07": {
          "TS-01": now() as String {format: "yyyyMMddHHmmss"}
        },
        "MSH-09": {
          "CM_MSG-02": "A04",
          "CM_MSG-01": "ADT"
        }
      },
      "PID": {
        "PID-05": [
          {
            "XPN-01": "DOE",
            "XPN-02": "JOHN"
          }
        ],
        "PID-03": [
          {
            "CX-01": "123456"
          }
        ],
        "PID-13": [
          {
            "XTN-01": "555-555-5555"
          }
        ],
        "PID-01": 1,
        "PID-11": [
          {
            "XAD-01": "123 MAIN ST",
            "XAD-03": "ANYTOWN",
            "XAD-04": "CA",
            "XAD-05": "12345"
          }
        ],
        "PID-08": "F",
        "PID-07": {
          "TS-01": "19700101"
        },
        // TODO: When dynamic, use robust pattern for Patient_Race__c or "PATIENT DECLINED"
        "PID-10": "PATIENT DECLINED",
        // HL7 CE, dynamic in production, static for now
        "PID-15": makeLanguageCE("EN"),
        // TODO: When dynamic: "PID-22": payload.Patient_Ethnicity__c default null
        "PID-22": null
      },
      "PV1": {
        "PV1-01": "1",
        "PV1-02": "O",
        "PV1-45": "N"
      }
    }
  },
  "Id": "ADT_A04",
  "Name": "ADT_A04"
}