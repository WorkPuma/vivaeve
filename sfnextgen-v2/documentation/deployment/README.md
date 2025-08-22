# Deployment Guide

## Overview

This guide provides comprehensive instructions for deploying the SFNextGen-v2 integration across different environments, from development to production.

## Deployment Architecture

### Environment Types
- **Development**: Local development and testing
- **Staging**: Pre-production testing and validation
- **Production**: Live production environment

### Deployment Options
- **CloudHub**: MuleSoft's cloud platform
- **On-Premises**: Local MuleSoft runtime
- **Hybrid**: Combination of cloud and on-premises

## Prerequisites

### System Requirements
- **MuleSoft Runtime**: 4.6.6 or higher
- **Java**: OpenJDK 11 or Oracle JDK 11
- **Maven**: 3.6.0 or higher
- **Memory**: Minimum 2GB RAM, Recommended 4GB
- **Disk Space**: Minimum 1GB available

### Network Requirements
- **Outbound HTTPS**: Access to Salesforce APIs (port 443)
- **Outbound SFTP**: Access to NextGen SFTP server (port 22)
- **Outbound HTTPS**: Access to NextGen API (port 443)
- **Inbound HTTP**: For health checks and monitoring (port 8081)

### Access Requirements
- **Salesforce**: Connected App with Pub/Sub API permissions
- **NextGen SFTP**: Username/password credentials
- **NextGen API**: API key and authentication credentials

## Environment Configuration

### Development Environment

#### Local Setup
1. **Install MuleSoft Runtime**
   ```bash
   # Download and extract Mule Runtime 4.6.6
   wget https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/4.6.6/mule-standalone-4.6.6.tar.gz
   tar -xzf mule-standalone-4.6.6.tar.gz
   ```

2. **Configure Environment Variables**
   ```bash
   export MULE_HOME=/path/to/mule-standalone-4.6.6
   export JAVA_HOME=/path/to/java-11
   export PATH=$MULE_HOME/bin:$PATH
   ```

3. **Create Configuration Files**
   - Copy `config.properties.template` to `config.properties`
   - Update with development environment values
   - Configure secure properties for credentials

#### Development Configuration
```properties
# Development Environment Settings
sent.to.nextgen=false
nextgen.url=https://test-ehr.test.ngo.nextgenaws.net/messaging/mcservice
http.host=localhost
http.port=8081

# Salesforce Development Org
salesforce.pubsub.username=dev-user@company.com.dev
salesforce.pubsub.tokenEndpoint=https://test.salesforce.com/services/oauth2/token
```

### Staging Environment

#### CloudHub Deployment
1. **Package Application**
   ```bash
   mvn clean package -Dmule.env=staging
   ```

2. **Deploy to CloudHub**
   ```bash
   mvn mule:deploy -Dmule.env=staging
   ```

3. **Configure Properties**
   - Set environment-specific properties in CloudHub console
   - Configure secure properties for credentials
   - Set appropriate worker size and scaling

#### Staging Configuration
```properties
# Staging Environment Settings
sent.to.nextgen=true
nextgen.url=https://staging-ehr.staging.ngo.nextgenaws.net/messaging/mcservice
http.host=0.0.0.0
http.port=8081

# Salesforce Staging Org
salesforce.pubsub.username=staging-user@company.com.staging
salesforce.pubsub.tokenEndpoint=https://test.salesforce.com/services/oauth2/token
```

### Production Environment

#### Pre-Production Checklist
- [ ] All tests passing in staging environment
- [ ] Performance testing completed
- [ ] Security review completed
- [ ] Backup and recovery procedures tested
- [ ] Monitoring and alerting configured
- [ ] Documentation updated

#### Production Deployment
1. **Final Package Build**
   ```bash
   mvn clean package -Dmule.env=prod
   ```

2. **Deploy to Production**
   ```bash
   mvn mule:deploy -Dmule.env=prod
   ```

3. **Post-Deployment Verification**
   - Verify application startup
   - Test connectivity to all external systems
   - Validate message processing
   - Confirm monitoring is active

#### Production Configuration
```properties
# Production Environment Settings
sent.to.nextgen=true
nextgen.url=https://prod-ehr.prod.ngo.nextgenaws.net/messaging/mcservice
http.host=0.0.0.0
http.port=8081

# Salesforce Production Org
salesforce.pubsub.username=prod-user@company.com
salesforce.pubsub.tokenEndpoint=https://login.salesforce.com/services/oauth2/token
```

## Security Configuration

### Secure Properties Management

#### CloudHub Secure Properties
1. **Access CloudHub Console**
2. **Navigate to Application Settings**
3. **Configure Secure Properties**:
   ```
   salesforce.pubsub.consumerKey=your_consumer_key
   salesforce.pubsub.consumerSecret=your_consumer_secret
   salesforce.pubsub.password=your_password
   nextgen.auth=Basic_encoded_credentials
   nextgen.x-api-key=your_api_key
   ```

#### On-Premises Secure Properties
1. **Create Secure Properties File**
   ```bash
   # Create secure-config.properties
   salesforce.pubsub.consumerKey=![encrypted_value]
   salesforce.pubsub.consumerSecret=![encrypted_value]
   ```

2. **Configure Encryption Key**
   ```bash
   export MULE_ENCRYPTION_KEY=your_encryption_key
   ```

### Network Security

#### Firewall Configuration
- **Outbound Rules**:
  - HTTPS to *.salesforce.com (port 443)
  - SFTP to sftp.prod.ngo.nextgenaws.net (port 22)
  - HTTPS to prod-ehr.prod.ngo.nextgenaws.net (port 443)

#### SSL/TLS Configuration
- **Minimum TLS Version**: 1.2
- **Certificate Validation**: Enabled
- **Cipher Suites**: Strong encryption only

## Performance Tuning

### Memory Configuration
```bash
# JVM Memory Settings
export MULE_OPTS="-Xms2g -Xmx4g -XX:+UseG1GC"
```

### Connection Pool Tuning
```xml
<!-- SFTP Connection Pool -->
<pooling-profile 
    maxActive="10" 
    maxIdle="5" 
    initialisationPolicy="INITIALISE_ONE" 
    exhaustedAction="WHEN_EXHAUSTED_WAIT" 
    maxWait="30000"/>
```

### Thread Pool Configuration
```xml
<!-- Custom Thread Pool -->
<configuration>
    <default-threading-profile maxThreadsActive="50" maxThreadsIdle="10"/>
</configuration>
```

## Monitoring and Logging

### Log Configuration
```xml
<!-- log4j2.xml -->
<Configuration>
    <Appenders>
        <RollingFile name="file" fileName="logs/sfnextgen-v2.log">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss} [%t] %-5level %logger{36} - %msg%n"/>
            <Policies>
                <SizeBasedTriggeringPolicy size="100MB"/>
            </Policies>
            <DefaultRolloverStrategy max="10"/>
        </RollingFile>
    </Appenders>
    <Loggers>
        <Logger name="com.mulesoft" level="INFO"/>
        <Root level="INFO">
            <AppenderRef ref="file"/>
        </Root>
    </Loggers>
</Configuration>
```

### Health Check Endpoints
- **Application Health**: `http://localhost:8081/health`
- **Salesforce Connectivity**: `http://localhost:8081/health/salesforce`
- **SFTP Connectivity**: `http://localhost:8081/health/sftp`

## Backup and Recovery

### Application Backup
- **Source Code**: Maintained in Git repository
- **Configuration**: Environment-specific configurations backed up
- **Logs**: Archived according to retention policy

### Recovery Procedures
1. **Application Failure**: Redeploy from last known good version
2. **Configuration Issues**: Restore from configuration backup
3. **Data Loss**: Replay messages from Salesforce platform events

## Troubleshooting Deployment Issues

### Common Deployment Problems

#### Application Startup Failures
- **Symptom**: Application fails to start
- **Causes**: Missing dependencies, configuration errors, port conflicts
- **Resolution**: Check logs, validate configuration, verify dependencies

#### Connectivity Issues
- **Symptom**: Cannot connect to external systems
- **Causes**: Network restrictions, credential issues, endpoint changes
- **Resolution**: Test connectivity, validate credentials, check firewall rules

#### Performance Issues
- **Symptom**: Slow message processing
- **Causes**: Insufficient resources, network latency, inefficient queries
- **Resolution**: Monitor resource usage, optimize configurations, tune performance

### Diagnostic Commands
```bash
# Check application status
curl http://localhost:8081/health

# View application logs
tail -f logs/sfnextgen-v2.log

# Monitor JVM memory
jstat -gc [pid]

# Test network connectivity
telnet sftp.prod.ngo.nextgenaws.net 22
```

## Rollback Procedures

### CloudHub Rollback
1. **Access CloudHub Console**
2. **Navigate to Application**
3. **Select Previous Version**
4. **Deploy Previous Version**

### On-Premises Rollback
1. **Stop Current Application**
   ```bash
   $MULE_HOME/bin/mule stop
   ```

2. **Deploy Previous Version**
   ```bash
   cp backup/sfnextgen-v2-previous.jar $MULE_HOME/apps/
   ```

3. **Start Application**
   ```bash
   $MULE_HOME/bin/mule start
   ```

## Post-Deployment Validation

### Validation Checklist
- [ ] Application started successfully
- [ ] All external connections established
- [ ] Test message processing working
- [ ] Monitoring and alerting active
- [ ] Log files being generated
- [ ] Performance metrics within acceptable ranges

### Test Scenarios
1. **End-to-End Test**: Send test event through complete flow
2. **Error Handling Test**: Trigger error conditions and verify handling
3. **Performance Test**: Process multiple messages and measure performance
4. **Failover Test**: Test system behavior during outages
