*** Settings ***
Library    Selenium2Library
Library    ../Libraries/Rest.py
Library    String        
Variables    ../Objects/Google_Objects.py
Variables    ../Settings/Settings.py
Resource    ../Keywords/Google_Keywords.txt

*** Variables ***
${ei}    4V6eW-2hH4aRkwWVyYTIBQ
${token}    ebdba895-9f59-ec22-f817-98e60c04f8f1 
${valid_lenght_api}    7470
${invalid_lenght_api}   7480
${valid_lenght_ui}    128
${invalid_lenght_ui}    129
${long_message}    is too long

*** Test Cases ***
Verify Querry Lenght Is Set Properly For Api
    [Documentation]    Test that if random string reaches specific 
    ...    lenght, google returns 413 response code.
    ${string}=    Generate Random String    ${valid_lenght_api}
    Send Get Request    ${api_endpoint}    {"ei": "${ei}", "q": "${string}", "oq": "${string}", "cache-control": "no-cache", "postman-token": "${token}"}
    ${code}=    Get Response Code
    Should Be Equal As Integers    ${code}    200 
    ${string}=    Generate Random String    ${invalid_lenght_api}
    Send Get Request    ${api_endpoint}    {"ei": "${ei}", "q": "${string}", "oq": "${string}", "cache-control": "no-cache", "postman-token": "${token}"}
    ${code}=    Get Response Code
    Should Be Equal As Integers    ${code}    413
    
Verify Querry Lenght Using Google UI
    [Documentation]    Test that if random string reaches specific 
    ...    lenght, google returns 413 response code.
    [Setup]    Open Google    ${browser}
    [Teardown]    Close Browser
    Search For Random String    ${valid_lenght_ui}
    Page Should Not Contain    ${long_message}
    Capture Page Screenshot    
    Go Back
    Search For Random String    ${invalid_lenght_ui}
    Page Should Contain    ${long_message}
    Capture Page Screenshot    
    
*** Keywords ***
Search For Random String
    [Arguments]    ${lenght}
    ${string}=    Generate Random String    ${lenght}
    Input Text    ${search_box}    ${string}
    Wait Until Page Contains Element    ${search_btn}       
    Click Button    ${search_btn}
   