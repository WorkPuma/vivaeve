%dw 2.0
output application/json
---
if(!isEmpty(error.errorMessage.payload) and !isEmpty(error.errorMessage.payload.errorOrigin)) 
	error.errorMessage.payload
else { 
  "messages" :  if(error.cause.errorMessage.payload.messages != null) (error.cause.errorMessage.payload.messages) else error.description,
  "errorOrigin": p('application.name'),
  "status" : "ERROR",
  "code": error.errorType.asString default error.errorMessage.attributes.statusCode,
  "description" : error.detailedDescription,
  "correlationId" : vars.correlationId default "",
  "timestamp":  now() >> "America/Chicago" as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS"},
   outputPayload:payload default ""
}