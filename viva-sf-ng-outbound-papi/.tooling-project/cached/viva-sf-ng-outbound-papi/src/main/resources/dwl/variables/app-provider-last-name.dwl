%dw 2.0
output application/json
var providerField = readUrl("classpath://ProviderExtract.json","application/json")
---
if(payload.data.payload.Service_Resource__c?)
(providerField filter ($.Provider_for_Appointment__c ~= payload.data.payload.Service_Resource__c))[0].Last_Name else
(providerField filter ($.Provider_for_Appointment__c ~= vars.updateFields.Service_Resource__c[0]))[0].Last_Name


//(providerField filter ($.Provider_for_Appointment__c ~= payload.data.payload.Service_Resource__c ))[0].Last_Name