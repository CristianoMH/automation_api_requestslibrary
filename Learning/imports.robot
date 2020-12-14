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

#### ROBOT WEB COMMON KEYWORDS ####
Resource    ./1_common/api_common/common.robot


#### ROBOT KEYWORDS ####
Resource    ./2_keywords/Request_Tiki_Keywords.robot
Resource    ./2_keywords/Request_LOS_Keywords.robot


### ROBOT TEST DATAS ###
Resource    ./5_test_datas/config_url.robot
Resource    ./5_test_datas/Tiki_Datas.robot
Resource    ./5_test_datas/LOS_Datas.robot
