*** Settings ***
Documentation     API-style tests using browser automation to test application state
Library           Browser
Suite Setup       New Browser    headless=true
Suite Teardown    Close Browser    ALL
Test Setup        New Page    https://www.saucedemo.com
Test Teardown     Close Context

*** Test Cases ***
API Style - Authentication State Validation
    [Documentation]    Test authentication state changes (simulating API behavior)
    [Tags]    api-style    auth    state
    # Test initial state (not authenticated)
    Get Url    ==    https://www.saucedemo.com/
    Get Element    id=login-button    # Should be on login page
    
    # Test successful authentication state change
    Fill Text    id=user-name    standard_user
    Fill Text    id=password    secret_sauce
    Click    id=login-button
    Get Url    ==    https://www.saucedemo.com/inventory.html
    Get Element    css=.inventory_container    # Should be on inventory page

API Style - Product Data Validation
    [Documentation]    Validate product data structure (simulating API response validation)
    [Tags]    api-style    products    data
    Fill Text    id=user-name    standard_user
    Fill Text    id=password    secret_sauce
    Click    id=login-button
    
    # Validate product data structure (like validating API JSON response)
    ${products}=    Get Elements    css=.inventory_item
    ${product_count}=    Get Length    ${products}
    Should Be Equal As Numbers    ${product_count}    6
    
    # Validate first product data structure
    ${first_product_name}=    Get Text    css=.inventory_item:first-child .inventory_item_name
    ${first_product_price}=    Get Text    css=.inventory_item:first-child .inventory_item_price
    ${first_product_desc}=    Get Text    css=.inventory_item:first-child .inventory_item_desc
    
    Should Not Be Empty    ${first_product_name}
    Should Match Regexp    ${first_product_price}    ^\\$\\d+\\.\\d{2}$
    Should Not Be Empty    ${first_product_desc}

API Style - Cart State Management
    [Documentation]    Test cart state changes (simulating cart API calls)
    [Tags]    api-style    cart    state
    Fill Text    id=user-name    standard_user
    Fill Text    id=password    secret_sauce
    Click    id=login-button
    
    # Test initial cart state (empty)
    ${initial_cart_visible}=    Run Keyword And Return Status    Get Element    css=.shopping_cart_badge
    Should Be Equal    ${initial_cart_visible}    ${False}
    
    # Test add to cart state change
    Click    id=add-to-cart-sauce-labs-backpack
    ${cart_badge}=    Get Text    css=.shopping_cart_badge
    Should Be Equal    ${cart_badge}    1
    
    # Test cart contents validation
    Click    css=.shopping_cart_link
    Get Url    ==    https://www.saucedemo.com/cart.html
    ${cart_item_name}=    Get Text    css=.inventory_item_name
    Should Be Equal    ${cart_item_name}    Sauce Labs Backpack

API Style - Checkout Process Validation
    [Documentation]    Test checkout flow (simulating checkout API calls)
    [Tags]    api-style    checkout    flow
    Fill Text    id=user-name    standard_user
    Fill Text    id=password    secret_sauce
    Click    id=login-button
    
    # Add item and proceed to checkout
    Click    id=add-to-cart-sauce-labs-backpack
    Click    css=.shopping_cart_link
    Click    id=checkout
    
    # Test checkout step 1 state
    Get Url    ==    https://www.saucedemo.com/checkout-step-one.html
    Get Element    id=first-name
    Get Element    id=last-name
    Get Element    id=postal-code
    
    # Fill checkout information
    Fill Text    id=first-name    John
    Fill Text    id=last-name    Doe
    Fill Text    id=postal-code    12345
    Click    id=continue
    
    # Test checkout step 2 state (summary)
    Get Url    ==    https://www.saucedemo.com/checkout-step-two.html
    ${summary_total}=    Get Text    css=.summary_total_label
    Should Contain    ${summary_total}    Total:
    
    # Complete checkout
    Click    id=finish
    Get Url    ==    https://www.saucedemo.com/checkout-complete.html
    Get Element    css=.complete-header    # Should show completion message
