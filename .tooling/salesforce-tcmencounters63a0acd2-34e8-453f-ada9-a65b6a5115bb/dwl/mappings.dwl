%dw 2.0

fun mapEncounterToClinicalEncounter(encounter: Object, clinicalEncounterId: String, accountId: String, recordTypeId: String): Object =
{
	"Id": 
		if (!isEmpty(clinicalEncounterId))
			clinicalEncounterId
		else null,
	"Encounter_Id__c":
		if (!isEmpty(encounter.ENCOUNTER_ID))
			encounter.ENCOUNTER_ID
		else null,
	"PatientId": accountId,
	"StartDate":
		if (!isEmpty(encounter.ENCOUNTER_START_DATE))
			encounter.ENCOUNTER_START_DATE  ++ "T05:00:00Z" //(JW) HACK: GMT-5 is an assumption
		else null,
	"EndDate": 
		if (!isEmpty(encounter.ENCOUNTER_END_DATE))
			encounter.ENCOUNTER_END_DATE  ++ "T05:00:00Z" //(JW) HACK: GMT-5 is an assumption
		else null,
	"Status": encounter.ENCOUNTER_STATUS,
	"Admitted_From__c":
		if (!isEmpty(encounter.ADMIT_SOURCE_DESCRIPTION))
			encounter.ADMIT_SOURCE_DESCRIPTION
		else null,
	"Discharged_Disposition__c":
		if (!isEmpty(encounter.DISCHARGE_DISPOSITION_DESCRIPTION))
			encounter.DISCHARGE_DISPOSITION_DESCRIPTION
		else null,
	"Diagnosis__c": 
		if (!isEmpty(encounter.PRIMARY_DIAGNOSIS_DESCRIPTION))
			encounter.PRIMARY_DIAGNOSIS_DESCRIPTION
		else null,
	"Facility_Name__c": 
		if (!isEmpty(encounter.FACILITY_NAME))
			encounter.FACILITY_NAME
		else null,
	"Primary_Diagnosis_Code__c":
		if (!isEmpty(encounter.PRIMARY_DIAGNOSIS_CODE))
			encounter.PRIMARY_DIAGNOSIS_CODE
		else null,
	"Tier_Level__c":
		if (!isEmpty(encounter.PATIENT_TIER))
			encounter.PATIENT_TIER
		else null,
	"Phone__c":
		if (!isEmpty(encounter.BAMBOO_MOBILE_PHONE))
			encounter.BAMBOO_MOBILE_PHONE
		else null,
	"Bamboo_Home_Phone__c":
		if (!isEmpty(encounter.BAMBOO_HOME_PHONE))
			encounter.BAMBOO_HOME_PHONE
		else null,
	"Bamboo_Patient_Phone__c":
		if (!isEmpty(encounter.BAMBOO_PATIENT_PHONE))
			encounter.BAMBOO_PATIENT_PHONE
		else null,
	"MNEAS_Patient_Phone__c":
		if (!isEmpty(encounter.MNEAS_PATIENT_PHONE))
			encounter.MNEAS_PATIENT_PHONE
		else null,
	"MNEAS_Home_Phone__c":
		if (!isEmpty(encounter.MNEAS_HOME_PHONE))
			encounter.MNEAS_HOME_PHONE
		else null,
	"MNEAS_Cell_Phone__c":
		if (!isEmpty(encounter.MNEAS_CELL_PHONE))
			encounter.MNEAS_CELL_PHONE
		else null,
	"MNEAS_Work_Phone__c":
		if (!isEmpty(encounter.MNEAS_WORK_PHONE))
			encounter.MNEAS_WORK_PHONE
		else null,
	"Readmission__c":
		if (!isEmpty(encounter.READMISSION_FLAG))
			encounter.READMISSION_FLAG
		else null,
	"SourceSystem":
		if (!isEmpty(encounter.DATA_SOURCE))
			encounter.DATA_SOURCE
		else null,
	"Category": "Inpatient Encounter",
	"RecordTypeId": recordTypeId,
	"SourceSystemModified":
		if (!isEmpty(encounter.TUVA_LAST_RUN))
			encounter.TUVA_LAST_RUN
		else null
}