*** Settings ***
Documentation     Login functionality test suite
Library          Browser
Resource         ../../../configs/browser-config.robot
Resource         ../steps/login-steps.robot
Suite Setup      Setup Browser
Suite Teardown   Close Browser    ALL
Test Setup       Setup Login Test Context
Test Teardown    Close Context

*** Test Cases ***
Valid Login With Standard User
    [Documentation]    Verify standard user can login successfully
    [Tags]    smoke    login    positive
    Login As Standard User

Locked Out User Cannot Login
    [Documentation]    Verify locked out user cannot access the system
    [Tags]    smoke    login    negative
    Open Login Page
    Handle Special User Login    locked_out_user    secret_sauce

Performance Glitch User Can Login
    [Documentation]    Verify performance_glitch_user can login with extended timeout
    [Tags]    smoke    login    performance
    Open Login Page
    Handle Special User Login    performance_glitch_user    secret_sauce

Error User Login
    [Documentation]    Verify error_user can login but sees errors
    [Tags]    smoke    login    error
    Open Login Page
    Handle Special User Login    error_user    secret_sauce

Visual User Login
    [Documentation]    Verify visual_user can login with visual differences
    [Tags]    smoke    login    visual
    Open Login Page
    Handle Special User Login    visual_user    secret_sauce

Invalid Password Login
    [Documentation]    Verify login fails with invalid password
    [Tags]    login    negative    validation
    Open Login Page
    Enter Credentials    standard_user    wrong_password
    Submit Login Form
    Verify Login Error Message    Epic sadface: Username and password do not match any user in this service

Empty Credentials Login
    [Documentation]    Verify login validation for empty credentials
    [Tags]    login    negative    validation
    Open Login Page
    Submit Login Form
    Verify Login Error Message    Epic sadface: Username is required

Empty Password Login
    [Documentation]    Verify login validation for empty password
    [Tags]    login    negative    validation
    Open Login Page
    Enter Credentials    standard_user    ${EMPTY}
    Submit Login Form
    Verify Login Error Message    Epic sadface: Password is required

Login With Special Characters
    [Documentation]    Verify login handling of special characters
    [Tags]    login    negative    validation
    Open Login Page
    Enter Credentials    user!@#$%    pass!@#$%
    Submit Login Form
    Verify Login Error Message    Epic sadface: Username and password do not match any user in this service
