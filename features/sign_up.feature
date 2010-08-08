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
    When I press "Регистрирај ме"
    Then I should see "Потребно е да ја потврдите вашата сметка пред да продолжите понатаму"
    And I should be on the sign in page
    #And "test_user@popravi.mk" should receive an email
    And I should receive an email
    When I open the email
    Then I should see "Упатство за потврда" in the email subject
    When I follow "Потврди ја мојата сметка" in the email
    Then I should see "Најавени сте како test_user@popravi.mk"
  
  Scenario: Sign up unsuccessful
    Given I am not authenticated
    And I am on the sign up page
    And I fill in "user_email" with "testing"
    And I fill in "user_password" with "secretpass"
    And I fill in "user_password_confirmation" with "secretpass"
    When I press "Регистрирај ме"
    Then I should not see "Успешно сте регистрирани"
    And I should be on the redisplayed sign up page
    And I should have no emails
