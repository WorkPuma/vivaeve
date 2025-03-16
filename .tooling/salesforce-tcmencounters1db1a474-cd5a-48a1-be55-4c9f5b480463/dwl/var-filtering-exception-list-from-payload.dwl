%dw 2.0
output application/json
var entriesToRemove = vars.exceptionList
var filteredData = payload filter ((item) -> !(entriesToRemove contains item))
---
filteredData