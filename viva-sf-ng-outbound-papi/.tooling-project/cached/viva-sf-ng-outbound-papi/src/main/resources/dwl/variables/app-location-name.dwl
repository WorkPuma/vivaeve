%dw 2.0
output application/json
var locationField = readUrl("classpath://LocationExtract.json","application/json")
---
//(locationField filter ($.Id == payload.data.payload.ServiceTerritoryId))[0].LOCATION
if(payload.data.payload.ServiceTerritoryId?)
(locationField filter ($.Id == payload.data.payload.ServiceTerritoryId))[0].LOCATION else
(locationField filter ($.Id ~= vars.updateFields.ServiceTerritoryId[0]))[0].LOCATION