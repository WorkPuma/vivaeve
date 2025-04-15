%dw 2.0
output application/json
var langField = readUrl("classpath://Language_Preferred__c.json","application/json")
---
(langField filter ($.Language_Preferred__c == vars.queryData[0].Language_Preferred__c))[0].primarylanguage