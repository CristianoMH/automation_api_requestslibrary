*** Settings ***
Documentation    Automation API testing script for LOS
Resource          ../imports.robot

*** Test Cases ***

TC001 - [200][POST] - Success - Register Loan

    [Keyword] - Register Loan Success