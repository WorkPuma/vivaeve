# Project Structure

## Overview

This document outlines the complete structure of the SFNextGen-v2 integration project, including all files, directories, and their purposes.

## Root Directory Structure

```
sfnextgen-v2/
├── README.md                           # Main project documentation
├── WARRANTY.md                         # Software warranty and support agreement
├── PROJECT_STRUCTURE.md               # This file - project structure overview
├── pom.xml                            # Maven project configuration
├── mule-artifact.json                 # MuleSoft application metadata
├── config.properties.template         # Configuration template (copy to config.properties)
├── .gitignore                         # Git ignore rules for security
├── documentation/                     # Comprehensive documentation
├── src/                              # Source code
├── target/                           # Build output (ignored by git)
├── exchange-docs/                    # Exchange documentation
└── hardis-report/                    # Quality reports
```

## Source Code Structure

```
src/
├── main/
│   ├── java/                         # Java source files (if any)
│   ├── mule/
│   │   ├── sfnextgen-v2.xml         # Main MuleSoft flow configuration
│   │   └── xsd/                     # XML schema definitions
│   └── resources/
│       ├── config.properties        # Environment configuration (not in git)
│       ├── log4j2.xml              # Logging configuration
│       ├── api/                    # API specifications
│       ├── dwl/                    # DataWeave transformation libraries
│       │   ├── common/             # Common utilities
│       │   └── hl7/                # HL7-specific transformations
│       │       ├── adt.dwl         # ADT message builders
│       │       ├── siu.dwl         # SIU message builders
│       │       ├── common.dwl      # Common HL7 utilities
│       │       └── delimiters.dwl  # HL7 delimiter definitions
│       └── xsd/                    # Additional schema files
└── test/                           # Test resources and configurations
```

## Documentation Structure

```
documentation/
├── README.md                       # Documentation index
├── api/                           # API documentation
├── interfaces/                    # Interface specifications
│   ├── README.md                  # Interface overview
│   ├── salesforce-events.md       # Salesforce platform events
│   ├── hl7-messages.md           # HL7 message formats
│   ├── sftp-interface.md         # SFTP configuration
│   └── nextgen-api.md            # NextGen API specifications
├── deployment/                    # Deployment guides
│   └── README.md                  # Deployment procedures
├── troubleshooting/               # Troubleshooting guides
│   └── README.md                  # Common issues and solutions
└── examples/                      # Sample data and configurations
    └── sample-events.md           # Sample platform events and HL7 messages
```

## Key Files Description

### Configuration Files

| File | Purpose | Security Level |
|------|---------|----------------|
| `config.properties.template` | Configuration template | Public |
| `config.properties` | Actual configuration | **Secure - Not in Git** |
| `mule-artifact.json` | Application metadata | Public (secure properties listed) |
| `log4j2.xml` | Logging configuration | Public |

### Source Files

| File | Purpose | Description |
|------|---------|-------------|
| `sfnextgen-v2.xml` | Main flow | Core integration logic and flows |
| `dwl/hl7/adt.dwl` | ADT transformations | Patient registration/update messages |
| `dwl/hl7/siu.dwl` | SIU transformations | Appointment scheduling messages |
| `dwl/hl7/common.dwl` | Common utilities | Shared HL7 helper functions |

### Documentation Files

| File | Purpose | Audience |
|------|---------|----------|
| `README.md` | Project overview | All users |
| `WARRANTY.md` | Support agreement | Clients/Legal |
| `PROJECT_STRUCTURE.md` | This file | Developers |
| `documentation/interfaces/` | Technical specs | Developers/Integrators |
| `documentation/deployment/` | Setup guides | DevOps/Administrators |
| `documentation/troubleshooting/` | Issue resolution | Support teams |

## Security Considerations

### Files Excluded from Git

The following files contain sensitive information and are excluded from version control:

- `config.properties` - Contains actual credentials and endpoints
- `src/main/resources/secure-*.properties` - Secure property files
- `logs/` - Log files may contain sensitive data
- `deadletter/` - Failed messages may contain PHI
- `foresthms/` - Local file outputs contain healthcare data
- `*.keystore`, `*.p12`, `*.pem` - Certificate and key files

### Secure Properties

The following properties are marked as secure in `mule-artifact.json`:

- Salesforce authentication credentials
- SFTP connection details
- NextGen API authentication
- Webhook signatures and hosts

### Best Practices

1. **Never commit actual configuration files** - Use templates only
2. **Use secure property placeholders** - For all sensitive values
3. **Regular credential rotation** - Update passwords and API keys regularly
4. **Environment separation** - Different credentials per environment
5. **Access control** - Limit repository access to authorized personnel

## Build and Deployment Artifacts

### Maven Build Output

```
target/
├── classes/                        # Compiled classes and resources
├── generated-sources/              # Generated source files
├── maven-status/                   # Build status information
├── repository/                     # Local Maven dependencies
├── sfnextgen-v2-1.0.0-mule-application.jar  # Deployable artifact
└── test-classes/                   # Compiled test classes
```

### Deployment Artifacts

- **JAR File**: `sfnextgen-v2-1.0.0-mule-application.jar`
- **Configuration**: Environment-specific property files
- **Documentation**: Complete documentation package
- **Support Files**: Warranty, troubleshooting guides

## Development Workflow

### Local Development

1. Clone repository
2. Copy `config.properties.template` to `config.properties`
3. Configure development environment values
4. Build and test locally
5. Commit code changes (excluding sensitive files)

### Environment Promotion

1. **Development** → **Staging** → **Production**
2. Environment-specific configuration management
3. Secure property configuration per environment
4. Deployment validation and testing

### Version Control

- **Source Code**: All non-sensitive files tracked in Git
- **Configuration**: Templates only, actual configs excluded
- **Documentation**: Maintained alongside code
- **Releases**: Tagged versions for deployment tracking

## Maintenance and Updates

### Regular Maintenance

- **Documentation Updates**: Keep current with code changes
- **Security Reviews**: Regular credential and access audits
- **Performance Monitoring**: Track and optimize performance
- **Dependency Updates**: Keep libraries current

### Change Management

- **Code Changes**: Follow standard development workflow
- **Configuration Changes**: Document and test thoroughly
- **Documentation Updates**: Update with each release
- **Security Updates**: Immediate deployment for critical fixes

## Support and Contact

For questions about the project structure or development workflow:

1. **Technical Issues**: Refer to `documentation/troubleshooting/`
2. **Deployment Questions**: See `documentation/deployment/`
3. **Support Requests**: Follow procedures in `WARRANTY.md`
4. **Security Concerns**: Contact security team immediately

---

*This document is maintained alongside the project and updated with each significant change to the project structure.*
