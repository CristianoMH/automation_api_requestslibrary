*** Settings ***
Documentation    Suite description
Resource          ../imports.robot

*** Test Cases ***

Login
    [Tags]    tiki    login
    #Define body of request
    [Pre_Request] - Login - Body   $.grant_type=${grant_type}    $.email=${email}    $.password=${password}
    #Define header of request
    [Common][Pre_request] - Authorization headers
    #Send request
    [POST][200] - Success - Login
    ...     headers=${headers}
    ...     body=${body}
    
Get List Adress
    [Tags]    tiki    listAddress
    [Common][Pre_Request] - Authorization headers with access token    ${access_token}
    REST.get             ${tiki_base_url}/${get_list_address}    headers=${headers}
    rest extract
    ${id}    rest extract    $.data[1].id
    [Common] - Set suite variable    id    value=${id}
    [Common][Verify] - Http status code is "200"
    
# Add address
#     [Pre_Request] - Add address - Body   $.full_name=${full_name}
#     ...    $.company=${company}
#     ...    $.telephone=${telephone}
#     ...    $.street=${street}
#     ...    $.is_default=${is_default}
#     ...    $.delivery_address_type=${delivery_address_type}
#     ...    $.region_id=${region_id}
#     ...    $.city_id=${city_id}
#     ...    $.ward_id=${ward_id}
#     [Common][Pre_request] - Authorization headers with access token    ${access_token}
#     [POST][200] - Success - Add address
#     ...     headers=${headers}
#     ...     body=${body}

Update address
    [Tags]    tiki    updateAddress
    [Pre_Request] - Update address - Body   
    ...    $.full_name=${full_name}
    ...    $.company=${company}
    ...    $.telephone=${telephone}
    ...    $.street=${street}
    ...    $.is_default=${is_default}
    ...    $.delivery_address_type=${delivery_address_type}
    ...    $.region_id=${region_id}
    ...    $.city_id=${city_id}
    ...    $.ward_id=${ward_id}
    [Common][Pre_Request] - Authorization headers with access token    ${access_token}
    [PUT][200] - Success - Update address
    ...     headers=${headers}
    ...     body=${body}