*** Settings ***
Library           Browser
Variables        ../Test_data/test_data.py

*** Keywords ***
Search ${term}
    TRY
        Type Text    input.searchField    ${term}
    EXCEPT    Go To    ${domain}
        Type Text    input.searchField    ${term}
    END
    Click    "Vyhledej"
    IF    ${term} == ${non_existent_item}
        Should Contain    section.productsGrid    text=Zkuste vyhledat něco jiného
    ELSE
        @{results}=    Get Elements    text=${term}
        Should Not Be Empty    @{results}
  
Enter Cart
        Click    button.cart