*** Settings ***
Documentation    Keywords for API using Request library
Resource      ../imports.robot


*** Keywords ***

[Keyword] - Login Success

#-------------------------------------------------------------------------
    #create a HTTP session to Tiki server
    Create Session    session_login    ${tiki_base_url}
    
    #Headers data into API include content type and user agent (if needed)
    ${headers}=    Create Dictionary    
    ...    Content-Type=${content_type}
    ...    User-Agent=${user_agent}

    #Body data in API
    ${body}=    Create Dictionary    
    ...    grant_type=${grant_type}
    ...    email=${email}
    ...    password=${password}

    #Send request to server with method Post, uri, header and body
    ${response}=    Post Request    session_login    uri=${post_login_url}    headers=${headers}    data=${body} 
    
    #Get access_token from response
    ${access_token}=    [Common] - Get value from response body    ${response.content}    $.access_token

    #Set access_token to become suite variable to use access token for all of tests in suite
    [Common] - Set suite variable    name=access_token    value=${access_token}

    #Validate API with status code
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200

    #Validate API with response body
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    token_type

    #Validate API with reason
    ${reason}=    Convert To String    ${response.reason}
    Should Be Equal    ${reason}    OK

    #Validate API: request fail if response status code is 4xx,5xx 
    Request Should Be Successful    ${response}

    #Validate API with Headers
    ${contentType_value}    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${contentType_value}    text/json;charset=utf-8
    
    #Validate API with cookie:    ${response.cookies}


#-------------------------------------------------------------------------
[Keyword] - Get List Addresses Success
    
    #create a HTTP session to Tiki server
    Create Session    session_list_address    ${tiki_base_url}

    #Headers data into API include content type, user agent (if needed), x-access-token get from API Login
    ${headers}=    Create Dictionary
    ...    Content-Type=${content_type}
    ...    User-Agent=${user_agent}
    ...    x-access-token=${access_token}

    #Params data in API include page and limit
    ${params}=    Create Dictionary
    ...    page=${page}
    ...    limit=${limit}

    #Send request to server with method GET, uri, headers and params
    ${response}=    Get Request    session_list_address    uri=${get_list_address}    headers=${headers}    params=${params}
    
    #Get id of first element in list addresses 
    ${id}=    [Common] - Get value from response body    ${response.content}    $.data[2].id    
    #Set id to become suite variable to use id for all of tests in suite
    [Common] - Set suite variable    name=id    value=${id}

    #Validate API with status code
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200

    #Validate API with response body
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    data

    #Validate API with reason
    ${reason}=    Convert To String    ${response.reason}
    Should Be Equal    ${reason}    OK

    #Validate API: request fail if response status code is 4xx,5xx 
    Request Should Be Successful    ${response}

    #Validate API with Headers
    ${contentType_value}    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${contentType_value}    text/json;charset=utf-8
    
    #Validate API with cookie:    ${response.cookies}

#-------------------------------------------------------------------------
[Keyword] - Update Address With Specific Id

    #create a HTTP session to Tiki server
    Create Session    session_update    ${tiki_base_url}
    
    #Headers data into API include content type, user agent (if needed) and x-access-token get from API Login
    ${headers}=    Create Dictionary    
    ...    Content-Type=${content_type}
    ...    User-Agent=${user_agent}
    ...    x-access-token=${access_token}

    #Body data in API
    ${body}=    Create Dictionary    
    ...    full_name=${full_name}
    ...    company=${company}
    ...    telephone=${telephone}
    ...    street=${street}
    ...    is_default=${is_default}
    ...    delivery_address_type=${delivery_address_type}
    ...    region_id=${region_id}
    ...    city_id=${city_id}
    ...    ward_id=${ward_id}

    #Send request to server with method Put, uri with id get from api list address, header and body
    ${response}=    Put Request    session_update    uri=${post_update_address}/${id}    headers=${headers}    data=${body}

    #Validate API with status code
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200

    #Validate API with response body
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    15394342

    #Validate API with reason
    ${reason}=    Convert To String    ${response.reason}
    Should Be Equal    ${reason}    OK

    #Validate API: request fail if response status code is 4xx,5xx 
    Request Should Be Successful    ${response}

    #Validate API with Headers
    ${contentType_value}    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${contentType_value}    text/json;charset=utf-8
    
    #Validate API with cookie:    ${response.cookies}