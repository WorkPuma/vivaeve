fun buildOutput(correlId, tracingId, httpStatusCode, severity, reasonCode, context, message) = 
{
	correlationId: correlId,
	tracingId: tracingId,
	status: {
		code: httpStatusCode,
		"messages": [
	      {
	        "type": "Error",
	        "severity": severity,
	        "reasonCode": reasonCode,
	        "context": context,
	        "message": message
	      }
	    ]
	}
}
