# Troubleshooting Guide

## Overview

This guide provides solutions for common issues encountered with the SFNextGen-v2 integration, including diagnostic procedures and resolution steps.

## Common Issues and Solutions

### 1. Salesforce Pub/Sub Connection Issues

#### Symptom: "Salesforce Pub/Sub connectivity issue detected"
**Possible Causes:**
- Invalid Salesforce credentials
- Network connectivity issues
- Salesforce service outage
- OAuth token expiration

**Diagnostic Steps:**
1. Check Salesforce credentials in configuration
2. Verify network connectivity to Salesforce
3. Test OAuth authentication manually
4. Check Salesforce service status

**Resolution:**
```bash
# Test Salesforce connectivity
curl -X POST https://login.salesforce.com/services/oauth2/token \
  -d "grant_type=password" \
  -d "client_id=YOUR_CLIENT_ID" \
  -d "client_secret=YOUR_CLIENT_SECRET" \
  -d "username=YOUR_USERNAME" \
  -d "password=YOUR_PASSWORD"
```

#### Symptom: "Circuit breaker is open"
**Cause:** Multiple consecutive Pub/Sub failures (>5)
**Resolution:**
1. Wait 5 minutes for automatic reset
2. Check underlying connectivity issues
3. Manually reset by restarting application

### 2. SFTP Upload Failures

#### Symptom: "SFTP Upload Failed: Connection timeout"
**Possible Causes:**
- Network connectivity issues
- SFTP server unavailable
- Firewall blocking connection
- Invalid SFTP credentials

**Diagnostic Steps:**
1. Test SFTP connectivity manually
2. Verify firewall rules
3. Check SFTP server status
4. Validate credentials

**Resolution:**
```bash
# Test SFTP connection manually
sftp foresthms@sftp.prod.ngo.nextgenaws.net
# Enter password when prompted
# Try to navigate to upload directory
cd /foresthms/toNGO/ADT
```

#### Symptom: "Permission denied" during upload
**Cause:** Insufficient permissions on SFTP server
**Resolution:**
1. Contact NextGen support to verify permissions
2. Ensure write access to target directories
3. Check file ownership and permissions

### 3. HL7 Message Transformation Errors

#### Symptom: "DataWeave transformation failed"
**Possible Causes:**
- Missing required fields in source event
- Invalid data formats
- Null pointer exceptions in transformation

**Diagnostic Steps:**
1. Review source event payload in logs
2. Identify missing or invalid fields
3. Check DataWeave transformation logic

**Resolution:**
1. Validate source data completeness
2. Add null checks in DataWeave transformations
3. Implement default values for optional fields

#### Symptom: "Invalid HL7 message format"
**Cause:** Malformed HL7 message structure
**Resolution:**
1. Validate HL7 message against standard
2. Check field delimiters and segment separators
3. Verify required segments are present

### 4. NextGen API Delivery Issues

#### Symptom: "HTTP 401 - Unauthorized"
**Cause:** Invalid API credentials
**Resolution:**
1. Verify API credentials in configuration
2. Check if credentials have expired
3. Test authentication manually

#### Symptom: "HTTP 500 - Internal Server Error"
**Cause:** NextGen API server error
**Resolution:**
1. Check if issue is temporary
2. Verify message format compliance
3. Contact NextGen support if persistent

### 5. Performance Issues

#### Symptom: Slow message processing
**Possible Causes:**
- Insufficient memory allocation
- Network latency
- High message volume
- Resource contention

**Diagnostic Steps:**
1. Monitor JVM memory usage
2. Check network latency to external systems
3. Review message processing rates
4. Analyze thread pool utilization

**Resolution:**
1. Increase JVM heap size
2. Optimize connection pooling
3. Implement message batching
4. Scale horizontally if needed

## Diagnostic Procedures

### Log Analysis

#### Key Log Patterns
```bash
# Search for errors
grep "ERROR" logs/sfnextgen-v2.log

# Find specific correlation ID
grep "correlationId: 12345" logs/sfnextgen-v2.log

# Check SFTP operations
grep "SFTP" logs/sfnextgen-v2.log

# Monitor API calls
grep "NextGen API" logs/sfnextgen-v2.log
```

#### Log Levels and Meanings
- **ERROR**: Critical issues requiring immediate attention
- **WARN**: Non-critical issues that should be monitored
- **INFO**: Normal operational information
- **DEBUG**: Detailed diagnostic information

### Health Check Procedures

#### Application Health
```bash
# Check application status
curl http://localhost:8081/health

# Expected response
{
  "status": "UP",
  "components": {
    "salesforce": "UP",
    "sftp": "UP",
    "nextgen-api": "UP"
  }
}
```

#### Connectivity Tests
```bash
# Test Salesforce connectivity
curl -I https://login.salesforce.com

# Test NextGen SFTP
telnet sftp.prod.ngo.nextgenaws.net 22

# Test NextGen API
curl -I https://prod-ehr.prod.ngo.nextgenaws.net
```

### Performance Monitoring

#### JVM Monitoring
```bash
# Check memory usage
jstat -gc [PID]

# Monitor thread usage
jstack [PID] | grep "java.lang.Thread.State"

# CPU usage
top -p [PID]
```

#### Application Metrics
- **Message Processing Rate**: Messages per minute
- **Error Rate**: Percentage of failed messages
- **Response Time**: Average processing time per message
- **Queue Depth**: Number of pending messages

## Error Code Reference

### Application Error Codes
| Code | Description | Severity | Action |
|------|-------------|----------|--------|
| SF001 | Salesforce connection failure | High | Check credentials and connectivity |
| SF002 | Platform event parsing error | Medium | Validate event structure |
| HL001 | HL7 transformation failure | High | Review source data and transformation |
| HL002 | Invalid HL7 message format | High | Validate message structure |
| FTP001 | SFTP connection timeout | Medium | Check network and server status |
| FTP002 | SFTP authentication failure | High | Verify credentials |
| API001 | NextGen API authentication error | High | Check API credentials |
| API002 | NextGen API server error | Medium | Monitor and retry |

### HTTP Status Codes
| Code | Meaning | Action |
|------|---------|--------|
| 200 | Success | Normal operation |
| 400 | Bad Request | Check message format |
| 401 | Unauthorized | Verify credentials |
| 403 | Forbidden | Check permissions |
| 500 | Server Error | Retry with backoff |
| 503 | Service Unavailable | Wait and retry |

## Recovery Procedures

### Message Recovery
1. **Identify Failed Messages**: Search logs for correlation IDs
2. **Locate Source Events**: Find original Salesforce events
3. **Replay Messages**: Trigger event replay if possible
4. **Manual Processing**: Process messages manually if needed

### System Recovery
1. **Application Restart**: Restart MuleSoft application
2. **Configuration Reload**: Reload configuration without restart
3. **Connection Reset**: Reset external connections
4. **Full System Restart**: Restart entire system if necessary

### Data Recovery
1. **Local File Backup**: Retrieve from local file backup
2. **SFTP Server**: Check if files were uploaded successfully
3. **NextGen Logs**: Verify message receipt in NextGen
4. **Salesforce Replay**: Use platform event replay functionality

## Escalation Procedures

### Internal Escalation
1. **Level 1**: Application support team
2. **Level 2**: Integration development team
3. **Level 3**: Architecture and infrastructure team

### External Escalation
1. **Salesforce Issues**: Salesforce support with case number
2. **NextGen Issues**: NextGen Office support with details
3. **Network Issues**: Network operations center

### Support Information Required
- **Error Messages**: Complete error text and stack traces
- **Correlation IDs**: For message tracking
- **Timestamps**: When issues occurred
- **Environment**: Development, staging, or production
- **Recent Changes**: Any recent deployments or configuration changes

## Preventive Measures

### Monitoring Setup
- **Application Monitoring**: Set up alerts for errors and performance
- **Infrastructure Monitoring**: Monitor server resources
- **External Service Monitoring**: Monitor Salesforce and NextGen availability

### Regular Maintenance
- **Log Rotation**: Implement log rotation to prevent disk space issues
- **Credential Rotation**: Regularly update passwords and API keys
- **Performance Tuning**: Regular performance reviews and optimizations
- **Backup Verification**: Test backup and recovery procedures

### Documentation Updates
- **Incident Documentation**: Document all incidents and resolutions
- **Runbook Updates**: Keep troubleshooting procedures current
- **Knowledge Sharing**: Share lessons learned with team
