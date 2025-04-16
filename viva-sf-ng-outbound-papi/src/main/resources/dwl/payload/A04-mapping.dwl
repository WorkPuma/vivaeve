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
      "EVN": {
        "EVN-01": "A04",
        "EVN-02": {
          "TS-01": now() as String {format: "yyyyMMddHHmmss"}
        }
      },
      "PID": {
        "PID-01": 1,
        "PID-02": "",
        "PID-03": [
          { "CX-01": "123456" }
        ],
        "PID-04": "",
        "PID-05": [
          {
            "XPN-01": "DOE",
            "XPN-02": "JOHN"
          }
        ],
        "PID-06": "",
        "PID-07": { "TS-01": "19700101" },
        "PID-08": "F",
        "PID-09": "",
        "PID-10": "PATIENT DECLINED",
        "PID-11": [
          {
            "XAD-01": "123 MAIN ST",
            "XAD-02": "",
            "XAD-03": "ANYTOWN",
            "XAD-04": "CA",
            "XAD-05": "12345",
            "XAD-06": "",
            "XAD-07": "",
            "XAD-08": "",
            "XAD-09": "",
            "XAD-10": ""
          }
        ],
        "PID-12": "",
        "PID-13": [
          {
            "XTN-01": "555-555-5555",
            "XTN-02": "",
            "XTN-03": "",
            "XTN-04": "",
            "XTN-05": "",
            "XTN-06": "",
            "XTN-07": "",
            "XTN-08": "",
            "XTN-09": "",
            "XTN-10": ""
          }
        ],
        "PID-14": "",
        "PID-15": makeLanguageCE("EN"),
        "PID-16": "",
        "PID-17": "",
        "PID-18": "",
        "PID-19": "",
        "PID-20": "",
        "PID-21": "",
        "PID-22": "PATIENT DECLINED",
        "PID-23": "",
        "PID-24": "",
        "PID-25": "",
        "PID-26": "",
        "PID-27": "",
        "PID-28": "",
        "PID-29": "",
        "PID-30": ""
      },
      "PV1": {
        "PV1-01": 1 as Number,
        "PV1-02": "O",
      },
      "GT1": {
        "GT1-01": "",
        "GT1-02": "",
        "GT1-03": "",
        "GT1-04": "",
        "GT1-05": "",
        "GT1-06": "",
        "GT1-07": "",
        "GT1-08": "",
        "GT1-09": "",
        "GT1-10": "",
        "GT1-11": "",
        "GT1-12": "",
        "GT1-13": "",
        "GT1-14": "",
        "GT1-15": "",
        "GT1-16": "",
        "GT1-17": "",
        "GT1-18": "",
        "GT1-19": "",
        "GT1-20": ""
      },
      "IN1": {
        "IN1-01": "",
        "IN1-02": "",
        "IN1-03": "",
        "IN1-04": "",
        "IN1-05": "",
        "IN1-06": "",
        "IN1-07": "",
        "IN1-08": "",
        "IN1-09": "",
        "IN1-10": "",
        "IN1-11": "",
        "IN1-12": "",
        "IN1-13": "",
        "IN1-14": "",
        "IN1-15": "",
        "IN1-16": "",
        "IN1-17": "",
        "IN1-18": "",
        "IN1-19": "",
        "IN1-20": ""
      }
    }
  },
  "Id": "ADT_A04",
  "Name": "ADT_A04"
}