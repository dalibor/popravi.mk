# Feature: Visitor can sign up
#   In order to be part of the system
#   As a visitor
#   I want to sign up for a new account in the system

#   Scenario: Sign up & activation
#     Given I am not authenticated
#     And I am on the sign up page
#     fill_in "Email" with "test_user@popravi.mk"
#     fill_in "Password" with "secretpass"
#     fill_in "Password confirmation" with "secretpass"
#     click_button "Register"
#     page.should have_content "You have signed up successfully. Confirmation was sent to your e-mail."
#     And I should be on the sign in page
#     #And "test_user@popravi.mk" should receive an email
#     And I should receive an email
#     When I open the email
#     page.should have_content "Confirmation instructions" in the email subject
#     click_link "Confirm my account" in the email
#     page.should have_content "Your account was successfully confirmed. You are now signed in."

#   Scenario: Sign up unsuccessful
#     Given I am not authenticated
#     And I am on the sign up page
#     fill_in "user_email" with "testing"
#     fill_in "user_password" with "secretpass"
#     fill_in "user_password_confirmation" with "secretpass"
#     click_button "Register"
#     Then I should not see "Успешно сте регистрирани"
#     And I should be on the redisplayed sign up page
#     And I should have no emails
