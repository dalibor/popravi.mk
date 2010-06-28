Feature: Update user information
  In order to keep my info up-to-date
  As a user
  I want to be able to update my information
  
  Scenario: Change and confirm email
    Given I am an authenticated user
    And I am on the edit user page
    When I fill in "user_email" with "new_test_user@popravi.mk"
    And I fill in "user_password" with "newpass"
    And I fill in "user_password_confirmation" with "newpass"
    And I fill in "user_current_password" with "secretpass"
    When I press "Update"
    Then I should see "You updated your account successfully"
    And I should be on the home page
    And I should receive an email
    When I open the email
    Then I should see "Confirmation instructions" in the email subject
    When I follow "Confirm my account" in the email
    Then I should see "Signed in as new_test_user@popravi.mk"
  
  Scenario: Wrong current password
    Given I am an authenticated user
    And I am on the edit user page
    When I fill in "user_email" with "new_test_user@popravi.mk"
    And I fill in "user_password" with "newpass"
    And I fill in "user_password_confirmation" with "newpass"
    And I fill in "user_current_password" with "wrongpass"
    When I press "Update"
    Then I should see "Current password is invalid"
    And I should be on the redisplayed edit user page
  
  #Scenario: Cancel user account
    #Given I am an authenticated user
    #And I am on the edit user page
    #When I follow "Cancel my account"
    #Then I should be on the sign in page
    #And my account should not be found
