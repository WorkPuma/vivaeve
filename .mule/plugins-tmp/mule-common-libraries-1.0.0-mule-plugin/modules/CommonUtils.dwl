%dw 2.0

//common functions
fun setToBlankIfNull(val) =
	if (val == null) 
		""
	else 
		val
		

fun getSource(source, altSource) = 
	if (source != null) 
		source
	else
		setToBlankIfNull(altSource)
		
fun getCorrelationId(correlationId, altCorrelationId) = 
	if (correlationId != null) 
		correlationId
	else
		setToBlankIfNull(altCorrelationId)
