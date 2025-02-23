%dw 2.0
output application/json 

---
{
	correlationId : vars.inputPayload.correlationId,
	eventTimestamp : now(),
	applicationName: p('application.name'),
	businessProcessName: vars.inputPayload.businessProcessName,
	category: p('logger.category'),
	flowName: vars.inputPayload.flowName default "implementation-flow",
	environment: upper(p('mule.env')),
	source: vars.inputPayload.source,
	target: vars.inputPayload.target,
	httpMethod: vars.inputPayload.httpMethod default "n/a",
	milestoneStatus: p('milestone.requetReceived'),
	message: vars.inputPayload.message
}