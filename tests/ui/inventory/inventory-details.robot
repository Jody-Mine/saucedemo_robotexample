*** Settings ***
Documentation     Tests for product details and filtering functionality
Library          Browser
Resource         ../../../configs/browser-config.robot
Resource         ../steps/inventory-steps.robot

Suite Setup      Setup Browser
Suite Teardown   Close Browser    ALL
Test Setup       Setup Inventory Test
Test Teardown    Close Context

*** Test Cases ***
Verify Product Details Are Correct
    [Documentation]    Verify product details are displayed correctly
    [Tags]    inventory    details    positive
    Verify Product Details    Sauce Labs Backpack
    ...    $29.99
    ...    carry.allTheThings() with the sleek, streamlined Sly Pack that melds uncompromising style with unequaled laptop and tablet protection.

Verify All Products Have Prices
    [Documentation]    Verify all products have valid prices
    [Tags]    inventory    details    positive
    ${products}=    Get Elements    css=.inventory_item
    FOR    ${product}    IN    @{products}
        ${price}=    Get Text    ${product} >> css=.inventory_item_price
        Should Match Regexp    ${price}    ^\\$\\d+\\.\\d{2}$
    END

Verify All Products Have Images
    [Documentation]    Verify all products have valid images
    [Tags]    inventory    details    positive
    ${images}=    Get Elements    css=.inventory_item img
    FOR    ${image}    IN    @{images}
        ${src}=    Get Property    ${image}    src
        Should Not Be Empty    ${src}
        ${alt}=    Get Property    ${image}    alt
        Should Not Be Empty    ${alt}
    END

Verify Product Count
    [Documentation]    Verify the total number of products displayed
    [Tags]    inventory    details    positive
    ${products}=    Get Elements    css=.inventory_item
    ${count}=    Get Length    ${products}
    Should Be Equal As Numbers    ${count}    6    Expected 6 products to be displayed

Add Multiple Products From Different Price Ranges
    [Documentation]    Verify adding products from different price ranges
    [Tags]    inventory    cart    positive
    ${products}=    Get Elements    css=.inventory_item
    ${low_price_product}=    Set Variable    sauce-labs-onesie
    ${high_price_product}=    Set Variable    sauce-labs-fleece-jacket
    Add Product To Cart    ${low_price_product}
    Add Product To Cart    ${high_price_product}
    ${cart_count}=    Get Text    css=.shopping_cart_badge
    Should Be Equal    ${cart_count}    2

Add Remove Multiple Times
    [Documentation]    Verify adding and removing the same product multiple times
    [Tags]    inventory    cart    regression
    FOR    ${i}    IN RANGE    3
        Add Product To Cart    sauce-labs-backpack
        Remove Product From Cart    sauce-labs-backpack
    END
    ${cart_badge_visible}=    Run Keyword And Return Status
    ...    Get Element    css=.shopping_cart_badge
    Should Be Equal    ${cart_badge_visible}    ${FALSE}    Cart badge should not be visible
