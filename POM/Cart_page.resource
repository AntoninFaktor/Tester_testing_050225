*** Settings ***
Library           Browser
Variables        ../Test_data/test_data.py
Resource        Product_page.resource
Resource        Header.resource

*** Keywords ***
Unhappy Cart Update
    ${cart_amount}=    Get Text    div.amount
    IF    ${cart_amount} == 0
       Add ${test_item} to cart
    END
    Enter Cart
    @{item_amounts}=    Get Elements    input.amount
    FOR    ${char}    IN    @{Forbidden_chars}
        Type Text    @{item_amounts}[0]    ${char}
        ${new_amount}=    Get Text    @{item_amounts}[0]
        Should Not Match    ${char}    ${new_amount}
        Should Contain    div.popup    text=only numbers
    END

Start Checkout
    ${cart_amount}=    Get Text    div.amount
    IF    ${cart_amount} == 0
       Add ${Search_item} to cart
    END
    Enter cart
    Click    "Dokončit objednávku"