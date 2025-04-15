%dw 2.0
output application/json
var providerField = readUrl("classpath://ProviderExtract.json","application/json")
---
(providerField filter ($.NPI ~= payload.data.payload.Provider_for_Appointment__c ))[0].NPI