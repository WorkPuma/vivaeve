%dw 2.0
output application/json
var apptype = readUrl("classpath://Appointment_type_mappings.json","application/json")
var appfield =  if (payload.data.payload.AdditionalInformation?)
        (apptype filter ($.AdditionalInformation == payload.data.payload.AdditionalInformation))[0].NextGenField
       else (apptype filter ($.AdditionalInformation == vars.updateFields.AdditionalInformation[0]))[0].NextGenField

//(apptype filter ($.AdditionalInformation == payload.data.payload.AdditionalInformation))[0].AdditionalInformation
---
appfield
