%dw 2.0
output application/json
---
{
    "Data": {
        "SIU_S14": {
            "RESOURCES": [
                {
                    "LOCATION_RESOURCE": [
                        {
                            "AIL": {
                              "AIL-01": 1,
                                "AIL-03": {
                                ("PL-01": vars.appLocationId as String) if ((vars.appLocationId?) and (vars.appLocationId != null)),
                                    "PL-04": {
                                        ("HD-01": vars.appLocation) if ((vars.appLocation?) and (vars.appLocation != null)),
                                    }
                                }
                            }
                        }
                    ],
             //       "RGS": {},
                    "PERSONNEL_RESOURCE": [
                        {
                            "AIP": {
                          //      "AIP-01": 1,
                                "AIP-03": {
                                     ("XCN-02": vars.providerLastName) if ((vars.providerLastName?) and (vars.providerLastName != null)),
                                     ( "XCN-03": vars.providerFirstName) if ((vars.providerFirstName?) and (vars.providerFirstName != null)),
                                     ("XCN-01": vars.providerId as String) if ((vars.providerId?) and (vars.providerId != null)),
                                }
                            }
                        }
                    ]
                }
            ],
            "MSH": {
                "MSH-10":  vars.correlationId,
                "MSH-11": {
                    "PT-01": p('mshsegment.PT-01')
                },
                "MSH-12": p('mshsegment.MSH-12'),
                "MSH-03": {
                    "HD-01": p('mshsegment.MSH-03'),
                },
                "MSH-04": {
                    "HD-01":p('mshsegment.MSH-04'),
                },
                "MSH-05": {
                    "HD-01": p('mshsegment.MSH-05')
                },
                "MSH-06": {
                    "HD-01": p('mshsegment.MSH-06-HD-01'),
                    "HD-02": p('mshsegment.MSH-06-HD-02')
                },
                "MSH-07": {
                    ("TS-01": payload.data.payload.LastModifiedDate) if ((payload.data.payload.LastModifiedDate?) and (payload.data.payload.LastModifiedDate != null))
                },
                "MSH-09": {
                    "CM_MSG-02": p('mshsegment.MSH-09-MSG-02-s14'),
                    "CM_MSG-01": p('mshsegment.MSH-09-MSG-01')
                }
            },
            "SCH": {
                "SCH-02": {
                    "EI-01":  if (vars.updateFields.NextGen_ID__c[0]? and vars.updateFields.NextGen_ID__c[0] != null and ((vars.updateFields.NextGen_ID__c[0] as String) matches /^[0-9]+$/))  vars.updateFields.NextGen_ID__c[0] else payload.data.payload.ChangeEventHeader.recordIds[0]
                },
                "SCH-11": [
                    {
                      "TQ-05": {
                            "TS-01": vars.scheduledEndTime
                        },
                        "TQ-04": {
                            "TS-01": vars.scheduledStartTime
                        }
                    }
                ],
                "SCH-10": {
                     "CE-01": "M"
                },
 //               "SCH-06": {
  //                  ("CE-01": payload.data.payload.Name) if ((payload.data.payload.Name?) and (payload.data.payload.Name != null))
   //             },
//                "SCH-16": {
//                    "XCN-02": "CATALANO",
//                    "XCN-03": "JESSICA",
//                    "XCN-01": "1538792528"
//                },
                "SCH-25": {
                    ("CE_0278-01": payload.data.payload.Status) if ((payload.data.payload.Status?) and (payload.data.payload.Status != null))
                },
                ("SCH-09": vars.duration as Number) if ((vars.duration?) and (vars.duration != null)),
                "SCH-08": {
                    ("CE_0277-01": vars.appointmentType) if ((vars.appointmentType?) and (vars.appointmentType != null))
                },
                "SCH-07": {
                   ( "CE_0276-01": payload.data.payload.Comments) if ((payload.data.payload.Comments?) and (payload.data.payload.Comments != null))
                }
            },
            "PATIENT": [
                {
                    "PID": {
                        "PID-05": [
                            {
                            	
                                ("XPN-02": vars.queryData[0].FirstName replace /[^a-zA-Z]/ with "") if ((vars.queryData[0].FirstName?) and (vars.queryData[0].FirstName != null)),
                                ("XPN-03": vars.queryData[0].MiddleName replace /[^a-zA-Z]/ with "") if ((vars.queryData[0].MiddleName?) and (vars.queryData[0].MiddleName != null)),
                                ("XPN-01": vars.queryData[0].LastName replace /[^a-zA-Z]/ with "") if ((vars.queryData[0].LastName?) and (vars.queryData[0].LastName != null))
                            }
                        ],
                        "PID-04": [
                            {
                                ( "CX-01": payload.data.payload.ContactId) if ((payload.data.payload.ContactId?) and (payload.data.payload.ContactId != null))
                            }
                        ],
                        "PID-15": {
                            ("CE_0296-01": vars.languageField) if ((vars.languageField?) and (vars.languageField != null))
                        },
                        "PID-03": [
                            {
                                ("CX-01": vars.queryData[0].HealthFusion_Patient_Record_ID__c) if ((vars.queryData[0].HealthFusion_Patient_Record_ID__c?) and (vars.queryData[0].HealthFusion_Patient_Record_ID__c != null))
                            }
                        ],
   //                     "PID-02": {
    //                        ( "CX-01": payload.data.payload.ContactId) if ((payload.data.payload.ContactId?) and (payload.data.payload.ContactId != null))
    //                    },
                      "PID-13": [
                    {
                        "XTN-04": if ((vars.queryData[0].Email) != null and (vars.queryData[0].Email?)) vars.queryData[0].Email else ("tahmed@vivaeve.com"),
                        "XTN-01": if ((vars.queryData[0].Phone) != null and (vars.queryData[0].Phone?)) vars.queryData[0].Phone else ("212.988.2111")
            
                    }
                ],
                "PID-01": 1,
                "PID-12": "+1",
                "PID-11": [
                    {
			          "XAD-05": if ((vars.queryData[0].MailingPostalCode) != null and (vars.queryData[0].MailingPostalCode?)) vars.queryData[0].MailingPostalCode else ("11375"),
                      "XAD-04":  if ((vars.queryData[0].MailingState) != null and (vars.queryData[0].MailingState?)) vars.queryData[0].MailingState else ("NY"),
                      "XAD-06": if ((vars.queryData[0].MailingCountry) != null and (vars.queryData[0].MailingCountry?)) vars.queryData[0].MailingCountry else ("USA"),
                      "XAD-03": if ((vars.queryData[0].MailingCity) != null and (vars.queryData[0].MailingCity?)) vars.queryData[0].MailingCity else ("Forest Hills"),
                      "XAD-01":  if ((vars.queryData[0].MailingStreet) != null and (vars.queryData[0].MailingStreet?)) vars.queryData[0].MailingStreet else ("63rd Road")
                    }
                ],
                        "PID-22": if ((vars.queryData[0].Patient_Ethnicity__c) != null and (vars.queryData[0].Patient_Ethnicity__c?)) vars.queryData[0].Patient_Ethnicity__c else ("White"),
                        "PID-10": if ((vars.queryData[0].Patient_Race__c) != null and (vars.queryData[0].Date_of_Birth__c?)) vars.queryData[0].Patient_Race__c else ("White"),
                        "PID-08": if ((vars.queryData[0].Patient_Gender_2__c?) and (vars.queryData[0].Patient_Gender_2__c != null)) 
    if (vars.queryData[0].Patient_Gender_2__c == "Female") "F" 
    else if (vars.queryData[0].Patient_Gender_2__c == "Male") "M" 
    else vars.queryData[0].Patient_Gender_2__c
    else "F",
                        "PID-07": {
                              "TS-01":  if ((vars.queryData[0].Date_of_Birth__c?) and (vars.queryData[0].Date_of_Birth__c != null)) (vars.queryData[0].Date_of_Birth__c as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else ("19000101")
                }
            },
//                   "PV1": {
//                       "PV1-02": "O",
//                        "PV1-03": {
//                            "PL-09": "FOREST HILLS",
//                            "PL-04": {
//                                "HD-01": "1275017"
//                            }
//                        },
//                        "PV1-11": {
//                            "PL-09": "ASTER OB/GYN",
//                            "PL-01": "1288491",
//                            "PL-04": {
//                                "HD-01": "1288491"
//                            }
//                        },
//                        "PV1-44": {
//                            "TS-01": "20240720060000"
//                        },
//                        "PV1-01": 1,
//                        "PV1-45": {
//                            "TS-01": "20240720061500"
//                        },
//                        "PV1-08": [
//                            {
//                                "XCN-02": "MAGYAR",
//                                "XCN-03": "YASHA",
//                                "XCN-01": "1154581619"
//                            }
//                        ],
//                        "PV1-19": {
//                            "CX-01": "461875928"
//                        },
//                        "PV1-39": "1266378;FOREST HILLS MEDICAL SERVICES;FORESTHMS",
//                        "PV1-07": [
//                            {
//                                "XCN-02": "CATALANO",
//                                "XCN-03": "JESSICA",
//                                "XCN-01": "1538792528"
//                            }
//                        ]
//                  }
                }
            ]
        }
    },
    "Id": "SIU_S14",
    "Name": "SIU_S14"
}