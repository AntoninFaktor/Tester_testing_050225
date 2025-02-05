*** Settings ***
Library           Browser

*** Keywords ***
Verify 404 Page
    ${status}=    Get Page Status
    Should Be Equal As Numbers    ${status}    404
    ${message}=    Get Text    xpath=//p[contains(text(), 'The page you are looking for could not be found.')]
    Should Contain    ${message}    The page you are looking for could not be found.
