%dw 2.0
output application/json

---
{
	correlationId : vars.correlationId,
	eventTimestamp : now(),
	applicationName: Mule::p('app.name'),
	businessProcessName: "order-transactions",
	category: "LOG",
	flowName: vars.flowName default "implementation-flows",
	environment: upper(Mule::p('mule.env')),
	source: Mule::p('app.name'),
	target: "Core",
	httpMethod: "POST",
	milestoneStatus: "SuccessResponseReceived",
	message: "Order message successfully posted to orders-papi"
}