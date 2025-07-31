*** Settings ***
Documentation     Data validation tests (simulating API response validation)
Library           Browser
Library           Collections
Library           String
Suite Setup       Setup Browser And Login
Suite Teardown    Close Browser    ALL
Test Setup        New Page    https://www.saucedemo.com
Test Teardown     Close Page

*** Keywords ***
Setup Browser And Login
    New Browser    headless=true
    New Page    https://www.saucedemo.com
    Fill Text    id=user-name    standard_user
    Fill Text    id=password    secret_sauce
    Click    id=login-button
    Close Page

Login As Standard User For Test
    Fill Text    id=user-name    standard_user
    Fill Text    id=password    secret_sauce
    Click    id=login-button

*** Test Cases ***
Data Validation - Product Schema
    [Documentation]    Validate product data structure like API response schema
    [Tags]    api    data    validation    products
    Login As Standard User For Test
    
    ${products}=    Get Elements    css=.inventory_item
    FOR    ${product}    IN    @{products}
        # Validate required fields exist (like API schema validation)
        ${name_element}=    Get Element    ${product} >> css=.inventory_item_name
        ${price_element}=    Get Element    ${product} >> css=.inventory_item_price
        ${desc_element}=    Get Element    ${product} >> css=.inventory_item_desc
        ${img_element}=    Get Element    ${product} >> css=img
        
        # Validate data types and formats
        ${name}=    Get Text    ${name_element}
        ${price}=    Get Text    ${price_element}
        ${description}=    Get Text    ${desc_element}
        ${img_src}=    Get Property    ${img_element}    src
        
        Should Not Be Empty    ${name}
        Should Match Regexp    ${price}    ^\\$\\d+\\.\\d{2}$    # Price format validation
        Should Not Be Empty    ${description}
        Should Contain    ${img_src}    .jpg    # Image URL validation
    END

Data Validation - Cart Totals Calculation
    [Documentation]    Validate cart calculation logic (like API business logic)
    [Tags]    api    data    validation    cart
    Login As Standard User For Test
    
    # Add known items with known prices
    Click    id=add-to-cart-sauce-labs-backpack    # $29.99
    Click    id=add-to-cart-sauce-labs-bike-light    # $9.99
    
    Click    css=.shopping_cart_link
    Click    id=checkout
    Fill Text    id=first-name    John
    Fill Text    id=last-name    Doe
    Fill Text    id=postal-code    12345
    Click    id=continue
    
    # Validate calculation logic
    ${subtotal_text}=    Get Text    css=.summary_subtotal_label
    ${tax_text}=    Get Text    css=.summary_tax_label
    ${total_text}=    Get Text    css=.summary_total_label
    
    # Extract numeric values
    ${subtotal}=    Get Regexp Matches    ${subtotal_text}    \\$([\\d.]+)    1
    ${tax}=    Get Regexp Matches    ${tax_text}    \\$([\\d.]+)    1
    ${total}=    Get Regexp Matches    ${total_text}    \\$([\\d.]+)    1
    
    # Validate calculations (like API business logic validation)
    ${expected_subtotal}=    Set Variable    39.98
    ${calculated_total}=    Evaluate    ${subtotal[0]} + ${tax[0]}
    
    Should Be Equal As Numbers    ${subtotal[0]}    ${expected_subtotal}
    Should Be Equal As Numbers    ${total[0]}    ${calculated_total}

Data Validation - User Session State
    [Documentation]    Validate user session data (like API session validation)
    [Tags]    api    data    validation    session
    Login As Standard User For Test
    
    # Validate authenticated state indicators
    Get Element    css=.inventory_container    # Should be on authenticated page
    Get Element    css=.shopping_cart_link    # Cart should be available
    Get Element    css=.bm-burger-button    # Menu should be available
    
    # Validate product access (authorized content)
    ${products}=    Get Elements    css=.inventory_item
    ${product_count}=    Get Length    ${products}
    Should Be Equal As Numbers    ${product_count}    6    # Should see all products when authenticated

Data Validation - Error Response Simulation
    [Documentation]    Validate error handling (like API error responses)
    [Tags]    api    data    validation    errors
    
    # Test invalid credentials (simulate 401 API response)
    Fill Text    id=user-name    invalid_user
    Fill Text    id=password    wrong_password
    Click    id=login-button
    
    ${error_message}=    Get Text    css=[data-test="error"]
    Should Contain    ${error_message}    Username and password do not match
    Get Url    ==    https://www.saucedemo.com/    # Should stay on login page
    
    # Test locked user (simulate 403 API response)
    Fill Text    id=user-name    locked_out_user
    Fill Text    id=password    secret_sauce
    Click    id=login-button
    
    ${locked_error}=    Get Text    css=[data-test="error"]
    Should Contain    ${locked_error}    locked out
    Get Url    ==    https://www.saucedemo.com/    # Should stay on login page
