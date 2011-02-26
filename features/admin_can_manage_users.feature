Feature: Admin can manage users
  In order to validate users information
  As a site administrator
  I want to be albe to manage users

  Scenario: Admin can manage users
    Given I am authenticated as admin
    When I follow "Users"
    And I follow "New"
    And I fill in "Name" with "Test User 2"
    And I fill in "Email" with "test_user2@popravi.mk"
    And I fill in "Password" with "secretpass"
    And I fill in "Password confirmation" with "secretpass"
    And I press "Save"
    Then I should see "User was successfully created"
    And I should see "Test User 2"
    When I follow "Edit"
    And I fill in "Name" with "Test User 3"
    And I press "Save"
    Then I should see "User was successfully updated"
    And I should see "Test User 3"
