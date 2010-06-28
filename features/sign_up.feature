Feature: Sign up
  In order to log into the system
  As a user
  I want to register a new account with the system
  
  Scenario: Sign up & activation
    Given I am not authenticated
    And I am on the sign up page
    And I fill in "user_email" with "test_user@popravi.mk"
    And I fill in "user_password" with "secretpass"
    And I fill in "user_password_confirmation" with "secretpass"
    When I press "Sign up"
    Then I should see "You have to confirm your account before continuing"
    And I should be on the sign in page
    #And "test_user@popravi.mk" should receive an email
    And I should receive an email
    When I open the email
    Then I should see "Confirmation instructions" in the email subject
    When I follow "Confirm my account" in the email
    Then I should see "Signed in as test_user@popravi.mk"
  
  Scenario: Sign up unsuccessful
    Given I am not authenticated
    And I am on the sign up page
    And I fill in "user_email" with "testing"
    And I fill in "user_password" with "secretpass"
    And I fill in "user_password_confirmation" with "secretpass"
    When I press "Sign up"
    Then I should not see "You have signed up successfully"
    And I should be on the redisplayed sign up page
    And I should have no emails
