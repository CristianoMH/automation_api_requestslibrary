*** Settings ***
Documentation    Automation API testing script for website Tiki
Resource          ../imports.robot

*** Test Cases ***

TC001 - [200][POST] - Success - Login

    [Keyword] - Login Success

TC002 - [200][GET] - Success - Get List Addresses

    [Keyword] - Get List Addresses Success

TC003 - [200][PUT] - Success - Update Address with specific id

    [Keyword] - Update Address With Specific Id
    

    



