Feature: User can manage their problems
  In order to manage my problems
  As a user
  I want to be able to manage my address

  Scenario: List problems reported by me
    Given I am an authenticated user
    And I report a problem
    When I follow "My reports"
    Then I should see "Total: 1 problem"
    When I follow "Butel"
    And I follow "Edit"
    And I fill in "Description" with "New problem description"
    And I press "Update problem"
    Then I should see "New problem description"
