*** Settings ***
Documentation    Scope of this test is to verify 
...    that search function works as expected
Library    Selenium2Library
Variables    ../Objects/Google_Objects.py
Variables    ../Settings/Settings.py
Resource    ../Keywords/Google_Keywords.txt
Test Setup    Open Google    ${browser}
Test Teardown    Close Browser

*** Variables ***
${included_search}    Including results for avast software
${showing_search}    Showing results for avast software

*** Test Cases ***
Searching Using Button and Enter
    [Documentation]    Testing that search works on 
    ...    a button click as well as using Enter key.
    Search For Avast
    Page Should Contain Link    ${avast_url}
    Capture Page Screenshot    
    Search Avast Using Enter
    Page Should Contain Link    ${avast_url}
    Capture Page Screenshot    

Keyword Search
    [Documentation]    Verify that Search returns proper 
    ...    values and search results are well sorted.
    Search For Avast
    Page Should Contain Link    ${avast_url}
    Page Should Contain Link    ${avast_wiki_url}
    Avast Company Link Should Be Higher
    Capture Page Screenshot
    Go Back     
    Search For Avast Software
    Page Should Contain Link    ${avast_url} 
    Capture Page Screenshot 
    Go Back   
    Search For software Avast
    Page Should Contain Link    ${avast_about}
    Capture Page Screenshot          
    
Wiki Panel Presence
    [Documentation]    Verify that search results contains 
    ...    side panel with link to wikipedia.
    Search For Avast
    Verify Wiki Panel    ${wiki_panel}    ${avast_text}  
    Capture Page Screenshot
    Go Back    
    Search For Avast Software
    Verify Wiki Panel    ${wiki_panel}    ${avast_software_text} 
    Capture Page Screenshot
    Go Back      
    Search For Software Avast  
    Verify Wiki Panel    ${wiki_panel}    ${avast_software_text} 
    Capture Page Screenshot    
    
Suggestions
    [Documentation]    Verify that suggestion 
    ...    functions works as expected.
    Input Text    ${search_box}    Av
    Wait Until Page Contains Element    ${sugestion_element}0  
    Check Suggestion    ${sugestion_element}0    ast 
    Capture Page Screenshot    
    Input Text    ${search_box}    Ava
    Check Suggestion    ${sugestion_element}0    st
    Capture Page Screenshot    
    Input Text    ${search_box}    Avast
    Search Suggestions
    Capture Page Screenshot    
    
Misspell
    [Documentation]    Verify that google offers correct 
    ...    word if searched keyword is misspelled.
    Search For avst software
    Page Should Contain    ${included_search}
    Capture Page Screenshot    
    Search av$st software Using Enter
    Page Should Contain    ${showing_search}
    Capture Page Screenshot    
    Search av漢st software Using Enter
    Page Should Contain    ${showing_search}
    Capture Page Screenshot    

*** Keywords ***
Search ${keyword} Using Enter
    Input Text    ${search_box}    ${keyword}
    Press Key    ${search_box}    \\13
    
Avast Company Link Should Be Higher
    ${home_site}=    Get Vertical Position    ${avast_link}
    ${wiki_site}=    Get Vertical Position    ${wiki_link}
    Evaluate    ${wiki_site}>${home_site} 
    
Check Suggestion
    [Arguments]    ${element}    ${text}
    Wait Until Element Contains    ${element}    ${text}
       
Search Suggestions
    ${index}=    Set Variable    0
    :FOR    ${suggestion}    IN    @{suggest_objects}
    \   Check Suggestion       ${sugestion_element}${index}    ${suggestion}
    \   ${index}=    Evaluate    ${index}+1  

Verify Wiki Panel
    [Arguments]    ${panel}    ${text}   
    Wait Until Page Contains Element    ${panel}
    Element Should Contain    ${panel}    ${text}