%dw 2.0
import modules::CommonUtils as util
output application/json 
fun getFilteringPayload(payload) = if ((not isEmpty(payload)) and contains(typeOf(payload), "Object")) payload
						else if ((not isEmpty(payload)) and contains(typeOf(payload), "Array"))  { "list": payload }
						else if ((not isEmpty(payload)) and contains(typeOf(payload), "String")) { "stringPayload": payload }
						else if ((not isEmpty(payload)) and contains(typeOf(payload), "Boolean")) { "booleanPayload": payload }
						else if ((not isEmpty(payload)) and contains(typeOf(payload), "Number")) { "numberPayload": payload }
						else { "defaultPayload": payload default "" }
---
{
	correlationId : util::getCorrelationId(vars.inputPayload.correlationId, attributes.headers['correlationId']),
	eventTimestamp : now(),
	applicationName: p('application.name'),
	businessProcessName: vars.inputPayload.businessProcessName,
	category: p('milestone.category'),
	flowName: vars.inputPayload.flowName default "implementation-flow",
	environment: upper(p('mule.env')),
	source: util::getSource(vars.inputPayload.source, attributes.headers['source']),
	target: vars.inputPayload.target,
	httpMethod: vars.inputPayload.httpMethod default "n/a",
	milestoneStatus: p('milestone.filterCriteriaFailed'),
	message: vars.inputPayload.message,
	filtering: getFilteringPayload(vars.inputPayload.filtering),
	businessObject: vars.inputPayload.businessObject
	
}