%dw 2.0
output application/java
---
/* TIP:  description property could be further customized using the error description/details from the backend system.
   To access the payload returned in an error use the following expression: error.muleMessage.typedValue. 
   Use that expression to get access to the error object and from there access the mentioned description. The property name will 
   vary depending on the backend system.
   If appropriate, the received description can be appended at the end of the description below
 */ 

{
    severity: '3',
    description: "There was a critical issue with backend system"
}