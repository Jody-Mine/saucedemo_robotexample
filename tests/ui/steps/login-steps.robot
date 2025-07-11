*** Settings ***
Documentation     Steps for login validation tests
Resource         ../../../keywords/pages/login-keywords.robot
Resource         ../../../resources/variables/global-variables.robot

*** Keywords ***
Setup Login Test Context
    New Context    viewport={'width': 1920, 'height': 1080}

Setup Special User Test
    New Context    viewport={'width': 1920, 'height': 1080}
