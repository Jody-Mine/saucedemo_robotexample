*** Settings ***
Documentation     Steps for inventory tests
Resource         ../../../keywords/pages/login-keywords.robot
Resource         ../../../keywords/pages/inventory-keywords.robot
Resource         ../../../resources/locators/inventory-locators.robot

*** Keywords ***
Setup Inventory Test
    New Context    viewport={'width': 1920, 'height': 1080}
    Login As Standard User

Setup Product Sort Test
    New Context    viewport={'width': 1920, 'height': 1080}
    Login As Standard User

Verify Product Details
    [Arguments]    ${product_name}    ${expected_price}    ${expected_description}
    ${product_element}=    Get Element    css=.inventory_item:has-text("${product_name}")
    ${price}=    Get Text    ${product_element} >> css=.inventory_item_price
    Should Be Equal    ${price}    ${expected_price}
    ${description}=    Get Text    ${product_element} >> css=.inventory_item_desc
    Should Be Equal    ${description}    ${expected_description}
