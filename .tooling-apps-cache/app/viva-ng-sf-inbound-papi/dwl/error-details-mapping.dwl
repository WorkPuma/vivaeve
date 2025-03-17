%dw 2.0
output application/json
---
{
	 "code":if(payload.code == "SALESFORCE:INVALID_INPUT" or payload.code == "SALESFORCE:CONNECTIVITY") 
            "CONNECTIVITY ERROR" 
          else payload.code,
    "status":payload.status,
    "subject" : payload.description,
    "body" : payload.messages,
    "transactionID" : vars.transactionId
}