*** Settings ***
Documentation     Steps for checkout process tests
Resource         ../../../keywords/pages/login-keywords.robot
Resource         ../../../keywords/pages/inventory-keywords.robot
Resource         ../../../keywords/pages/checkout-keywords.robot

*** Keywords ***
Login And Prepare Cart
    New Context    viewport={'width': 1920, 'height': 1080}
    Login As Standard User
    Add Product To Cart    sauce-labs-backpack
    Add Product To Cart    sauce-labs-bike-light
    Open Shopping Cart
