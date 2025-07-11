*** Settings ***
Documentation     Tests for shopping cart management
Library          Browser
Resource         ../../../configs/browser-config.robot
Resource         ../steps/cart-steps.robot

Suite Setup      Setup Browser
Suite Teardown   Close Browser    ALL
Test Setup      Login And Clear Cart
Test Teardown    Close Context

*** Test Cases ***
Add Single Product To Cart
    [Documentation]    Verify adding a single product to cart
    [Tags]    cart    smoke    positive
    Add Product To Cart    sauce-labs-backpack
    ${count}=    Get Cart Items Count
    Should Be Equal    ${count}    1

Remove Product From Cart
    [Documentation]    Verify removing a product from cart
    [Tags]    cart    smoke    positive
    Add Product To Cart    sauce-labs-backpack
    Remove Product From Cart    sauce-labs-backpack
    ${cart_visible}=    Run Keyword And Return Status    Get Element    ${SHOPPING_CART_BADGE}
    Should Be Equal    ${cart_visible}    ${FALSE}

Add Multiple Products To Cart
    [Documentation]    Verify adding multiple products to cart
    [Tags]    cart    smoke    positive
    Add Product To Cart    sauce-labs-backpack
    Add Product To Cart    sauce-labs-bike-light
    ${count}=    Get Cart Items Count
    Should Be Equal    ${count}    2

Cart Persistence After Logout
    [Documentation]    Verify cart items persist after logout and login
    [Tags]    cart    smoke    positive
    Add Product To Cart    sauce-labs-backpack
    # TODO: Add logout keyword
    # TODO: Add login again
    ${count}=    Get Cart Items Count
    Should Be Equal    ${count}    1
