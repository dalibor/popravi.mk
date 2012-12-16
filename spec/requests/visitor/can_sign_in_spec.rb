# Feature: Visitor can sign in
#   In order to use the system's functionality
#   As a visitor
#   I want to be able to sign in into the system

#   Scenario: Sign in successfully
#     Given I am an authenticated user
#     page.should have_content "Signed in successfully."
#     And I should be on the user problems page

#   Scenario: Invalid login credentials
#     Given I signed up as "test_user@popravi.mk" with password "secretpass"
#     And I confirmed my email address
#     When I go to the sign in page
#     fill_in "Email" with "test_user@popravi.mk"
#     fill_in "Password" with "wrongpass"
#     click_button "Login"
#     page.should have_content "Invalid email or password"
#     And I should be on the redisplayed sign in page

#   Scenario: User has not confirmed email address
#     Given I signed up as "test_user@popravi.mk" with password "secretpass"
#     When I go to the sign in page
#     fill_in "user_email" with "test_user@popravi.mk"
#     fill_in "user_password" with "secretpass"
#     click_button "Login"
#     page.should have_content "You have to confirm your account before continuing."
#     And I should be on the redisplayed sign in page

#     #Scenario: User account is locked
#     #Given I signed up as "test_user@popravi.mk" with password "secretpass"
#     #And I confirmed my email address
#     #And my account is locked
#     #When I go to the sign in page
#     #fill_in "user_email" with "test_user@popravi.mk"
#     #fill_in "user_password" with "secretpass"
#     #click_button "Sign in"
#     #page.should have_content "Your account is locked"
#     #And I should be on the redisplayed sign in page
