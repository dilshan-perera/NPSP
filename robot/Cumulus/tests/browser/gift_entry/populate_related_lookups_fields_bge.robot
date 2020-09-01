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
    ...                                                    Field_Type=Lookup
    ...                                                    Related_To=Lead
    ...                                                    Field_Name=Lead Lookup (Lead Object)
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
    
    ${ns} =  Get NPSP Namespace Prefix
    Set suite variable    ${ns}

*** Test Cases ***

Open Fields And Relationships  Lead