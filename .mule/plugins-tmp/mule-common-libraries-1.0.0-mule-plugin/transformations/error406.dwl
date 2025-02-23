%dw 2.0
output application/json
---
if(!isEmpty(error.errorMessage.payload) and !isEmpty(error.errorMessage.payload.errorOrigin)) 
	error.errorMessage.payload
else { 
  "errorOrigin": p('application.name'),
  "status" : "ERROR",
  "code" : error.errorType.identifier default "406",
  "message" :  error.description,
  "description" : error.detailedDescription,
  "correlationId" : vars.correlationId default "",
  "timestamp": now() as DateTime
}