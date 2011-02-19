Feature: Visitor can sign up
  In order to be part of the system
  As a visitor
  I want to sign up for a new account in the system

  Scenario: Sign up & activation
    Given I am not authenticated
    And I am on the sign up page
    And I fill in "Email" with "test_user@popravi.mk"
    And I fill in "Password" with "secretpass"
    And I fill in "Password confirmation" with "secretpass"
    When I press "Register"
    Then I should see "You have signed up successfully. Confirmation was sent to your e-mail."
    And I should be on the sign in page
    #And "test_user@popravi.mk" should receive an email
    And I should receive an email
    When I open the email
    Then I should see "Confirmation instructions" in the email subject
    When I follow "Confirm my account" in the email
    Then I should see "Your account was successfully confirmed. You are now signed in."

  Scenario: Sign up unsuccessful
    Given I am not authenticated
    And I am on the sign up page
    And I fill in "user_email" with "testing"
    And I fill in "user_password" with "secretpass"
    And I fill in "user_password_confirmation" with "secretpass"
    When I press "Register"
    Then I should not see "Успешно сте регистрирани"
    And I should be on the redisplayed sign up page
    And I should have no emails
