*** Settings ***
Documentation    Tests for product sorting functionality
Library         Browser
Library         Collections
Resource        ../../../configs/browser-config.robot
Resource        ../steps/inventory-steps.robot

Suite Setup      Setup Browser
Suite Teardown   Close Browser    ALL
Test Setup       Setup Product Sort Test
Test Teardown    Close Context

*** Test Cases ***
Sort Products Alphabetically A to Z
    [Documentation]    Verify products can be sorted alphabetically A to Z
    [Tags]    sort    inventory    positive
    Sort Products    ${SORT_AZ}
    Verify Products Sorted Alphabetically    ascending=${True}

Sort Products Alphabetically Z to A
    [Documentation]    Verify products can be sorted alphabetically Z to A
    [Tags]    sort    inventory    positive
    Sort Products    ${SORT_ZA}
    Verify Products Sorted Alphabetically    ascending=${False}

Sort Products By Price Low to High
    [Documentation]    Verify products can be sorted by price low to high
    [Tags]    sort    inventory    positive
    Sort Products    ${SORT_LOHI}
    Verify Products Sorted By Price    ascending=${True}

Sort Products By Price High to Low
    [Documentation]    Verify products can be sorted by price high to low
    [Tags]    sort    inventory    positive
    Sort Products    ${SORT_HILO}
    Verify Products Sorted By Price    ascending=${False}

Verify Default Sort Order
    [Documentation]    Verify default sort order is A to Z
    [Tags]    sort    inventory    positive
    Verify Products Sorted Alphabetically    ascending=${True}

Verify Sort Persistence After Cart Update
    [Documentation]    Verify sort order persists after adding items to cart
    [Tags]    sort    inventory    positive
    Sort Products    ${SORT_HILO}
    Verify Products Sorted By Price    ascending=${False}
    Add Product To Cart    sauce-labs-backpack
    Verify Products Sorted By Price    ascending=${False}
