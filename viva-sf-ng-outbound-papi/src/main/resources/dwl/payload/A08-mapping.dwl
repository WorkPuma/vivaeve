%dw 2.0
output application/json

fun defaultRace(race) =
  if (race == null or race == "") "PATIENT DECLINED" else race

fun defaultEthnicity(ethnicity) =
  if (ethnicity == null or ethnicity == "") "PATIENT DECLINED" else ethnicity

fun languageToHL7CE(language) =
  if (language == null or language == "")
    { "CE_0296-01": "EN", "CE_0296-02": "English", "CE_0296-03": "HL70296" }
  else do {
    var lang = upper(language)
    var code =
      if (lang == "ENGLISH" or lang == "EN") "EN"
      else if (lang == "SPANISH" or lang == "ES") "ES"
      else if (lang == "FRENCH" or lang == "FR") "FR"
      else if (lang == "RUSSIAN" or lang == "RU") "RU"
      else if (lang == "CHINESE" or lang == "ZH" or lang == "CHINESE/MANDARIN") "ZH"
      else if (lang == "ARABIC" or lang == "AR") "AR"
      else if (lang == "FARSI" or lang == "FA") "FA"
      else "EN"
    ---
    {
      "CE_0296-01": code,
      "CE_0296-02": language,
      "CE_0296-03": "HL70296"
    }
  }

fun formatTS(dob) =
  if (dob == null or dob == "") null else { "TS-01": (dob as Date {format:"yyyy-MM-dd"}) as String {format:"yyyyMMdd"} }

---
{
  "Data": {
    "ADT_A08": {
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
          "CM_MSG-02": "A08",
          "CM_MSG-01": "ADT"
        }
      },
      "EVN": {
        "EVN-01": "A08",
        "EVN-02": {
          "TS-01": now() as String {format: "yyyyMMddHHmmss"}
        }
      },
      "PID": {
        "PID-01": 1,
        // Only include if present in data
        "PID-03":
          if ((vars.queryData[0].Contact_Id__c default null) != null)
            [{ "CX-01": vars.queryData[0].Contact_Id__c }]
          else null,
        "PID-05":
          if ((vars.queryData[0].LastName default null) != null or (vars.queryData[0].FirstName default null) != null)
            [{
              "XPN-01": vars.queryData[0].LastName default null,
              "XPN-02": vars.queryData[0].FirstName default null
            }]
          else null,
        "PID-07":
          formatTS(vars.queryData[0].Date_of_Birth__c default null),
        "PID-08":
          if ((vars.queryData[0].Patient_Gender__c default null) != null)
            upper(vars.queryData[0].Patient_Gender__c)
          else null,
        "PID-11":
          if (
            (vars.queryData[0].MailingStreet default null) != null or
            (vars.queryData[0].MailingCity default null) != null or
            (vars.queryData[0].MailingState default null) != null or
            (vars.queryData[0].MailingPostalCode default null) != null
          )
            [{
              "XAD-01": vars.queryData[0].MailingStreet default null,
              "XAD-03": vars.queryData[0].MailingCity default null,
              "XAD-04": vars.queryData[0].MailingState default null,
              "XAD-05": vars.queryData[0].MailingPostalCode default null
            }]
          else null,
        "PID-13":
          if ((vars.queryData[0].Phone default null) != null)
            [{ "XTN-01": vars.queryData[0].Phone }]
          else null,
        // Race/Ethnicity/Language can default when missing
        "PID-10": defaultRace(vars.queryData[0].Patient_Race__c default null),
        "PID-15": languageToHL7CE(vars.queryData[0].Language_Preferred__c default null),
        "PID-22": defaultEthnicity(vars.queryData[0].Patient_Ethnicity__c default null)
        // Additional fields: only if provided by source!
      },
      "PV1": {
        "PV1-01": 1 as Number,
        "PV1-02": "O",
        "PV1-45": "N"
      }
    }
  },
  "Id": "ADT_A08",
  "Name": "ADT_A08"
}
