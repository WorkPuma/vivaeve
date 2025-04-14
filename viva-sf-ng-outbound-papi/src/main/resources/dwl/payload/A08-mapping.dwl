%dw 2.0
output application/json
---
 {
 "Data": {
        "ADT_A08": {
            "MSH": {
                "MSH-10": uuid(),
                "MSH-11": {
                    "PT-01": p('mshsegment.PT-01')
                },
                "MSH-12": p('mshsegment.MSH-12'),
                "MSH-03": {
                    "HD-01":  p('mshsegment.MSH-03')
                },
                "MSH-04": {
		
                    "HD-01": p('mshsegment.MSH-04')
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
                    "CM_MSG-02": p('mshsegment.MSH-09-MSG-02-A08'),
                    "CM_MSG-01": p('mshsegment.MSH-09-MSG-01-ADT')
                }
            },
//            "NK1": [
//                {
//                    "NK1-02": [
//                        {
//                            "XPN-02": "TEST",
//                            "XPN-01": "SPOUSE"
//                        }
//                    ],
//                    "NK1-01": 1,
//                    "NK1-03": {
//                        "CE_0063-01": "SPO"
//                    }
//                }
//            ],
//            "GT1": [
//                {
//                    "GT1-05": [
//                        {
//                            ("XAD-04":payload.data.payload.Guarantor_State__c) if ((payload.data.payload.Guarantor_State__c?) and (payload.data.payload.Guarantor_State__c != null)),
//                            ("XAD-05":payload.data.payload.Guarantor_Zip_Code__c as String) if ((payload.data.payload.Guarantor_Zip_Code__c?) and (payload.data.payload.Guarantor_Zip_Code__c != null)),
//                            ("XAD-03":payload.data.payload.Guarantor_City__c) if ((payload.data.payload.Guarantor_City__c?) and (payload.data.payload.Guarantor_City__c != null)),
//                            ("XAD-01":payload.data.payload.Guarantor_Street__c) if ((payload.data.payload.Guarantor_Street__c?) and (payload.data.payload.Guarantor_Street__c != null))
//                        }
//                    ],
//                    "GT1-06": [
//                        {
//                         //   "XTN-04": "DDDD@DDD.COM",
//                            ("XTN-01":payload.data.payload.Guarantor_Phone__c as String) if ((payload.data.payload.Guarantor_Phone__c?) and (payload.data.payload.Guarantor_Phone__c != null))
//                          //  "XTN-07": 2202852,
//                         //   "XTN-06": 658
//                        }
//                    ],
//                    "GT1-03": [
//                        {
//                        	("XPN-02": payload.data.payload.Primary_Insured_Name__c) if ((payload.data.payload.Primary_Insured_Name__c?) and (payload.data.payload.Primary_Insured_Name__c != null))
//                          //  "XPN-01": "TEST"
//                            
//                        }
//                    ],
//                    "GT1-01": 1,
//                   ("GT1-11": payload.data.payload.Primary_Holder_Relationship__c) if ((payload.data.payload.Primary_Holder_Relationship__c?) and (payload.data.payload.Primary_Holder_Relationship__c != null)),
//                   ("GT1-20":payload.data.payload.Guarantor_Employment_Status__c) if ((payload.data.payload.Guarantor_Employment_Status__c?) and (payload.data.payload.Guarantor_Employment_Status__c != null)),
//                  
//                   "GT1-09":  if ((payload.data.payload.Guarantor_Gender__c?)) 
//    if (payload.data.payload.Guarantor_Gender__c == "Female") "F" 
//    else if (payload.data.payload.Guarantor_Gender__c == "Male") "M" 
//    else payload.data.payload.Guarantor_Gender__c
//    else "",
//                    "GT1-08": {
//                        ("TS-01": payload.data.payload.Primary_Holder_DOB__c) if ((payload.data.payload.Primary_Holder_DOB__c?) and (payload.data.payload.Primary_Holder_DOB__c != null))
//                    }
//                }
//            ],
//  "INSURANCE": [
 //               {
  //                  "IN1": {
//                        "IN1-20": "Y",
 //                       "IN1-02": {

//						("CE_0072-01": payload.data.payload.Insurance_Plan_Id_Identifier__c) if ((payload.data.payload.Insurance_Plan_Id_Identifier__c?) and (payload.data.payload.Insurance_Plan_Id_Identifier__c != null))
//						("CE_0072-02": payload.data.payload.Insurance_Plan_ID_Text__c) if ((payload.data.payload.Insurance_Plan_ID_Text__c?) and (payload.data.payload.Insurance_Plan_ID_Text__c != null))
 //                   },
  //                      "IN1-01": 1,
//                        ("IN1-12": payload.data.payload.Effective_Date__c) if ((payload.data.payload.Effective_Date__c?) and (payload.data.payload.Effective_Date__c != null)),
//                         "IN1-32": "P",
//                       "IN1-43": if ((payload.data.payload.Patient_Gender_2__c?) and (payload.data.payload.Patient_Gender_2__c != null)) if (payload.data.payload.Patient_Gender_2__c == "Female") "F" else if (payload.data.payload.Patient_Gender_2__c == "Male") "M" else payload.data.payload.Patient_Gender_2__c else null,
//                      ( "IN1-17": payload.data.payload.Insureds_Relationship__c) if ((payload.data.payload.Insureds_Relationship__c?) and (payload.data.payload.Insureds_Relationship__c != null)),
//                       "IN1-16": {
//                           ("XPN-02":payload.data.payload.Name.FirstName) if ((payload.data.payload.Name.FirstName?) and (payload.data.payload.Name.FirstName != null)),
//                           ("XPN-01": payload.data.payload.Name.LastName) if ((payload.data.payload.Name.LastName?) and (payload.data.payload.Name.LastName != null))
//                       },
//                        "IN1-49": {
//                            "CX-01": "328306539"
//                        },
 //                       "IN1-04": {
//							("XON-01": payload.data.payload.Insurance_Company_Picklist__c) if ((payload.data.payload.Insurance_Company_Picklist__c?) and (payload.data.payload.Insurance_Company_Picklist__c != null))	
  //                      },
//                        "IN1-15": "CI",
//                        "IN1-37": {
//                            "CP-01": {
//                                "MO-01": 0.00
//                            }
//                        },
 //                       "IN1-03": {
  //                         ( "CX-01": payload.data.payload.Insurance_Company_ID__c) if ((payload.data.payload.Insurance_Company_ID__c?) and (payload.data.payload.Insurance_Company_ID__c != null))
//                            "CX-02": "HF1",
//                            "CX-05": "1"
 //                                       },
//                      ( "IN1-36": payload.data.payload.Insurance_Member_ID__c) if ((payload.data.payload.Insurance_Member_ID__c?) and (payload.data.payload.Insurance_Member_ID__c != null)),
//                        "IN1-19": {
//                           ("XAD-04": payload.data.payload.MailingAddress.State) if ((payload.data.payload.MailingAddress.State?) and (payload.data.payload.MailingAddress.State != null)),
 //                          ("XAD-05": payload.data.payload.MailingAddress.PostalCode) if ((payload.data.payload.MailingAddress.PostalCode?) and (payload.data.payload.MailingAddress.PostalCode != null)),
 //                          ("XAD-03": payload.data.payload.MailingAddress.City) if ((payload.data.payload.MailingAddress.City?) and (payload.data.payload.MailingAddress.City != null)),
//					   ("XAD-01": payload.data.payload.MailingAddress.Street) if ((payload.data.payload.MailingAddress.Street?) and (payload.data.payload.MailingAddress.Street != null))
 //                       },
//                        "IN1-18": {
//                            "TS-01": "20020330000000"
//                        }
 //                   }
 //               }
  //          ],
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
                        ("CX-01": payload.data.payload.ChangeEventHeader.recordIds[0]) if ((payload.data.payload.ChangeEventHeader.recordIds[0]?) and (payload.data.payload.ChangeEventHeader.recordIds[0] != null))
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
  //              "PID-02": {
   //                 ("CX-01": payload.data.payload.ChangeEventHeader.recordIds[0]) if ((payload.data.payload.ChangeEventHeader.recordIds[0]?) and (payload.data.payload.ChangeEventHeader.recordIds[0] != null))
   //             },
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
          //             "PV1": {
          //     "PV1-02": "O",
           //    "PV1-03": {
           //        ("PL-09": vars.appLocation) if ((vars.appLocation?) and (vars.appLocation != null)),
           //         ("PL-01": vars.appLocation) if ((vars.appLocation?) and (vars.appLocation != null))
          //      },
        //        "PV1-01": 1,
                
      //          "PV1-08": [
      //              {  
       //                 ("XCN-02": payload.data.payload.Referring_Doctor_Contact__c) if ((payload.data.payload.Referring_Doctor_Contact__c?) and (payload.data.payload.Referring_Doctor_Contact__c != null)),
        //                ("XCN-03": payload.data.payload.Referring_Doctor_Contact__c) if ((payload.data.payload.Referring_Doctor_Contact__c?) and (payload.data.payload.Referring_Doctor_Contact__c != null))
       //             }
       //         ],
        //        "PV1-07": [
        //            {
         //             ( "XCN-01": vars.providerId) if ((vars.providerId?) and (vars.providerId != null))
          //          }
          //      ]
          //  },
            ("PD1":  {
                "PD1-04": [
                    {
                        ("XCN-02": payload.data.payload.Primary_Care_Provider__c) if ((payload.data.payload.Primary_Care_Provider__c?) and (payload.data.payload.Primary_Care_Provider__c != null)),
                        ("XCN-03": payload.data.payload.Primary_Care_Provider__c) if ((payload.data.payload.Primary_Care_Provider__c?) and (payload.data.payload.Primary_Care_Provider__c != null))
                        //"XCN-01": "1538792528"
                    }
                ]
        }) if (payload.data.payload.Primary_Care_Provider__c?)
        }
    },
    "Id": "ADT_A08",
    "Name": "ADT_A08"
}
