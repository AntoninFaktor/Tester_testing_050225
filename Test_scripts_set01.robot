*** Settings ***
Documentation     A test suite for recruitment purposes.

Library           Browser

Resource          ./Test_data/test_data.py
...               ./POM/Cart_page.resource
...               ./POM/Header.resource
...               ./POM/Product_page.resource
...               ./POM/404.resource

*** Test Cases ***
Start Checkout Test
    [Documentation]    Test the checkout process starting from loading the domain to starting the checkout.
    [Tags]    smoke    happy    critical    cart    checkout    search    product_page
    Load page
    Search ${test_item}
    Click ${test_item}
    Add ${test_item} to cart
    Start checkout

Forbidden Char Cart Update Test
    [Documentation]    Test updating the cart with forbidden characters.
    [Tags]    unhappy    cart
    Load page
    Add ${test_item} to cart
    Unhappy Cart Update

404 Page Test
    [Documentation]    Test the 404 page.
    [Tags]    unhappy    critical
    Load page
    Go to     ${domain}/i-do-not-exist
    Varify 404 Page

Search Non-existent Item Test
    [Documentation]    Test searching for a non-existent item.
    [Tags]    unhappy    search    
    Load page
    Search list @{non_existent_item}
    
Cart Accessibility Test
    [Documentation]    Test the accessibility of the cart from various pages.
    [Tags]    happy    cart    
    Load page
    Enter cart
    Enter cart
    Go To    ${domain}/category/clogs
    Enter cart
    Start checkout
    Enter cart

*** Keywords ***
Load page
    New Page     ${domain}

Search list ${list}
    FOR    ${item}    in     ${list}
        Search ${item}
        Click    div.productContainer[0]
    END