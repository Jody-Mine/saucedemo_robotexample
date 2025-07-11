*** Settings ***
Documentation     Inventory page locators and element selectors
Library          Browser

*** Variables ***
${INVENTORY_CONTAINER}         data-test=inventory-container
${INVENTORY_LIST}             data-test=inventory-list
${PRODUCT_SORT}               css=.product_sort_container
${INVENTORY_ITEM}             css=.inventory_item
${INVENTORY_ITEM_NAME}        css=.inventory_item_name
${INVENTORY_ITEM_PRICE}       css=.inventory_item_price
${INVENTORY_ITEM_DESC}        css=.inventory_item_desc
${ADD_TO_CART_PREFIX}         id=add-to-cart-
${REMOVE_FROM_CART_PREFIX}    id=remove-
${SHOPPING_CART_BADGE}        css=.shopping_cart_badge
${SHOPPING_CART_LINK}         css=.shopping_cart_link

# Sort options
${SORT_AZ}                    az
${SORT_ZA}                    za
${SORT_LOHI}                  lohi
${SORT_HILO}                  hilo
