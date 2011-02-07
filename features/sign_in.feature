Feature: Sign in
  In order to use the system's functionality
  As a user
  I want to be able to log into the system

  @wip
  Scenario: Sign in successfully
    Given I am an authenticated user
    Then I should see "Успешно сте најавени"
    And I should be on the my_problems page

  @wip
  Scenario: Invalid login credentials
    Given I signed up as "test_user@popravi.mk" with password "secretpass"
    And I confirmed my email address
    When I go to the sign in page
    And I fill in "user_email" with "test_user@popravi.mk"
    And I fill in "user_password" with "wrongpass"
    And I press "Најави ме"
    Then I should see "Невалиден e-mail или лозинка"
    And I should be on the redisplayed sign in page

  Scenario: User has not confirmed email address
    Given I signed up as "test_user@popravi.mk" with password "secretpass"
    When I go to the sign in page
    And I fill in "user_email" with "test_user@popravi.mk"
    And I fill in "user_password" with "secretpass"
    And I press "Најави ме"
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
