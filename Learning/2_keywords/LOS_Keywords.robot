*** Settings ***
Documentation    Keywords for API
Resource      ../imports.robot


*** Keywords ***

[Keyword] - Register Loan Success


#create a HTTP session to LOS server
    Create Session    session_login    ${los_base_url}
    
    #Headers data into API include content type and user agent (if needed)
    ${headers}=    Create Dictionary    
    ...    Content-Type=${content_type}
    ...    User-Agent=${user_agent}

    #Body data in API
    ${dic_loanContactInformations}=    Create Dictionary
    ...    refType=${refType}
    ...    refFullName=${refFullName}
    ...    refPhoneNumber=${refPhoneNumber}
    ...    refDob=${refDob}
    ...    refEmail=${refEmail}
    ...    refAddress=${refAddress}
    
    @{list_loanContactInformations}=    Create List    ${dic_loanContactInformations}

    ${dic_loanJobInformation}=    Create Dictionary
    ...    preTaxIncome=${preTaxIncome}
    ...    companyName=${companyName}
    ...    companyAddress=${companyAddress}
    ...    expense=${expense}

    ${loanPersonalInformation}=    Create Dictionary
    ...    fullName=${fullName}
    ...    phoneNumber=${phoneNumber}
    ...    dateOfBirth=${dateOfBirth}
    ...    emailAddress=${emailAddress}
    ...    address=${address}
    ...    idCardNumber=${idCardNumber}
    ...    idType=${idType}

    ${body}=    Create Dictionary    
    ...    userId=${userId}
    ...    loanProductId=${loanProductId}
    ...    uuid=${uuid}
    ...    loanAmount=${loanAmount}
    ...    interestRate=${interestRate}
    ...    loanTerm=${loanTerm}
    ...    status=${status}
    ...    loanContactInformations=@{list_loanContactInformations}
    ...    loanJobInformation=&{dic_loanJobInformation}
    ...    loanPersonalInformation=&{loanPersonalInformation}

    log to console    ------\n ${body}

    #Send request to server with method Post, uri, header and body
    ${response}=    Post Request    session_login    uri=${post_registerloan_url}    headers=${headers}    data=${body} 
    
    #Validate API
    ${status_code}=    Convert To String    ${response.status_code}
    ${response_body}=    Convert To String    ${response.content}

    Should Be Equal    ${status_code}    200
    # Should Contain    ${response_body}    token_type
    Request Should Be Successful    ${response}