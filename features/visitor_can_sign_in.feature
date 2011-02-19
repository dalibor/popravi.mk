Feature: Visitor can sign in
  In order to use the system's functionality
  As a visitor
  I want to be able to sign in into the system

  Scenario: Sign in successfully
    Given I am an authenticated user
    Then I should see "Signed in successfully."
    And I should be on the user problems page

  Scenario: Invalid login credentials
    Given I signed up as "test_user@popravi.mk" with password "secretpass"
    And I confirmed my email address
    When I go to the sign in page
    And I fill in "Email" with "test_user@popravi.mk"
    And I fill in "Password" with "wrongpass"
    And I press "Login"
    Then I should see "Invalid email or password"
    And I should be on the redisplayed sign in page

  Scenario: User has not confirmed email address
    Given I signed up as "test_user@popravi.mk" with password "secretpass"
    When I go to the sign in page
    And I fill in "user_email" with "test_user@popravi.mk"
    And I fill in "user_password" with "secretpass"
    And I press "Login"
    Then I should see "You have to confirm your account before continuing."
    And I should be on the redisplayed sign in page

    #Scenario: User account is locked
    #Given I signed up as "test_user@popravi.mk" with password "secretpass"
    #And I confirmed my email address
    #And my account is locked
    #When I go to the sign in page
    #And I fill in "user_email" with "test_user@popravi.mk"
    #And I fill in "user_password" with "secretpass"
    #And I press "Sign in"
    #Then I should see "Your account is locked"
    #And I should be on the redisplayed sign in page
