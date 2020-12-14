*** Settings ***


*** Keywords ***

[Common] - Set test variable
    [Documentation]    Makes a variable available everywhere within the scope of the current test
    [Arguments]    ${name}    ${value}
    Set Test Variable    \${${name}}    ${value}

[Common] - Set suite variable
    [Documentation]    Makes a variable available everywhere within the scope of the current suite
    [Arguments]    ${name}    ${value}
    Set Suite Variable    \${${name}}    ${value}

[Common] - Get value from response body
    [Documentation]    get value from json path in response body
    [Arguments]    ${response_content}    ${json_path}
    ${data}=    To Json    ${response_content}
    ${value}=    Get Value From Json    ${data}    ${json_path}
    [Return]    ${value[0]}
     
