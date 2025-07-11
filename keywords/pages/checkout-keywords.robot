*** Settings ***
Documentation    Keywords for checkout process
Library         Browser
Library         String
Resource        ../../resources/locators/checkout-locators.robot
Resource        ../../resources/variables/global-variables.robot

*** Keywords ***
Start Checkout Process
    Click    ${CHECKOUT_BUTTON}
    Wait For Elements State    ${FIRST_NAME_INPUT}    visible

Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Type Text    ${FIRST_NAME_INPUT}    ${first_name}
    Type Text    ${LAST_NAME_INPUT}    ${last_name}
    Type Text    ${POSTAL_CODE_INPUT}    ${postal_code}
    Click    ${CONTINUE_BUTTON}

Complete Purchase
    Click    ${FINISH_BUTTON}
    Wait For Elements State    ${CHECKOUT_COMPLETE_HEADER}    visible

Get Total Price
    ${prices}=    Get Elements    ${ITEM_PRICE}
    ${total}=    Set Variable    ${0.0}
    FOR    ${price}    IN    @{prices}
        ${price_text}=    Get Text    ${price}
        ${price_number}=    Remove String    ${price_text}    $
        ${total}=    Evaluate    ${total} + float($price_number)
    END
    RETURN    ${total}

Get Tax Amount
    ${tax_element}=    Get Element    ${TAX_AMOUNT}
    ${tax_text}=    Get Text    ${tax_element}
    ${tax_number}=    Remove String    ${tax_text}    Tax:     $
    ${tax}=    Convert To Number    ${tax_number}
    RETURN    ${tax}

Verify Cart Item Count
    [Arguments]    ${expected_count}
    ${items}=    Get Elements    ${CART_ITEM}
    ${count}=    Get Length    ${items}
    Should Be Equal As Numbers    ${count}    ${expected_count}

Verify Error Message
    [Arguments]    ${expected_message}
    ${message}=    Get Text    ${ERROR_MESSAGE}
    Should Be Equal    ${message}    ${expected_message}

Continue Shopping
    Click    ${CONTINUE_SHOPPING_BUTTON}
    Wait For Elements State    ${INVENTORY_CONTAINER}    visible
