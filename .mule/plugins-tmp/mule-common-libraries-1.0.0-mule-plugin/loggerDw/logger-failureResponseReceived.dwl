%dw 2.0
import modules::CommonUtils as util
output application/json 

---
{
	correlationId : util::getCorrelationId(vars.inputPayload.correlationId, attributes.headers['correlationId']),
	eventTimestamp : vars.inputPayload.eventTimestamp default now(),
	applicationName: p('application.name'),
	businessProcessName: vars.inputPayload.businessProcessName,
	category: p('milestone.category'),
	flowName: vars.inputPayload.flowName default "implementation-flow",
	environment: upper(p('mule.env')),
	source: util::getSource(vars.inputPayload.source, attributes.headers['source']),
	target: vars.inputPayload.target,
	httpMethod: vars.inputPayload.httpMethod default "n/a",
	milestoneStatus: vars.milestoneStatus,
	errorType: error.errorType,
	errorCause: error.cause,
	errorMessage: error.errorMessage,
	businessObject: vars.inputPayload.businessObject
}