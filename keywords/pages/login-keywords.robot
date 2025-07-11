*** Settings ***
Documentation     Keywords for login page interactions
Library          Browser
Resource         ../../resources/locators/login-locators.robot
Resource         ../../resources/variables/global-variables.robot

*** Keywords ***
Open Login Page
    New Page    ${BASE_URL}
    Wait For Elements State    ${LOGIN_USERNAME_INPUT}    visible

Enter Credentials
    [Arguments]    ${username}    ${password}
    Type Text    ${LOGIN_USERNAME_INPUT}    ${username}
    Type Text    ${LOGIN_PASSWORD_INPUT}    ${password}

Submit Login Form
    Click    ${LOGIN_BUTTON}

Verify Successful Login
    Wait For Elements State    ${INVENTORY_CONTAINER}    visible

Login As Standard User
    [Documentation]    Logs in using standard_user credentials
    Open Login Page
    Enter Credentials    standard_user    secret_sauce
    Submit Login Form
    Verify Successful Login

Verify Login Error Message
    [Arguments]    ${expected_error}
    Get Text    ${LOGIN_ERROR_MESSAGE}    ==    ${expected_error}

Handle Special User Login
    [Arguments]    ${username}    ${password}
    Enter Credentials    ${username}    ${password}
    Submit Login Form
    IF    "${username}" == "locked_out_user"
        Verify Login Error Message    Epic sadface: Sorry, this user has been locked out.
    ELSE IF    "${username}" == "problem_user"
        Verify Successful Login
    ELSE IF    "${username}" == "performance_glitch_user"
        Set Browser Timeout    30s
        Verify Successful Login
        Set Browser Timeout    10s
    ELSE
        Verify Successful Login
    END

Login As Error User
    [Documentation]    Logs in using error_user credentials
    Open Login Page
    Enter Credentials    error_user    secret_sauce
    Submit Login Form
    Verify Successful Login

Login As Visual User
    [Documentation]    Logs in using visual_user credentials
    Open Login Page
    Enter Credentials    visual_user    secret_sauce
    Submit Login Form
    Verify Successful Login
