Feature: Take problem ownership
  In order to take ownership of anonymous problems
  As a signed in user
  I want to be able to take ownership of the problems reported with my address

  Scenario: Take ownership of problems reported by my email address
    Given There are anonymouse problems
    And I am an authenticated user
    And I should see "Please select which problems have been reported by you to take ownership of them"
    When I press "Take ownership"
    Then I should see "Total: 2 problems"
  
  Scenario: List problems reported by me
    Given I am an authenticated user
    And There are problems reported
    When I go to the my problems page
    Then I should see "Total: 1 problem"
