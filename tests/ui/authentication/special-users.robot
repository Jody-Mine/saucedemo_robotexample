*** Settings ***
Documentation     Tests for special user types (error_user and visual_user)
Library          Browser
Library          BuiltIn
Library          Collections
Resource         ../../../configs/browser-config.robot
Resource         ../steps/login-steps.robot
Resource         ../steps/inventory-steps.robot

Suite Setup      Setup Browser
Suite Teardown   Close Browser    ALL
Test Setup       Setup Special User Test
Test Teardown    Close Context



*** Test Cases ***
Error User Add To Cart Issue
    [Documentation]    Verify error_user can add items but might see other issues
    [Tags]    error_user    inventory    behavior
    Login As Error User
    Click    id=add-to-cart-sauce-labs-backpack
    ${cart_badge}=    Get Text    css=.shopping_cart_badge
    Should Be Equal    ${cart_badge}    1    Cart badge should show 1 item
    Open Shopping Cart
    ${item_name}=    Get Text    css=.inventory_item_name
    Should Be Equal    ${item_name}    Sauce Labs Backpack    Added item should be in cart

Visual User Product Images
    [Documentation]    Verify visual_user sees different product images
    [Tags]    visual_user    inventory    visual
    Login As Visual User
    ${src}=    Get Attribute    [data-test="inventory-item-sauce-labs-backpack-img"]    src
    Should Contain    ${src}    sl-404

Error User Sort Function
    [Documentation]    Verify error_user experiences sorting issues
    [Tags]    error_user    inventory    sort    negative
    Login As Error User
    Sort Products    ${SORT_ZA}
    # Verify sort didn't work as expected
    Verify Products Sorted Alphabetically    ascending=${True}

Visual User Cart Behavior
    [Documentation]    Verify visual_user cart functionality
    [Tags]    visual_user    cart    visual
    Login As Visual User
    Add Product To Cart    sauce-labs-backpack
    ${cart_badge_visible}=    Run Keyword And Return Status
    ...    Wait For Elements State    css=.shopping_cart_badge    visible    timeout=5s
    Should Be True    ${cart_badge_visible}    Cart badge should be visible
    Open Shopping Cart
    ${cart_items}=    Get Elements    css=.cart_item
    ${count}=    Get Length    ${cart_items}
    Should Be Equal As Numbers    ${count}    1
