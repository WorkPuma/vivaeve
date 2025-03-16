%dw 2.0
output application/json
---
{
	"correlationId": correlationId,
	"tracingId": vars.requestData.tracingId,
	"status": 
		{
		"code": vars.httpStatus default "415",
		"messages": 
			[
				{
					"type": "Error",
					"severity": vars.error.severity default "1",
					"reasonCode": vars.error.reasonCode default "ERR-415",
					"context": vars.error.context default app.name,
					"message": if(vars.error.description?) 
									vars.error.description 
							   else 
							   		error.description default 'Unsupported Media'
				}
			]
		}
}