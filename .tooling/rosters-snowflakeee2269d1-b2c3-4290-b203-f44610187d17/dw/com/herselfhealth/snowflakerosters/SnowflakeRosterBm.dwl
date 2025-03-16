%dw 2.0
import first from dw::core::Strings
import toString from dw::util::Coercions

fun validateMinnesotaADTPatient(patient: Object, processedPatients: Array): Array = do 
{	
	var patientAlreadyExistsErrors = if(!isEmpty(processedPatients filter ($ == patient.elationPatientId) default []))
			[{ "Error": "Patient id is duplicated", "isWarning": false }]
		else
			[]
			
	var homePhoneErrors = 
		if (!isEmpty(patient.homePhone) and !((patient.homePhone first 10) matches /^[0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in homePhone", "isWarning": false }]
		else 
			[]
	
	var cellPhoneErrors = 
		if (!isEmpty(patient.cellPhone) and !((patient.cellPhone first 10) matches /^[0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in cellPhone", "isWarning": false }]
		else 
			[]
			
	var dobInFutureErrors = 
		if (!isEmpty(patient.dateOfBirth) and (patient.dateOfBirth as Date) > now())
			[{ "Error": "Date of birth is in the future", "isWarning": false }]
		else
			[]
	
	var dobIsEmptyErrors = 
		if (isEmpty(patient.dateOfBirth)) 
			[{ "Error": "Date of birth is empty", "isWarning": false }]
		else 
			[]
			
	var genderIsEmptyErrors = 
		if (isEmpty(patient.sex)) 
			[{ "Error": "Gender is empty", "isWarning": false }]
		else 
			[]
			
	var zipIsEmptyErrors = 
		if (isEmpty(patient.zip)) 
			[{ "Error": "Zip code is empty", "isWarning": false }]
		else 
			[]
			
	var stateIsEmptyErrors = 
		if (isEmpty(patient.state)) 
			[{ "Error": "State is empty", "isWarning": false }]
		else 
			[]
	
	var cityIsEmptyErrors = 
		if (isEmpty(patient.city)) 
			[{ "Error": "City is empty", "isWarning": false }]
		else 
			[]
			
	var addressLine1IsEmptyErrors = 
		if (isEmpty(patient.addressLine1)) 
			[{ "Error": "Address line 1 is empty", "isWarning": false }]
		else 
			[]
	
	var lastNameIsEmptyErrors = 
		if (isEmpty(patient.lastName)) 
			[{ "Error": "Last name is empty", "isWarning": false }]
		else 
			[]
			
	var firstNameIsEmptyErrors = 
		if (isEmpty(patient.firstName)) 
			[{ "Error": "First name is empty", "isWarning": false }]
		else 
			[]
			
	var elationPatientIdIsEmptyErrors = 
		if (isEmpty(patient.elationPatientId)) 
			[{ "Error": "Elation patient id is empty", "isWarning": false }]
		else 
			[]	
		
	---
	patientAlreadyExistsErrors ++
	cellPhoneErrors ++
	homePhoneErrors ++
	dobInFutureErrors ++
	dobIsEmptyErrors ++
	genderIsEmptyErrors ++
	zipIsEmptyErrors ++
	stateIsEmptyErrors ++
	cityIsEmptyErrors ++
	addressLine1IsEmptyErrors ++
	lastNameIsEmptyErrors ++
	firstNameIsEmptyErrors ++
	elationPatientIdIsEmptyErrors
}

fun validateBambooHealthPatient(patient: Object, processedPatients: Array): Array = do 
{	
	var patientAlreadyExistsErrors = if(!isEmpty(processedPatients filter ($ == patient.elationPatientId) default []))
			[{ "Error": "Patient id is duplicated", "isWarning": false }]
		else
			[]
	
	var dobInFutureErrors = 
		if (!isEmpty(patient.dateOfBirth) and (patient.dateOfBirth as Date) > now())
			[{ "Error": "Date of birth is in the future", "isWarning": false }]
		else
			[]
	
	var firstNameIsEmptyErrors = 
		if (isEmpty(patient.firstName)) 
			[{ "Error": "First name is empty", "isWarning": false }]
		else 
			[]
			
	var lastNameIsEmptyErrors = 
		if (isEmpty(patient.lastName)) 
			[{ "Error": "Last name is empty", "isWarning": false }]
		else 
			[]
			
	var dobIsEmptyErrors = 
		if (isEmpty(patient.dateOfBirth)) 
			[{ "Error": "Date of birth is empty", "isWarning": false }]
		else 
			[]
			
	var genderIsEmptyErrors = 
		if (isEmpty(patient.sex)) 
			[{ "Error": "Gender is empty", "isWarning": false }]
		else 
			[]
	
	var firstNameErrors = 
		if (!isEmpty(patient.firstName) and !((patient.firstName first 50) matches /^[-'., A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in first name", "isWarning": false }]
		else 
			[]
			
	var lastNameErrors = 
		if (!isEmpty(patient.lastName) and !((patient.lastName first 50) matches /^[-'., A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in last name", "isWarning": false }]
		else 
			[]
			
	var addressLine1InvalidCharacterErrors = 
		if (!isEmpty(patient.addressLine1) and !((patient.addressLine1 first 100) matches /^[-#\\\/&'.,: A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in address line 1", "isWarning": true }]
		else 
			[]
	
	var addressLine1VoidWordErrors = 
		if (!isEmpty(patient.addressLine1) and ((patient.addressLine1 first 100) matches /\b(?i)(bad|needs|no address)\b/)) 
			[{ "Error": "Void word(s) found in address line 1", "isWarning": true }]
		else 
			[]
	
	var addressLine2InvalidCharacterErrors = 
		if (!isEmpty(patient.addressLine2) and !((patient.addressLine2 first 100) matches /^[-#\\\/&'.,: A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in address line 2", "isWarning": true }]
		else 
			[]
	
	var addressLine2VoidWordErrors = 
		if (!isEmpty(patient.addressLine2) and ((patient.addressLine2 first 100) matches /\b(?i)(bad|needs|no address)\b/)) 
			[{ "Error": "Void word(s) found in address line 2", "isWarning": true }]
		else 
			[]
			
	var cityErrors = 
		if (!isEmpty(patient.city) and !((patient.city first 30) matches /^[-'.\\ A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in city", "isWarning": true }]
		else 
			[]
	
	var stateErrors = 
		if (!isEmpty(patient.state) and !((patient.state) matches /^[A-Za-z]+$/)) 
			[{ "Error": "Invalid character(s) found in state", "isWarning": true }]
		else 
			[]
	
	var zipErrors = 
		if (!isEmpty(patient.zip) and !((patient.zip first 5) matches /^[0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in zip", "isWarning": true }]
		else 
			[]
	
	var homePhoneErrors = 
		if (!isEmpty(patient.homePhone) and !((patient.homePhone first 10) matches /^[-.\(\) 0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in homePhone", "isWarning": true }]
		else 
			[]
	
	var cellPhoneErrors = 
		if (!isEmpty(patient.cellPhone) and !((patient.cellPhone first 10) matches /^[-.\(\) 0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in cellPhone", "isWarning": true }]
		else 
			[]
			
	var genderInvalidErrors = 
		if (!isEmpty(patient.sex) and !(patient.sex matches /^M$|^F$|^U$|^O$|^X$|^MALE$|^FEMALE$|^UNKNOWN$|^OTHER$|^NON-BINARY$/))
			[{ "Error": "Gender is not invalid", "isWarning": false }]
		else 
			[]
	
	var insurer1InvalidCharacterErrors = 
		if (!isEmpty(patient.insurer1) and !((patient.insurer1 first 60) matches /^[-\/&, A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in insurer 1", "isWarning": true }]
		else 
			[]
			
	var insuranceNumber1InvalidCharacterErrors = 
		if (!isEmpty(patient.insuranceNumber1) and !((patient.insuranceNumber1 first 75) matches /^[-{_|#. A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in insurance number 1", "isWarning": true }]
		else 
			[]
			
	var insurer2InvalidCharacterErrors = 
		if (!isEmpty(patient.insurer2) and !((patient.insurer2 first 60) matches /^[-\/&, A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in insurer 2", "isWarning": true }]
		else 
			[]
			
	var insuranceNumber2InvalidCharacterErrors = 
		if (!isEmpty(patient.insuranceNumber2) and !((patient.insuranceNumber2 first 75) matches /^[-{_|#. A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in insurance number 2", "isWarning": true }]
		else 
			[]
			
	var providerFirstName1InvalidCharacterErrors = 
		if (!isEmpty(patient.providerFirstName1) and !((patient.providerFirstName1 first 50) matches /^[-'.,&()A-Za-z]+$/)) 
			[{ "Error": "Invalid character(s) found in attributed provider first name", "isWarning": true }]
		else 
			[]
			
	var providerLastName1InvalidCharacterErrors = 
		if (!isEmpty(patient.providerLastName1) and !((patient.providerLastName1 first 60) matches /^[-'.,A-Za-z]+$/)) 
			[{ "Error": "Invalid character(s) found in attributed provider last name", "isWarning": true }]
		else 
			[]
			
	var providerHonorifics1InvalidCharacterErrors = 
		if (!isEmpty(patient.providerHonorifics1) and !((patient.providerHonorifics1 first 10) matches /^[-., A-Za-z]+$/)) 
			[{ "Error": "Invalid character(s) found in provider honorifics 1", "isWarning": true }]
		else 
			[]
			
	var providerNpi1InvalidCharacterErrors = 
		if (!isEmpty(patient.providerNpi1) and !((patient.providerNpi1 first 15) matches /^[-.#\/A-Za-z0-9]+$/)) 
			[{ "Error": "Invalid character(s) found in provider npi 1", "isWarning": true }]
		else 
			[]
		
	var insurer1MinimumLengthErrors = 
		if (!isEmpty(patient.insurer1) and sizeOf(patient.insurer1) < 3) 
			[{ "Error": "Insurer 1 must be at least 3 characters if provided", "isWarning": true }]
		else 
			[]
			
	var insuranceNumber1MinimumLengthErrors = 
		if (!isEmpty(patient.insuranceNumber1) and sizeOf(patient.insuranceNumber1) < 3) 
			[{ "Error": "Insurance Number 1 must be at least 3 characters if provided", "isWarning": true }]
		else 
			[]
			
	var insurer2MinimumLengthErrors = 
		if (!isEmpty(patient.insurer2) and sizeOf(patient.insurer2) < 3) 
			[{ "Error": "Insurer 2 must be at least 3 characters if provided", "isWarning": true }]
		else 
			[]
			
	var insuranceNumber2MinimumLengthErrors = 
		if (!isEmpty(patient.insuranceNumber2) and sizeOf(patient.insuranceNumber2) < 3) 
			[{ "Error": "Insurance Number 2 must be at least 3 characters if provided", "isWarning": true }]
		else 
			[]
			
	---
	firstNameErrors ++ 
	lastNameErrors ++ 
	addressLine1InvalidCharacterErrors ++ 
	addressLine1VoidWordErrors ++ 
	addressLine2InvalidCharacterErrors ++ 
	addressLine2VoidWordErrors ++ 
	cityErrors ++ 
	stateErrors ++ 
	zipErrors ++ 
	homePhoneErrors ++ 
	cellPhoneErrors ++
	dobIsEmptyErrors ++
	genderIsEmptyErrors ++
	genderInvalidErrors ++
	dobInFutureErrors ++
	patientAlreadyExistsErrors ++
	providerNpi1InvalidCharacterErrors ++
	providerHonorifics1InvalidCharacterErrors ++
	providerLastName1InvalidCharacterErrors ++
	providerFirstName1InvalidCharacterErrors ++
	insuranceNumber1InvalidCharacterErrors ++
	insurer1InvalidCharacterErrors ++
	insurer1MinimumLengthErrors ++
	insuranceNumber1MinimumLengthErrors ++
	insuranceNumber2InvalidCharacterErrors ++
	insurer2InvalidCharacterErrors ++
	insurer2MinimumLengthErrors ++
	insuranceNumber2MinimumLengthErrors
}

fun mapBambooHealthPatient(patient: Object) = do 
{
	{
		"PATIENT_ID": patient.elationPatientId,
		"PATIENT_FIRST_NAME": patient.firstName first 50,
		"PATIENT_MIDDLE_INITIAL": null,
		"PATIENT_LAST_NAME": patient.lastName first 50,
		"PATIENT_SUFFIX": null,
		"PATIENT_DOB": (patient.dateOfBirth as Date) as String {format: "uuuuMMdd" },
		"PATIENT_GENDER": upper(patient.sex),
		"PATIENT_SSN": null,
		"PATIENT_ADDRESS_1": patient.addressLine1 first 100,
		"PATIENT_ADDRESS_2": patient.addressLine2 first 100,
		"PATIENT_ADDRESS_CITY": patient.city first 30,
		"PATIENT_ADDRESS_STATE": patient.state,
		"PATIENT_ADDRESS_ZIP": patient.zip first 5,
		"PATIENT_PHONE_MOBILE": patient.cellPhone first 10,
		"PATIENT_PHONE_HOME": patient.homePhone first 10,
		"INSURER_1": patient.insurer1 first 60,
		"INSURANCE_PLAN_1": null,
		"INSURANCE_NUMBER_1": patient.insuranceNumber1 first 75,
		"INSURER_2": patient.insurer2 first 60,
		"INSURANCE_PLAN_2": null,
		"INSURANCE_NUMBER_2": patient.insuranceNumber2 first 75,
		"ATTRIBUTED_PROVIDER_FIRST_NAME_1": patient.providerFirstName1 first 50,
		"ATTRIBUTED_PROVIDER_LAST_NAME_1": patient.providerLastName1 first 60,
		"ATTRIBUTED_PROVIDER_HONORIFICS_1": patient.providerHonorifics1 first 10,
		"ATTRIBUTED_PROVIDER_NPI_1": patient.providerNpi1,
		"ATTRIBUTED_PROVIDER_PHONE_1": null,
		"ATTRIBUTED_PROVIDER_FAX_1": null,
		"ATTRIBUTED_PROVIDER_EMAIL_1": null,
		"ATTRIBUTED_PROVIDER_TYPE_1": null,
		"PRACTICE_NAME_1": null,
		"PRACTICE_PHONE_1": null,
		"PRACTICE_FAX_1": null,
		"PRACTICE_EMAIL_1": null,
		"PROGRAM_1": null
	}
}

fun mapMinnesotaADTPatient(patient: Object) = do 
{
	{
		"Member_Status": "ADD",
		"Patient_ID": patient.elationPatientId,
		"First_Name": patient.firstName,
		"Middle_Name": patient.middleName,
		"Last_Name": patient.lastName,
		"Address_1": patient.addressLine1,
		"Address_2": patient.addressLine2,
		"City": patient.city,
		"State": patient.state,
		"Zip": patient.zip,
		"Birthdate": (patient.dateOfBirth as Date) as String {format: "uuuuMMdd" },
		"Gender": if ((upper(patient.sex) first 1) != "M" and (upper(patient.sex) first 1) != "F") "U" else (upper(patient.sex) first 1),
		"Home_Phone": patient.homePhone first 10,
		"Cell_Phone": patient.cellPhone first 10,
		"Care_Program": patient.careProgram,
		"MCO": patient.mco,
		"Care_Manager": patient.careManager
	}
}