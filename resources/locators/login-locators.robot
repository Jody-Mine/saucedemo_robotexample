*** Settings ***
Documentation     Login page locators and element selectors
Library          Browser

*** Variables ***
${LOGIN_USERNAME_INPUT}       id=user-name
${LOGIN_PASSWORD_INPUT}       id=password
${LOGIN_BUTTON}              id=login-button
${LOGIN_ERROR_MESSAGE}       data-test=error
${INVENTORY_CONTAINER}       data-test=inventory-container
