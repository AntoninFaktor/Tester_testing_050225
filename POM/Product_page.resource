*** Settings ***
Library           Browser
Resource        Search.resource

*** Keywords ***
Add ${item_name} To Cart
    ${product_name}=    Get Text    h1.title
    Should Contain    ${product_name}    ${item_name}
    ${cart_amount_before}=    Get Text    div.amount
    ${availability}=    Get Text    div.stockAvailability
    Click    text=do košíku
    ${cart_amount_after}=    Get Text    div.amount
    Run Keyword If    '${availability}'=='Skladem'    Evaluate    ${cart_amount_before} < ${cart_amount_after}
    ...    ELSE    Evaluate    ${cart_amount_before} == ${cart_amount_after}
