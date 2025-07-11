*** Settings ***
Documentation     Keywords for inventory page interactions
Library          Browser
Library          Collections
Library          String
Resource         ../../resources/locators/inventory-locators.robot
Resource         ../../resources/variables/global-variables.robot

*** Keywords ***
Sort Products
    [Arguments]    ${sort_option}
    Wait For Elements State    ${PRODUCT_SORT}    visible    timeout=10s
    Select Options By    ${PRODUCT_SORT}    value    ${sort_option}
    # Wait for sort animation
    Sleep    1s

Get Product Names
    ${elements}=    Get Elements    ${INVENTORY_ITEM_NAME}
    ${names}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${names}    ${text}
    END
    RETURN    ${names}

Get Product Prices
    ${elements}=    Get Elements    ${INVENTORY_ITEM_PRICE}
    ${prices}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        ${price_str}=    Remove String    ${text}    $
        ${price}=    Convert To Number    ${price_str}
        Append To List    ${prices}    ${price}
    END
    RETURN    ${prices}

Verify Products Sorted Alphabetically
    [Arguments]    ${ascending}=${True}
    ${names}=    Get Product Names
    ${sorted_names}=    Copy List    ${names}
    Sort List    ${sorted_names}
    IF    not ${ascending}
        Reverse List    ${sorted_names}
    END
    Lists Should Be Equal    ${names}    ${sorted_names}

Verify Products Sorted By Price
    [Arguments]    ${ascending}=${True}
    ${prices}=    Get Product Prices
    ${sorted_prices}=    Copy List    ${prices}
    Sort List    ${sorted_prices}
    IF    not ${ascending}
        Reverse List    ${sorted_prices}
    END
    Lists Should Be Equal    ${prices}    ${sorted_prices}

Add Product To Cart
    [Arguments]    ${product_name}
    ${button_id}=    Set Variable    ${ADD_TO_CART_PREFIX}${product_name}
    Click    ${button_id}
    Wait For Elements State    id=remove-${product_name}    visible

Remove Product From Cart
    [Arguments]    ${product_name}
    ${button_id}=    Set Variable    ${REMOVE_FROM_CART_PREFIX}${product_name}
    Click    ${button_id}
    Wait For Elements State    id=add-to-cart-${product_name}    visible

Get Cart Items Count
    ${count}=    Get Text    ${SHOPPING_CART_BADGE}
    RETURN    ${count}

Open Shopping Cart
    Click    ${SHOPPING_CART_LINK}

Verify Product Price
    [Arguments]    ${product_name}    ${expected_price}
    ${price_text}=    Get Text    data-test=product-price-${product_name}
    Should Be Equal    ${price_text}    ${expected_price}

Verify Product In Inventory
    [Arguments]    ${product_name}
    Wait For Elements State    data-test=inventory-item-${product_name}    visible
