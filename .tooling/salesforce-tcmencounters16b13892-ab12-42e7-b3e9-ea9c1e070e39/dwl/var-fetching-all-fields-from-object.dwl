%dw 2.0
output text/plain
var a = payload.fields.name
---
a joinBy ','
