*** Settings ***


*** Keywords ***

[Common] - Set test variable
    [Arguments]    ${name}    ${value}
    Set Test Variable    \${${name}}    ${value}

[Common] - Set suite variable
    [Arguments]    ${name}    ${value}
    Set Suite Variable    \${${name}}    ${value}

[Common] - Get value from response body
    [Arguments]    ${response_content}    ${json_path}
    ${data}=    To Json    ${response_content}
    ${value}=    Get Value From Json    ${data}    ${json_path}
    [Return]    ${value[0]}
     
