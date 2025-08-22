# NextGen Office API Interface

## Overview

The SFNextGen-v2 integration optionally delivers HL7 messages directly to the NextGen Office API endpoint in addition to SFTP file transfer. This provides real-time message delivery when enabled.

## API Configuration

### Endpoint Details
- **Base URL**: `https://prod-ehr.prod.ngo.nextgenaws.net/messaging/mcservice`
- **Protocol**: HTTPS
- **Method**: POST
- **Content Type**: `text/plain; charset=UTF-8`

### Authentication
- **Type**: Basic Authentication
- **Credentials**: Base64 encoded username:password
- **Header**: `Authorization: Basic aW50ZXJncmF0aW9uc2RlbW86TkdPX1BldGVyUGFu`

### Required Headers
| Header | Value | Description |
|--------|-------|-------------|
| Authorization | Basic [credentials] | Authentication token |
| Content-Type | text/plain; charset=UTF-8 | Content format |
| X-Process | MULESOFT,HUB | Processing identifier |
| Priority | M | Message priority (Medium) |
| Node | MC1 | Target node identifier |
| X-API-Key | 7Bp8toQzQhzKvcsd6K7o | API access key |

### Account Information
- **Account Number**: foresthms
- **Username**: MulesoftHUB_NGO
- **Organization**: Forest Hills Medical Services

## API Enable/Disable Control

### Configuration Switch
The API delivery is controlled by the `sent.to.nextgen` property:
- **Value**: `true` (enabled) / `false` (disabled)
- **Location**: `config.properties`
- **Default**: `true`

### Conditional Logic
```
IF sent.to.nextgen = true THEN
    Send HL7 message to NextGen API
ELSE
    Log message but do not send to API
END IF
```

## Request Format

### HTTP Request Structure
```http
POST /messaging/mcservice HTTP/1.1
Host: prod-ehr.prod.ngo.nextgenaws.net
Authorization: Basic aW50ZXJncmF0aW9uc2RlbW86TkdPX1BldGVyUGFu
Content-Type: text/plain; charset=UTF-8
X-Process: MULESOFT,HUB
Priority: M
Node: MC1
X-API-Key: 7Bp8toQzQhzKvcsd6K7o

MSH|^~\&|NextGen Office^foresthms|FOREST HILLS MEDICAL SERVICES^1266378|FORESTHMS|FORESTHMS^1266378|20240115143022||ADT^A04|MSG123456|P|2.3
PID|1|123456|HF123456|HF123456|DOE^JOHN^MICHAEL||19850615|M||WHITE|123 MAIN ST^^ANYTOWN^NY^12345||5551234567^^^john.doe@email.com|||EN|SINGLE||||PATIENT DECLINED
PV1|1|O|FOREST HILLS^^^1275017^^^^^FOREST HILLS||||1275017^^^1275017^^^^^FOREST HILLS||||1275017^^^1275017^^^^^FOREST HILLS|||||||||||||||||||||||N|||||1266378;FOREST HILLS MEDICAL SERVICES;FORESTHMS
GT1|1|123456|DOE^JOHN^MICHAEL||123 MAIN ST^^ANYTOWN^NY^12345|(555)123-4567^^^john.doe@email.com||19850615000000|M||SELF|||||||||OTHER
```

### Message Body Preparation
Before sending to the API, HL7 messages undergo line ending normalization:
1. **Trim**: Remove leading/trailing whitespace
2. **Normalize**: Replace `\r\n` with `\r`
3. **Standardize**: Replace `\n` with `\r`
4. **Result**: Pure HL7 with carriage return separators

## Response Handling

### Expected Response Codes
| Code | Status | Description | Action |
|------|--------|-------------|--------|
| 200 | OK | Message accepted successfully | Log success |
| 400 | Bad Request | Invalid message format | Log error, investigate |
| 401 | Unauthorized | Authentication failure | Check credentials |
| 403 | Forbidden | Access denied | Verify permissions |
| 500 | Internal Server Error | NextGen system error | Retry with backoff |
| 503 | Service Unavailable | System maintenance | Retry later |

### Response Processing
- **Success (2xx)**: Log successful delivery with correlation ID
- **Client Error (4xx)**: Log error, do not retry
- **Server Error (5xx)**: Log error, implement retry logic

## Retry Logic

### Retry Configuration
- **Max Retries**: 3 attempts
- **Retry Delay**: 1000ms between attempts
- **Retry Pattern**: Fixed interval
- **Timeout**: 30 seconds per request

### Retry Conditions
- **Network Timeouts**: Retry up to max attempts
- **Server Errors (5xx)**: Retry with exponential backoff
- **Client Errors (4xx)**: Do not retry (log and alert)

### Retry Implementation
```
FOR attempt = 1 TO 3 DO
    TRY
        Send HTTP request to NextGen API
        IF response.status = 2xx THEN
            Log success and exit
        ELSE IF response.status = 5xx THEN
            Wait 1000ms * attempt
            Continue to next attempt
        ELSE
            Log error and exit (no retry)
        END IF
    CATCH network_error
        Wait 1000ms * attempt
        Continue to next attempt
    END TRY
END FOR
```

## Error Handling

### Connection Errors
- **DNS Resolution**: Log error and retry
- **Connection Timeout**: Retry with backoff
- **SSL/TLS Errors**: Log error and alert

### HTTP Errors
- **Authentication (401)**: Check credentials, alert administrators
- **Authorization (403)**: Verify API permissions
- **Rate Limiting (429)**: Implement backoff strategy
- **Server Errors (5xx)**: Retry with exponential backoff

### Message Errors
- **Invalid HL7 Format**: Log error with message details
- **Missing Required Fields**: Log validation errors
- **Encoding Issues**: Check character encoding

## Monitoring and Logging

### API Metrics
- **Success Rate**: Percentage of successful API calls
- **Response Time**: Average API response time
- **Error Rate**: Frequency and types of errors
- **Throughput**: Messages per hour/day

### Log Entries
```
INFO: NextGen Outbound: Sending HL7 message to NextGen API, switch is ON (correlationId: 12345)
INFO: HL7 body to NextGen: [HL7 message content]
ERROR: NextGen API Error: HTTP 500 - Internal Server Error (correlationId: 12345)
INFO: NextGen API Success: Message delivered successfully (correlationId: 12345)
```

### Performance Monitoring
- **Response Time Alerts**: Alert if response time >5 seconds
- **Error Rate Alerts**: Alert if error rate >5%
- **Availability Monitoring**: Monitor API endpoint availability

## Security Considerations

### Data Protection
- **HTTPS**: All communications encrypted in transit
- **Authentication**: Secure credential management
- **API Keys**: Rotated regularly per security policy

### Compliance
- **HIPAA**: Healthcare data protection standards
- **Audit Trail**: All API calls logged with timestamps
- **Access Control**: Limited to authorized systems

### Credential Management
- **Storage**: Credentials stored in secure configuration
- **Rotation**: Regular password and API key rotation
- **Access**: Limited to necessary personnel only

## Testing and Validation

### Test Scenarios
1. **Successful Message Delivery**: Verify 200 response
2. **Authentication Failure**: Test with invalid credentials
3. **Network Timeout**: Test with network delays
4. **Server Error**: Test error handling and retry logic
5. **Invalid Message**: Test with malformed HL7

### Validation Checklist
- [ ] API endpoint accessibility
- [ ] Authentication credentials valid
- [ ] Required headers included
- [ ] Message format compliance
- [ ] Error handling functional
- [ ] Retry logic operational
- [ ] Logging comprehensive

## Troubleshooting

### Common Issues

#### Authentication Failures
- **Symptom**: HTTP 401 responses
- **Cause**: Invalid or expired credentials
- **Resolution**: Verify and update authentication credentials

#### Connection Timeouts
- **Symptom**: Network timeout errors
- **Cause**: Network connectivity or server performance
- **Resolution**: Check network connectivity and server status

#### Message Rejection
- **Symptom**: HTTP 400 responses
- **Cause**: Invalid HL7 message format
- **Resolution**: Validate message structure and content

### Diagnostic Steps
1. **Test Connectivity**: Verify network access to API endpoint
2. **Validate Credentials**: Test authentication with API
3. **Check Message Format**: Validate HL7 message structure
4. **Review API Logs**: Examine server-side logs if available
5. **Test with Sample Data**: Use known good messages for testing

### Support Escalation
For API-related issues requiring NextGen Office support:
- Provide correlation IDs and timestamps
- Include error messages and HTTP status codes
- Share sample message content (sanitized)
- Document troubleshooting steps already taken
