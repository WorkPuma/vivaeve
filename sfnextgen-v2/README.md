# SFNextGen-v2 Integration

## Overview

SFNextGen-v2 is a MuleSoft integration application that bridges Salesforce platform events with NextGen Office EMR system through HL7 message processing. This integration enables real-time synchronization of patient data and appointment information between Salesforce and NextGen Office via secure SFTP and API connections.

## Purpose

This integration serves as a critical healthcare data bridge that:

- **Listens to Salesforce Platform Events**: Monitors Contact__e and NextGenServiceAppointment__e events
- **Transforms Data to HL7 Format**: Converts Salesforce data into HL7 ADT and SIU messages
- **Delivers to NextGen Office**: Sends HL7 messages via SFTP and optionally to NextGen API
- **Ensures Data Integrity**: Provides comprehensive error handling and logging
- **Maintains Compliance**: Follows healthcare data standards and security protocols

## Architecture

### Core Components

1. **Salesforce Pub/Sub Listeners**
   - Contact__e event processing (ADT messages)
   - NextGenServiceAppointment__e event processing (SIU messages)

2. **HL7 Message Builders**
   - ADT^A04 (Patient Registration)
   - ADT^A08 (Patient Update)
   - SIU^S12 (New Appointment)
   - SIU^S14 (Modify Appointment)
   - SIU^S15 (Cancel Appointment)

3. **Data Transformation Layer**
   - DataWeave transformations for HL7 compliance
   - Field mapping and validation
   - Format standardization

4. **Delivery Mechanisms**
   - SFTP file upload to NextGen server
   - Optional API delivery to NextGen endpoint
   - Local file backup for audit trails

### Message Flow

```
Salesforce Platform Event → MuleSoft Listener → Data Validation → 
HL7 Transformation → SFTP Upload → NextGen API (Optional) → 
Error Handling & Logging
```

## Supported Event Types

### Contact__e Events (ADT Messages)
- **A04**: Patient Registration
- **A08**: Patient Information Update

### NextGenServiceAppointment__e Events (SIU Messages)
- **S12**: New Appointment Notification
- **S14**: Appointment Modification
- **S15**: Appointment Cancellation

## Prerequisites

### System Requirements
- MuleSoft Runtime 4.6.6 or higher
- Java 11
- Maven 3.6+

### Connectivity Requirements
- Salesforce Pub/Sub API access
- SFTP access to NextGen server
- Network connectivity to NextGen API endpoints

### Salesforce Configuration
- Platform Events: Contact__e, NextGenServiceAppointment__e
- Connected App with appropriate permissions
- Pub/Sub API enabled

## Configuration

### Environment Properties

Configure the following properties in `src/main/resources/config.properties`:

```properties
# NextGen Configuration
sent.to.nextgen=true
nextgen.url=https://prod-ehr.prod.ngo.nextgenaws.net/messaging/mcservice
nextgen.auth=Basic [base64-encoded-credentials]
nextgen.x-process=MULESOFT,HUB
nextgen.content-type=text/plain; charset=UTF-8
nextgen.Priority=M
nextgen.Node=MC1
nextgen.accountnumber=[account-number]
nextgen.x-api-key=[api-key]
nextgen.username=[username]

# HTTP Configuration
http.host=0.0.0.0
http.port=8083
https.host=0.0.0.0
https.port=8082
```

### Secure Properties

Configure in `mule-artifact.json` or environment-specific configuration:

```json
{
  "secureProperties": [
    "salesforce.consumerSecret",
    "salesforce.password",
    "salesforce.tokenEndpoint",
    "salesforce.pubsub.consumerKey",
    "salesforce.consumerKey",
    "salesforce.pubsub.password",
    "salesforce.pubsub.username",
    "salesforce.pubsub.tokenEndpoint",
    "salesforce.username",
    "salesforce.pubsub.consumerSecret"
  ]
}
```

## Installation & Deployment

### Local Development

1. **Clone the repository**
   ```bash
   git clone [repository-url]
   cd sfnextgen-v2
   ```

2. **Configure properties**
   - Update `config.properties` with environment-specific values
   - Set secure properties in your MuleSoft environment

3. **Build the application**
   ```bash
   mvn clean package
   ```

4. **Deploy to local runtime**
   ```bash
   mvn mule:deploy
   ```

### Production Deployment

1. **Package the application**
   ```bash
   mvn clean package -Dmule.env=prod
   ```

2. **Deploy to CloudHub or On-Premises**
   - Use Anypoint Platform for CloudHub deployment
   - Use Mule Runtime for on-premises deployment

## Monitoring & Logging

### Health Monitoring
- Circuit breaker pattern for Pub/Sub connectivity
- Automatic retry mechanisms
- Health check endpoints

### Logging Levels
- **INFO**: Normal operation flow
- **WARN**: Non-critical issues
- **ERROR**: Critical failures requiring attention

### Key Metrics
- Message processing rates
- SFTP upload success/failure rates
- API response times
- Error rates by message type

## Error Handling

### Circuit Breaker
- Monitors Pub/Sub connection health
- Opens circuit after 5 consecutive failures
- Resets after 5-minute cooldown period

### Retry Logic
- SFTP uploads: 1 retry with 1-second delay
- NextGen API calls: 3 retries with 1-second intervals
- Pub/Sub reconnection: Automatic with exponential backoff

### Dead Letter Queue
- Failed messages stored in `deadletter/` directory
- Correlation IDs for message tracking
- Error details logged for troubleshooting

## Security Considerations

### Data Protection
- Secure property encryption
- SFTP with authentication
- API authentication via Basic Auth and API keys

### Compliance
- HL7 standard compliance
- Healthcare data handling protocols
- Audit trail maintenance

## Troubleshooting

### Common Issues

1. **Pub/Sub Connection Failures**
   - Check Salesforce credentials
   - Verify network connectivity
   - Review circuit breaker status

2. **SFTP Upload Failures**
   - Validate SFTP credentials
   - Check network connectivity
   - Verify file permissions

3. **HL7 Transformation Errors**
   - Review DataWeave transformations
   - Check input data format
   - Validate required fields

### Log Analysis
- Search for correlation IDs to trace message flow
- Monitor error patterns in application logs
- Check SFTP server logs for upload issues

## Support & Maintenance

For technical support and maintenance requests, please refer to the WARRANTY.md file included with this distribution.

## Quick Start

1. **Clone the Repository**
   ```bash
   git clone [repository-url]
   cd sfnextgen-v2
   ```

2. **Configure Environment**
   ```bash
   cp config.properties.template config.properties
   # Edit config.properties with your environment-specific values
   ```

3. **Review Documentation**
   - Read [WARRANTY.md](./WARRANTY.md) for support terms
   - Check [documentation/](./documentation/) for detailed guides
   - Review [documentation/deployment/](./documentation/deployment/) for setup instructions

4. **Deploy Application**
   ```bash
   mvn clean package
   mvn mule:deploy
   ```

## Documentation

Comprehensive documentation is available in the [documentation/](./documentation/) folder:

- **[Interface Specifications](./documentation/interfaces/)**: Detailed API and message format documentation
- **[Deployment Guide](./documentation/deployment/)**: Environment setup and deployment procedures
- **[Troubleshooting](./documentation/troubleshooting/)**: Common issues and solutions
- **[Examples](./documentation/examples/)**: Sample messages and test scenarios

## Security Notice

⚠️ **Important**: This repository contains template configuration files only. Never commit actual credentials or sensitive data to version control.

- Use `config.properties.template` as a starting point
- Configure secure properties in your MuleSoft runtime environment
- Review `.gitignore` to ensure sensitive files are excluded

## Version Information

- **Version**: 1.0.0
- **Mule Runtime**: 4.4.0 (minimum 4.6.6 required)
- **Java Version**: 11
- **Last Updated**: August 2025

## Support and Warranty

This software is provided with a comprehensive warranty and support agreement. Please refer to [WARRANTY.md](./WARRANTY.md) for:

- Interface functionality guarantees
- Defect resolution commitments
- Support contact information
- Terms and conditions

## License

This software is provided under the terms specified in the WARRANTY.md file.
