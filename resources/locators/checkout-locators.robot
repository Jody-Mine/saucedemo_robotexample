*** Settings ***
Documentation    Locators for checkout pages
Library         Browser

*** Variables ***
${CHECKOUT_BUTTON}              id=checkout
${CONTINUE_SHOPPING_BUTTON}     id=continue-shopping
${FINISH_BUTTON}               id=finish
${FIRST_NAME_INPUT}           id=first-name
${LAST_NAME_INPUT}            id=last-name
${POSTAL_CODE_INPUT}          id=postal-code
${CONTINUE_BUTTON}            id=continue
${CART_ITEM}                  css=.cart_item
${ITEM_PRICE}                 css=.inventory_item_price
${CHECKOUT_COMPLETE_HEADER}    css=.complete-header
${ERROR_MESSAGE}              css=[data-test="error"]
${CART_CONTENTS}              id=cart_contents_container
${CHECKOUT_SUMMARY}           id=checkout_summary_container
${TAX_AMOUNT}                 css=.summary_tax_label
${CANCEL_BUTTON}              id=cancel
${CART_CONTAINER}             id=cart_contents_container
