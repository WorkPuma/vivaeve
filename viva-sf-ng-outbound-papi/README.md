
Template Instructions ( Please remember to update the template portal in Exchange if you update these instructions )

**1. Getting and Importing the project**

- Download jar file from this portal 
- In Studio execute File -> Import (packaged mule application), and select the downloaded file.
- Specify an appropriate project name, without including any version number. For instance: sample-papi. 

**2.  Deleting Template API specification**

- Delete sample-app.xml and sample-app-impl.xml under src/main/mule

**3. Adding your API specification**

- Right click over the project -> Manage Dependencies -> Manage APIs
- Click on the green plus icon and select “from Exchange”. Your API spec should be published to Exchange to follow the best lifecycle practices. Search for your api specification, then click on add and finish.
- Click on Apply and Close, then select ‘YES’ when Studio asks you if scaffolding is needed.
- Delete the error section from API kit Main process and Console and use the <error-handler> from the mule-common-libraries, by updating the main API XML file to <error-handler ref=“error-handler” />.


**4. TLS Configuration**

- TLS settings needs to be updated accordingly since there will be different key store, alias, password etc

**5. Update values in POM File**

- Update the name and the artifactId depending on your Project in the POM file
	
**6. Final steps**

- Run the project, it should get to the DEPLOY status
- Finally, delete these instructions from README.md file. 

=========================================================

# Template API

This file is only targeted for developers. Use the API portal to document it for users.

## Runtime Properties

Instructions for adding runtime properties:
Run -> Run configurations... -> "(x)= Arguments tab" 
Then add the desired runtime properties in the VM Arguments box.
A similar sequence applies for debug but starting from Debug -> Debug configurations...

In local environment (Anypoint Studio):

- -Danypoint.platform.gatekeeper=disabled 

In other environments:

- API should be managed by API Manager in Dev, Stating and Prod so gatekeeper shouldn't be disabled when deploying there

- mule.env=</environment name/>  Default is 'local'
- -Dmule.key=</request value from your tech lead or MuleSoft consultant/>**************
