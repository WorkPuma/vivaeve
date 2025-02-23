%dw 2.0
output application/json
---
if (!isEmpty(payload.data.payload.ChangeEventHeader.entityName) and (!isEmpty(payload.data.payload.ChangeEventHeader.changeType))) (payload.data.payload.ChangeEventHeader.entityName ~= "Contact" and payload.data.payload.ChangeEventHeader.changeType ~= "CREATE") else "entityName and changeType values doesn't exist"