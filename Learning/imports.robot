*** Settings ***

#### ROBOT LIBRARY ####
Library    SeleniumLibrary
Library    String
Library    RequestsLibrary
Library    SSHLibrary
Library    Collections
Library    DateTime
Library    OperatingSystem
Library    JSONLibrary

# Library    DatabaseLibrary
Library    REST               ssl_verify=${False}

#### PYTHON3 LIBRARY ####
Library      ./0_resources/pythonlibs/convert_list_to_string.py
Library      ./0_resources/pythonlibs/convert_to_json.py
Library      ./0_resources/pythonlibs/encodebase64.py
Library      ./0_resources/pythonlibs/json_generator.py
Library      ./0_resources/pythonlibs/math_util.py
Library      ./0_resources/pythonlibs/remove_quote_string_sql.py
# Library    ./0_resources/pythonlibs/rsa_encryption.py
Library      ./0_resources/pythonlibs/rest_util.py

#### ROBOT WEB COMMON KEYWORDS ####
Resource    ./1_common/api_common/common.robot

#### ROBOT KEYWORDS ####
Resource    ./2_keywords/Request_Tiki_Keywords.robot
Resource    ./2_keywords/Request_LOS_Keywords.robot
Resource    ./2_keywords/Rest_LOS_Keywords.robot
Resource    ./2_keywords/Rest_Tiki_Keywords.robot

### ROBOT TEST DATAS ###
Resource    ./5_test_datas/config_url.robot
Resource    ./5_test_datas/Tiki_Datas.robot
Resource    ./5_test_datas/LOS_Datas.robot
