%dw 2.0
output application/json
---
{
	"correlationId": correlationId,
	"tracingId": vars.requestData.tracingId,
	"status": 
		{
		"code": vars.httpStatus default "404",
		"messages": 
			[
				{
					"type": "Error",
					"severity": vars.error.severity default "1",
					"reasonCode": vars.error.reasonCode default "ERR-404",
					"context": vars.error.context default app.name,
					"message": if(vars.error.description?) 
									vars.error.description 
							   else 
							   		error.description default  'Not Found'
				}
			]
		}
}