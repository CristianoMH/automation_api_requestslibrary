*** Settings ***
Documentation    Keywords for API using REST library
Resource      ../imports.robot

*** Keywords ***

[POST][200] - Success - Register Loan
    [Arguments]    ${headers}    ${body} 
    REST.post       
        ...    ${los_base_url}/${post_registerloan_url}
        ...    headers=${headers}
        ...    body=${body}
    rest extract
    [Common][Verify] - Http status code is "200"
    [Common][Verify] - Status code is "200"

[Pre_Request] - Register Loan - Body
    [Arguments]     ${output}=body    ${remove_null}=${True}   ${remove_empty}=${True}    &{arg_dic}
    ${schema}              catenate     SEPARATOR=
    ...    {
    ...   "userId":"string",
    ...   "loanProductId":"string",
    ...   "uuid":"string",
    ...   "loanAmount":"string",
    ...   "interestRate":"string",
    ...   "loanTerm":"string",
    ...   "status":"string",
    ...   "loanContactInformations": [
    ...    {
    ...     "refType": "string",
    ...     "refFullName": "string",
    ...     "refPhoneNumber": "string",
    ...     "refDob": "string",
    ...     "refEmail": "string",
    ...     "refAddress": "string"
    ...    }
    ...   ],
    ...   "loanJobInformation": {
    ...    "preTaxIncome":"string",
    ...    "companyName":"string",
    ...    "companyAddress":"string",
    ...    "expense":"string"
    ...   },
    ...   "loanPersonalInformation": {
    ...    "fullName":"string",
    ...    "phoneNumber":"string",
    ...    "dateOfBirth":"string",
    ...    "emailAddress":"string",
    ...    "address":"string",
    ...    "idCardNumber":"string",
    ...    "idType":"string"
    ...    }
    ...   }
    
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    
    [Common] - Set test variable       name=${output}      value=${body}