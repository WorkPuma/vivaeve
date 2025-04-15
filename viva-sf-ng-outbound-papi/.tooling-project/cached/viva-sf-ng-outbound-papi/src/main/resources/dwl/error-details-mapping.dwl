%dw 2.0
output text/plain

var msg = {
    "status": payload.status,
    "body": (vars.errorBody) replace /\n/ with "\n",
    "Error Details": {
        "errorType": payload.code,
        "errorMessage": payload.messages
    },
    "transactionID": vars.transactionId
}
---
"status: " ++ msg.status ++ "\n" ++
"body: " ++ msg.body ++ "\n" ++
"Error Details:\n" ++
"  - Error Type: " ++ (msg.'Error Details'.errorType as String {class: "null"} default "N/A") ++ "\n" ++
"  - Error Message: " ++ (msg.'Error Details'.errorMessage as String {class: "null"} default "N/A") ++ "\n" ++
"  - Transaction ID: " ++ (msg.transactionID as String {class: "null"} default "N/A")
