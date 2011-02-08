Feature: My problems
  In order to take ownership of anonymous problems
  As a signed in user
  I want to be able to take ownership of the problems reported with my address

  Scenario: Take ownership of problems reported by my email address
    Given a problem exists with email: "test_user@popravi.mk", description: "Problem 1"
    And a problem exists with email: "test_user@popravi.mk", description: "Problem 2"
    And I am an authenticated user
    When I go to the my_problems page
    Then I should see "Total: 0 problems"
    And I should see "Have you reported these problems?"
    When I press "Take ownership"
    Then I should see "Total: 2 problems"

  Scenario: List problems reported by me
    Given I am an authenticated user
    And I report a problem
    When I go to the my_problems page
    Then I should see "Total: 1 problem"
