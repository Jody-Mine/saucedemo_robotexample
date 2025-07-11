*** Settings ***
Documentation    Steps for cart management tests
Resource         ../../../keywords/pages/login-keywords.robot
Resource         ../../../keywords/pages/inventory-keywords.robot
Resource         ../../../resources/locators/inventory-locators.robot

*** Keywords ***
Login And Clear Cart
    New Context    viewport={'width': 1920, 'height': 1080}
    Login As Standard User
    Clear Shopping Cart If Not Empty

Clear Shopping Cart If Not Empty
    ${cart_visible}=    Run Keyword And Return Status    Get Element    ${SHOPPING_CART_BADGE}
    IF    ${cart_visible}
        Open Shopping Cart
        Remove All Items From Cart
    END

Remove All Items From Cart
    ${remove_buttons}=    Get Elements    css=[id^="remove-"]
    FOR    ${button}    IN    @{remove_buttons}
        Click    ${button}
    END
