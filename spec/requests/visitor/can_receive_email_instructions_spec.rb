# Feature: Visitor can receive email instructions
#   In order to correct issues with my account
#   As a visitor
#   I want to be able to receive instructions via email

#   Scenario: Resend email confirmation instructions and activate account
#     Given I signed up as "test_user@popravi.mk" with password "secretpass"
#     And I am not authenticated
#     click_link "Sign in"
#     click_link "I didn't received confirmation instructions on email?"
#     When I fill in "Email" with "test_user@popravi.mk"
#     click_button "Send confirmation"
#     page.should have_content "You will receive an email with instructions about how to confirm your account in a few minutes."
#     And I should receive 2 emails
#     When I open the email with subject "Confirmation instructions"
#     click_link "Confirm my account" in the email
#     page.should have_content "Your account was successfully confirmed. You are now signed in."

#   Scenario: Send password change instructions and change password
#     Given I signed up as "test_user@popravi.mk" with password "secretpass"
#     And I am not authenticated
#     click_link "Sign in"
#     click_link "I forgot my password"
#     And I confirmed my email address
#     And I go to the send password instructions page
#     When I fill in "user_email" with "test_user@popravi.mk"
#     click_button "user_submit"
#     page.should have_content "You will receive an email with instructions about how to reset your password in a few minutes."
#     And I should receive 2 emails
#     When I open the email with subject "Reset password instructions"
#     page.should have_content "Reset password instructions" in the email subject
#     click_link "Change my password" in the email
#     page.should have_content "Change your password"
#     When I fill in "Password" with "newsecretpass"
#     fill_in "Password confirmation" with "newsecretpass"
#     click_button "Change my password"
#     page.should have_content "Your password was changed successfully. You are now signed in."

#     #Scenario: Resend unlock account instructions
#     #Given I am not authenticated
#     #And I signed up as "johndoe3@example.com" with password "secretpass"
#     #And I confirmed my email address
#     #And my account is locked
#     #And I go to the send unlock instructions page
#     #When I fill in "user_email" with "johndoe3@example.com"
#     #click_button "Resend"
#     #page.should have_content "instructions about how to unlock your account"
#     #And an email should be sent to "johndoe3@example.com" with "Unlock my account" in the body
