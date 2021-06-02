*** Settings ***
Documentation  Sample test for Miro signup
Library    OperatingSystem
Library    SeleniumLibrary
Library    SeleniumScreenshots
Library    DateTime
Library    XML
Library    Reserved
Test Setup   Open browser to signup page
Test Teardown  Close Browser

*** Variables ***
${Browser} =    Chrome
${miro_signup_url}=  https://miro.com/signup/
${user_name} =  Abcdefg
${email_id} =  teabcd12345@test.com
${password} =  P@ssw0rd_123


*** Test Cases ***
Successfull Signup
    [Tags]  Scenario1
    [Documentation]  This test case will verify the successfull creation of the account with Miro.
    Create Miro account

No account should be created if Terms and Privacy policy checkbox not selected
    [Tags]  Scenario2
    [Documentation]  This test case will verify whether terms and privacy policy is selected.
    Do not select Terms and Privacy policy

User message should be prompt if no password provided    
    [Tags]  Scenario3
    [Documentation]  "Please enter your password" message should be displayed if no password entered in the Password textbox.
    Do not enter the password  

User message should be prompt if no Name provided 
    [Tags]  Scenario4
    [Documentation]  "Please enter your Name" message should be displayed if no Name entered in the Name text box
    Do not enter Name

User message should be prompt if no email id provided
    [Tags]  Scenario5
    [Documentation]  "Please enter your Email address" message should be displayed if no email address entered in the email text box
    Do not enter email

User message should be displayed if invalid email address provided
    [Tags]  Scenario6
    [Documentation]  "This doesn’t look like an email address. Please check it for typos and try again." message should be displayed if invalid email addess provided
    Invalid emailid

Should not allow the user to register if already registered email address provided
    [Tags]  Scenario7
    [Documentation]  Check if the system allows the user to register the account when passing already registered email address
    Already registed email address

Verify password policy
    [Tags]  Scenario9
    [Documentation]  Verifies the password meets the password policy
    Check the password

*** Keywords ***
Open browser to signup page
    [Documentation]  Open the browser
    Open browser   about:blank  ${browser}
    Maximize Browser Window
    Go to miro singup page

Go to miro singup page
    [Documentation]  Open Miro signup page
    go to  ${miro_signup_url}
    Get started free today page should be open

Get started free today page should be open
    [Documentation]  Verifies the signup page
    Page Should Contain    Get started free today
        
Create Miro account
    [Documentation]  Successfull creation of the account to Miro
    Enter Username  ${user_name}
    Enter EmailID  ${email_id}
    Enter Password  ${password}
    Select Terms Checkbox
    Click on Get started now button
    
Do not select Terms and Privacy policy
    [Documentation]  Do not select the Terms and Privacy policy checkbox
    Enter Username  ${user_name}
    Enter EmailID  ${email_id}
    Enter Password  ${password}
    Click Get started now button
    ${get_text} =   Get Text    xpath://div[contains(text(),'Please agree with the Terms to sign up.')]
    Should Be Equal As Strings    Please agree with the Terms to sign up.    ${get_text}

Do not enter the password
    [Documentation]  Leave password text box blank and check the user message
    Enter Username  ${user_name}
    Enter EmailID  ${email_id}
    Enter Password  ${EMPTY}
    Select Terms Checkbox
    Click Get started now button
    ${get_text} =   Get Text    xpath://div[contains(text(),'Please enter your password.')]
    Should Be Equal As Strings    Please enter your password.    ${get_text}

Do not enter Name
    [Documentation]  Leave Name text box blank and check the user message
    Enter Username  ${EMPTY}
    Enter EmailID  ${email_id}
    Enter Password  ${password}
    Select Terms Checkbox
    Click Get started now button
    Wait Until Element Is Visible    xpath://div[contains(text(),'Please enter your name.')]
    ${get_text} =   Get Text    xpath://div[contains(text(),'Please enter your name.')]
    Should Be Equal As Strings    Please enter your name.    ${get_text}

Do not enter email
    [Documentation]  Leave email address text box blank and check the user message
    Enter Username  ${user_name}
    Enter EmailID    ${EMPTY}
    Enter Password  ${password}
    Select Terms Checkbox
    Click Get started now button
    ${get_text} =   Get Text    xpath://div[contains(text(),'Please enter your email address.')]
    Should Be Equal As Strings    Please enter your email address.    ${get_text}

Invalid emailid
    [Documentation]  Enter invalid or incomplete email address in email text box and check the user message.
    ...  the values are assigned to all variables in variables section
    Enter Username  ${user_name}
    Enter EmailID  abcdef_ghij@gmil
    Enter Password  ${password}
    Select Terms Checkbox
    Click Get started now button
    ${get_text} =   Get Text    xpath://div[contains(text(),'This doesn’t look like an email address. Please ch')]
    Should Be Equal As Strings    This doesn’t look like an email address. Please check it for typos and try again.    ${get_text}

Already registed email address
    [Documentation]  Enter already registered email id and check whether the message to the user is prompt
    Enter Username  ${user_name}
    Enter EmailID  ${email_id}
    Enter Password  ${password}
    Select Terms Checkbox
    Click Get started now button
    ${get_text} =   Get Text    xpath://div[contains(text(),'Sorry, this email is already registered')]
    Should Be Equal As Strings    Sorry, this email is already registered    ${get_text}

Check the password
    [Documentation]  Throws warning message if the password not meets the password policy.
    Enter Username  ${user_name}
    Enter EmailID  ${email_id}
    @{password_list} =    Create List    abcd  password   Welc@me1234   Welc@me_1234
    FOR    ${pswd}    IN    @{password_list}
        Log    ${pswd}
        Enter Password    ${pswd}
        ${length_pswrd} =   Get Length    ${pswd}
        Run Keyword IF    ${length_pswrd} <= 7     Check the message if password <8 char
        
        ...    ELSE IF    ${length_pswrd} >= 8 and ${length_pswrd} <=9    Check the message if password >=8 and <=9 char

        ...    ELSE IF    ${length_pswrd} >9 and ${length_pswrd}<=11    Check the message if password >9 and <=11 char
        
        ...    ELSE IF    ${length_pswrd} >11    Check the message if password >11
            
    END
    
Check the message if password <8 char
    Wait Until Element Is Visible    xpath://div[contains(text(),'Please use 8+ characters for secure password')]
    ${get_warning} =   Get Text    xpath://div[contains(text(),'Please use 8+ characters for secure password')]
    Should Be Equal As Strings    Please use 8+ characters for secure password    ${get_warning}

Check the message if password >=8 and <=9 char
    Wait Until Element Is Visible    xpath://div[contains(text(),'So-so password')]
    ${get_warning} =   Get Text    xpath://div[contains(text(),'So-so password')]
    Should Be Equal As Strings    So-so password    ${get_warning}

Check the message if password >9 and <=11 char
    Wait Until Element Is Visible    xpath://div[contains(text(),'Good password')]
    ${get_warning} =   Get Text    xpath://div[contains(text(),'Good password')]
    Should Be Equal As Strings    Good password   ${get_warning}

Check the message if password >11
    Wait Until Element Is Visible    xpath://div[contains(text(),'Great password')]
    ${get_warning} =   Get Text    xpath://div[contains(text(),'Great password')]
    Should Be Equal As Strings    Great password    ${get_warning}

Open Miro signup page
    [Documentation]  Open the page any browser and pass Miro sign up url
    open browser   about:blank  ${browser}
    Maximize Browser Window
    go to     ${miro_signup_url}

Enter Username
    [Documentation]  Enters valid name or leave blank
    [Arguments]  ${username}
    Input Text   id:name  ${username}

Enter EmailID
    [Documentation]  Enters valid or invalid email address or leave blank 
    [Arguments]  ${emailid}
    Input Text   id:email  ${emailid}

Enter Password
    [Documentation]  Enters valid or invalid password or leave blank
    [Arguments]  ${pswd}
    Input Text    id:password   ${pswd}

Select Terms Checkbox
    [Documentation]  Selects Terms and Privacy policy checkbox
    Execute Javascript    $('#signup-terms').click()

Click Get started now button
    [Documentation]  Clicks on Get started now button
    Click Button    class:signup__submit
    Capture Page Screenshot

Click on Get started now button
    [Documentation]  Clicks on Get started now 
    Capture Page Screenshot
    Click Button    class:signup__submit
    Capture Page Screenshot
    ${page_title} =   Get Title
    Run Keyword If    "${page_title}" == "Please check your email, Online Whiteboard | Miro"    Verify email confirmation page opened
    ...    ELSE    Existing email id

Verify email confirmation page opened
    [Documentation]  Verifies the page asked for confirmation code sent to registered email id to activate the account.
    Page Should Contain    Check your email
    Page Should Contain    We've sent you a six-digit confirmation code to ${email_id}. Please enter it below to confirm your email address.
    Page Should Contain Textfield    id:code
    

Existing email id
    [Documentation]  Verifies the message if existing email id provided
    ${get_text} =   Get Text    xpath://div[contains(text(),'Sorry, this email is already registered')]
    Should Be Equal As Strings    Sorry, this email is already registered    ${get_text}