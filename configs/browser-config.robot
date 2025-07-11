*** Settings ***
Documentation    Browser configuration settings

*** Variables ***
${BROWSER_TIMEOUT}        30 seconds
${RETRY_TIMEOUT}         0.1 seconds
${RETRY_INTERVAL}        5x

*** Keywords ***
Setup Browser
    [Arguments]    ${browser}=${BROWSER}    ${headless}=${HEADLESS}
    New Browser    ${browser}    headless=${headless}
    New Context    viewport={'width': 1920, 'height': 1080}
    Set Browser Timeout    ${BROWSER_TIMEOUT}
