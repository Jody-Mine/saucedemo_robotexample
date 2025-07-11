*** Settings ***
Documentation    Tests for checkout process
Library         Browser
Resource        ../../../configs/browser-config.robot
Resource        ../steps/checkout-steps.robot

Suite Setup      Setup Browser
Suite Teardown   Close Browser    ALL
Test Setup       Login And Prepare Cart
Test Teardown    Close Context

*** Test Cases ***
Successful Checkout With Valid Information
    [Documentation]    Verify successful checkout with valid user information
    [Tags]    checkout    smoke    positive
    Start Checkout Process
    Fill Checkout Information    John    Doe    12345
    ${total}=    Get Total Price
    Complete Purchase
    Wait For Elements State    ${CHECKOUT_COMPLETE_HEADER}    visible

Checkout With Empty Required Fields
    [Documentation]    Verify checkout validation for empty required fields
    [Tags]    checkout    negative    validation
    Start Checkout Process
    Click    ${CONTINUE_BUTTON}
    Verify Error Message    Error: First Name is required

Checkout With Multiple Items
    [Documentation]    Verify checkout with multiple items in cart
    [Tags]    checkout    smoke    positive
    Verify Cart Item Count    2
    Start Checkout Process
    Fill Checkout Information    Jane    Smith    54321
    Complete Purchase
    Wait For Elements State    ${CHECKOUT_COMPLETE_HEADER}    visible

Continue Shopping After Adding To Cart
    [Documentation]    Verify continuing shopping after adding items
    [Tags]    checkout    navigation    positive
    Open Shopping Cart
    Click    ${CONTINUE_SHOPPING_BUTTON}
    Wait For Elements State    data-test=inventory-container    visible
    Add Product To Cart    sauce-labs-onesie
    Open Shopping Cart
    Verify Cart Item Count    3

Verify Tax Calculation
    [Documentation]    Verify tax calculation is correct (8%)
    [Tags]    checkout    calculation    positive
    Start Checkout Process
    Fill Checkout Information    John    Doe    12345
    ${subtotal}=    Get Total Price
    ${tax}=    Get Tax Amount
    ${expected_tax}=    Evaluate    ${subtotal} * 0.08
    Should Be Equal As Numbers    ${tax}    ${expected_tax}    precision=2
    Complete Purchase

Special Characters In Customer Information
    [Documentation]    Verify handling of special characters in customer information
    [Tags]    checkout    validation    positive
    Start Checkout Process
    Fill Checkout Information    José    O'Connor-Smith    12345-678
    Complete Purchase

Cancel And Return To Cart
    [Documentation]    Verify canceling checkout returns to cart
    [Tags]    checkout    navigation    negative
    Start Checkout Process
    Click    ${CANCEL_BUTTON}
    Wait For Elements State    css=.cart_list    visible
    Verify Cart Item Count    2

Checkout With Empty Last Name
    [Documentation]    Verify last name validation
    [Tags]    checkout    negative    validation
    Start Checkout Process
    Fill Checkout Information    John    ${EMPTY}    12345
    Verify Error Message    Error: Last Name is required

Checkout With Empty Postal Code
    [Documentation]    Verify postal code validation
    [Tags]    checkout    negative    validation
    Start Checkout Process
    Fill Checkout Information    John    Doe    ${EMPTY}
    Verify Error Message    Error: Postal Code is required
