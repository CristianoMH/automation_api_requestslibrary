*** Settings ***
Documentation    Suite description
Resource      ../imports.robot


*** Keywords ***

[Common][Pre_Request] - Authorization headers with access token
    [Arguments]  ${access_token}    ${content_type}=application/json    ${output}=headers
    ${headers}    create dictionary   content-type=${content_type}    x-access-token=${access_token}
    [Common] - Set test variable    name=${output}    value=${headers}

[Pre_Request] - Login - Body
    [Arguments]     ${output}=body    ${remove_null}=${True}   ${remove_empty}=${True}    &{arg_dic}
    #format
    ${schema}              catenate     SEPARATOR=
     ...    {
     ...      "grant_type": "string",
     ...      "email": "string",
     ...      "password": "string"
     ...    }
    #
    ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [Common] - Set test variable       name=${output}      value=${body}

[Pre_Request] - Add address - Body
    [Arguments]     ${output}=body    ${remove_null}=${True}   ${remove_empty}=${True}    &{arg_dic}
    ${schema}              catenate     SEPARATOR=
    ...    {
    ...   "full_name":"string",
    ...   "company":"string",
    ...   "telephone":"string",
    ...   "street":"string",
    ...   "is_default":"string",
    ...   "delivery_address_type":"string",
    ...   "region_id":"string",
    ...   "city_id":"string",
    ...   "ward_id":"string"
    ...    }
     ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [Common] - Set test variable       name=${output}      value=${body}

[Pre_Request] - Update address - Body
    [Arguments]     ${output}=body    ${remove_null}=${True}   ${remove_empty}=${True}    &{arg_dic}
    ${schema}              catenate     SEPARATOR=
    ...    {
    ...   "full_name":"string",
    ...   "company":"string",
    ...   "telephone":"string",
    ...   "street":"string",
    ...   "is_default":"string",
    ...   "delivery_address_type":"string",
    ...   "region_id":"string",
    ...   "city_id":"string",
    ...   "ward_id":"string"
    ...    }
     ${body}     generate json
        ...     json_schema=${schema}
        ...     args=${arg_dic}
        ...     remove_null=${remove_null}
        ...     remove_empty=${remove_empty}
    [Common] - Set test variable       name=${output}      value=${body}

[POST][200] - Success - Login
    [Arguments]       ${headers}             ${body}  
    REST.post       ${tiki_base_url}/${post_login_url}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    ${access_token}    rest extract    $.access_token
    [Common] - Set suite variable    access_token    value=${access_token}
    [Common][Verify] - Http status code is "200"

[POST][200] - Success - Add address
    [Arguments]       ${headers}             ${body} 
    REST.post       ${tiki_base_url}/${post_add_address}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [Common][Verify] - Http status code is "200"

[PUT][200] - Success - Update address
    [Arguments]       ${headers}             ${body}  
    REST.put       ${tiki_base_url}/${post_update_address}/${id}
        ...     headers=${headers}
        ...     body=${body}
    rest extract
    [Common][Verify] - Http status code is "200"
