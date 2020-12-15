*** Settings ***
Documentation    Suite description
Resource          ../imports.robot

*** Test Cases ***

Register Loan
    [Tags]    register
    [Pre_Request] - Register Loan - Body   
    ...    $.userId=${userId}
    ...    $.loanProductId=${loanProductId}
    ...    $.uuid=${uuid}
    ...    $.loanAmount=${loanAmount}
    ...    $.interestRate=${interestRate}
    ...    $.loanTerm=${loanTerm}
    ...    $.status=${status}
    ...    $.loanContactInformations[0].refType=${refType}
    ...    $.loanContactInformations[0].refFullName=${refFullName}
    ...    $.loanContactInformations[0].refPhoneNumber=${refPhoneNumber}
    ...    $.loanContactInformations[0].refDob=${refDob}
    ...    $.loanContactInformations[0].refEmail=${refEmail}
    ...    $.loanContactInformations[0].refAddress=${refAddress}
    ...    $.loanJobInformation.preTaxIncome=${preTaxIncome}
    ...    $.loanJobInformation.companyName=${companyName}
    ...    $.loanJobInformation.companyAddress=${companyAddress}
    ...    $.loanJobInformation.expense=${expense}
    ...    $.loanPersonalInformation.fullName=${fullName}
    ...    $.loanPersonalInformation.phoneNumber=${phoneNumber}
    ...    $.loanPersonalInformation.dateOfBirth=${dateOfBirth}
    ...    $.loanPersonalInformation.emailAddress=${emailAddress}
    ...    $.loanPersonalInformation.address=${address}
    ...    $.loanPersonalInformation.idCardNumber=${idCardNumber}
    ...    $.loanPersonalInformation.idType=${idType}
    
    [Common][Pre_Request] - Authorization headers
    [POST][200] - Success - Register Loan
    ...     headers=${headers}
    ...     body=${body}