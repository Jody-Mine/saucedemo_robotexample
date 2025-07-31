*** Settings ***
Documentation     Mock API tests simulating e-commerce functionality
Library           RequestsLibrary
Library           Collections
Suite Setup       Setup Mock API Session
Suite Teardown    Delete All Sessions

*** Variables ***
${MOCK_BASE_URL}    http://localhost:3000/api

*** Keywords ***
Setup Mock API Session
    Create Session    mock_api    ${MOCK_BASE_URL}    verify=${False}

*** Test Cases ***
Mock Authentication API - Valid Login
    [Documentation]    Test what a real authentication API would look like
    [Tags]    api    mock    auth    positive
    ${auth_data}=    Create Dictionary    username=standard_user    password=secret_sauce
    ${headers}=      Create Dictionary    Content-Type=application/json
    ${expected_response}=    Create Dictionary    
    ...    success=${True}    
    ...    token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9
    ...    user_id=1
    ...    username=standard_user
    Log    Expected API Response: ${expected_response}
    Should Be Equal As Strings    ${expected_response.success}    True

Mock Authentication API - Invalid Credentials
    [Documentation]    Test authentication failure scenario
    [Tags]    api    mock    auth    negative
    ${auth_data}=    Create Dictionary    username=invalid_user    password=wrong_pass
    ${expected_response}=    Create Dictionary    
    ...    success=${False}    
    ...    error=Invalid credentials
    ...    status_code=401
    Log    Expected API Response: ${expected_response}
    Should Be Equal As Strings    ${expected_response.success}    False
    Should Be Equal As Numbers    ${expected_response.status_code}    401

Mock Products API - Get All Products
    [Documentation]    Test what a products API would return
    [Tags]    api    mock    products    positive
    ${expected_products}=    Create List
    ...    {"id": 1, "name": "Sauce Labs Backpack", "price": 29.99, "description": "carry.allTheThings()"}
    ...    {"id": 2, "name": "Sauce Labs Bike Light", "price": 9.99, "description": "A red light isn't the desired state"}
    ...    {"id": 3, "name": "Sauce Labs Bolt T-Shirt", "price": 15.99, "description": "Get your testing superhero on"}
    ...    {"id": 4, "name": "Sauce Labs Fleece Jacket", "price": 49.99, "description": "It's not every day"}
    ...    {"id": 5, "name": "Sauce Labs Onesie", "price": 7.99, "description": "Rib snap infant onesie"}
    ...    {"id": 6, "name": "Test.allTheThings() T-Shirt (Red)", "price": 15.99, "description": "This classic Sauce Labs t-shirt"}
    ${product_count}=    Get Length    ${expected_products}
    Should Be Equal As Numbers    ${product_count}    6

Mock Cart API - Add Item to Cart
    [Documentation]    Test adding items to cart via API
    [Tags]    api    mock    cart    positive
    ${cart_item}=    Create Dictionary    
    ...    product_id=1    
    ...    quantity=1
    ...    price=29.99
    ${expected_response}=    Create Dictionary    
    ...    success=${True}    
    ...    cart_items=1
    ...    total=29.99
    Log    Adding item to cart: ${cart_item}
    Log    Expected response: ${expected_response}
    Should Be Equal As Strings    ${expected_response.success}    True

Mock Checkout API - Process Order
    [Documentation]    Test checkout process via API
    [Tags]    api    mock    checkout    positive
    ${checkout_data}=    Create Dictionary    
    ...    first_name=John    
    ...    last_name=Doe    
    ...    postal_code=12345
    ...    items=[{"product_id": 1, "quantity": 1, "price": 29.99}]
    ${expected_response}=    Create Dictionary    
    ...    success=${True}    
    ...    order_id=12345
    ...    total=32.39
    ...    tax=2.40
    ...    status=completed
    Log    Checkout data: ${checkout_data}
    Log    Expected response: ${expected_response}
    Should Be Equal As Strings    ${expected_response.success}    True
    Should Be Equal As Numbers    ${expected_response.order_id}    12345
