*** Settings ***

Resource        robot/Cumulus/resources/NPSP.robot
Library         cumulusci.robotframework.PageObjects
...             robot/Cumulus/resources/GiftEntryPageObject.py
...             robot/Cumulus/resources/NPSPSettingsPageObject.py
...             robot/Cumulus/resources/AdvancedMappingPageObject.py
...             robot/Cumulus/resources/ObjectMangerPageObject.py
Suite Setup     Run keywords
...             Open Test Browser
...             Setup Test Data
...             Enable Gift Entry
Suite Teardown  Capture Screenshot and Delete Records and Close Browser

*** Variables ***


*** Keywords ***
Setup Test Data
  Create Customfield In Object Manager
  ...                                                    Object=Lead
  ...                                                    Field_Type=Lookup
  ...                                                    Related_To=Account
  ...                                                    Field_Name=Account Lookup
  Create Customfield In Object Manager
  ...                                                    Object=Lead
  ...                                                    Field_Type=Text
  ...                                                    Field_Name=Lead Imported Status
  Create Customfield In Object Manager
  ...                                                    Object=NPSP Import Object
  ...                                                    Field_Type=Text
  ...                                                    Field_Name=Lead Company
  Create Customfield In Object Manager
  ...                                                    Object=NPSP Import Object
  ...                                                    Field_Type=Text
  ...                                                    Field_Name=Lead Last Name
 Create Customfield In Object Manager
  ...                                                    Object=NPSP Import Object
  ...                                                    Field_Type=Lookup
  ...                                                    Related_To=Lead
  ...                                                    Field_Name=Lead Lookup (Lead Object)
    

  #Create contact record with fields other than last name (include lookups and picklist)
  #Use preferred email

  #Create lead record with company name

  #Create org account record fields other than last

  #Create Opportunity account with Description field filled in and stage

  #Create CustomObject1 Record

  ${template} =                                         Generate Random String
  Set suite variable                                    ${template}


*** Test Cases ***
Verify Fields Related to Lookups Populate on Batch Gift Entry Form
  [Documentation]                                       Creates field mappings for lookups so related fields are populated on the
  ...                                                   batch gift entry form.
  [tags]                                                unstable  feature:GE  ticket_goes_here
  #Create field mappings in Advanced Mapping
  Click Configure Advanced Mapping

  #keyword goes here to build new grouping

  View Field Mappings Of The Object                     Lead
  Create Mapping If Doesnt Exist                        Lead Company (Lead_Company__c)  Company ()
  Reload Page
  Create Mapping If Doesnt Exist                        Lead Last Name (Lead_Last_Name__c)  Last Name ()
  Go To Page                                            Landing                         GE_Gift_Entry  
  Click Link                                            Templates
  Click Gift Entry Button                               Create Template
  Current Page Should Be                                Template                        GE_Gift_Entry
  Enter Value In Field
  ...                                                   Template Name=${template}
  ...                                                   Description=This is created by automation script  
  Click Gift Entry Button                               Next: Form Fields
  Perform Action on Object Field                        select  CustomObject1  C1_phone
  Perform Action on Object Field                        select  CustomObject1  C1_text
  Perform Action on Object Field                        select  Opportunity    Record Type ID
  Perform Action on Object Field                        select  Opportunity    Donation Imported
  Perform Action on Object Field                        select  Opportunity    Stage
  Perform Action on Object Field                        select  Lead           Lead Lookup
  Perform Action on Object Field                        select  Lead           Lead Company
  Perform Action on Object Field                        select  Lead           Lead Last Name
  Fill Template Form
  ...                                                   Data Import: Contact1 Imported=${contact_name}                                    


  #Set template default to created contact to verify fields populate on form render

