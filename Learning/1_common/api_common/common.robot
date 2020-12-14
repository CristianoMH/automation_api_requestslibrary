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
    [Documentation]    Get value from json path in response body
    [Arguments]    ${response_content}    ${json_path}
    ${data}=    To Json    ${response_content}
    ${value}=    Get Value From Json    ${data}    ${json_path}
    [Return]    ${value[0]}
     
[Common][Pre_Request] - Authorization headers
    [Documentation]    Authorization header with content_type = application/json    
    [Arguments]  ${content_type}=application/json    ${output}=headers
    ${headers}    create dictionary   content-type=${content_type}
    [Common] - Set test variable    name=${output}    value=${headers}

[Common][Verify] - String field or null
    [Arguments]    ${field}    ${value}=${EMPTY}
    ${is_null}    run keyword and return status    REST.null    ${field}
    run keyword if    '${is_null}'=='False'    REST.string    ${field}    ${value}

[Common][Verify] - Integer field or null
    [Arguments]    ${prefix_field}    ${field}
    ${elements}    rest extract    ${prefix_field}[*]
    ${size}    get length    ${elements}
    FOR    ${i}    IN RANGE    0    ${size}
        ${is_null}    run keyword and return status    REST.null    ${prefix_field}[${i}].${field}
        run keyword if    '${is_null}'=='False'    REST.integer    ${prefix_field}[${i}].${field}
    END

[Common][Extract] - Field or empty if missing
    [Arguments]    ${field}    ${output}=test_value
    ${has_field}    rest has field    ${field}
    ${value}    run keyword if    '${has_field}'=='True'    rest extract    ${field}
    ...    ELSE    set variable    ${EMPTY}
    [common] - Set variable    name=${output}    value=${value}

[Common][Verify] - Http status code is "${code}"
    REST.integer    response status    ${code}

[Common][Verify] - Status code is "${code}"
    REST.string    $.status.code    ${code}

[Common][Verify] - Status message is "${message}"
    REST.string    $.status.message    ${message}

[Common][Verify] - Data is null
    REST.null    $.data

[Common]Extract] - Request body
    [Arguments]    ${output}=test_body
    ${id}    rest extract    request body
    [common] - Set variable    name=${output}    value=${id}

[Common][Extract] - ID
    [Arguments]    ${output}=test_id
    ${id}    rest extract    $.data.id
    [common] - Set variable    name=${output}    value=${id}

[Common][Extract] - Token
    [Arguments]    ${output}=test_token
    ${id}    rest extract    $.data[0].token
    [common] - Set variable    name=${output}    value=${id}

[Common][Extract] - Access token
    [Arguments]    ${output}=test_token
    ${id}    rest extract    $.data.access_token
    [common] - Set variable    name=${output}    value=${id}

[Common][Extract] - Order_id
    [Arguments]    ${output}=test_order_id
    ${id}    rest extract    $.data.order_id
    [common] - Set variable    name=${output}    value=${id}

[Common][Extract] - Data
    [Arguments]    ${output}=data
    ${data}    rest extract    $.data
    [common] - Set variable    name=${output}    value=${data}

[Common][Extract] - Status
    [Arguments]    ${output}=status
    ${status}    rest extract    $.status
    [common] - Set variable    name=${output}    value=${status}

[Common][Verify] - Validate code and message
    [Arguments]         ${code}             ${message}
    should be equal as strings          ${response['status']['code']}               ${code}
    should be equal as strings          ${response['status']['message']}            ${message}

[Common][Verify] - Validate codes and messages
    [Arguments]         ${code1}             ${message1}       ${code2}             ${message2}
    ${status1}=         run keyword and return status       [common][verify] - validate code and message     ${code1}    ${message1}
    ${status2}=         run keyword and return status       [common][verify] - validate code and message     ${code2}    ${message2}
    should be true       ${status1} or ${status2}

[Common][Verify] - Validate response success accept language "${language}"
    [common][verify] - validate response format
    Run Keyword If      '${language}'=='${accept-language_en}'         [common][verify] - validate code and message        code=${code_success}       message=${message_success_en}
    ...     ELSE        [common][verify] - validate code and message        code=${code_success}       message=${message_success_vi}

[Common][Verify] - Validate response format
    rest has field          $.httpStatus
    rest has field          $.status
    rest has field          $.data

[Common][After_Request] - Delete record have client_request_id="${field}"
    Connect to database payment
    Execute Sql String              delete from payment_history where client_request_id='${field}'