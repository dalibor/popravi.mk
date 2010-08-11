Feature: My problems
  In order to take ownership of anonymous problems
  As a signed in user
  I want to be able to take ownership of the problems reported with my address

  Scenario: Take ownership of problems reported by my email address
    Given There are anonymouse problems
    And I am an authenticated user
    When I go to the my_problems page
    Then I should see "Вкупно: 0 проблеми"
    And I should see "Дали сте ги пријавиле?"
    When I press "Преземи"
    Then I should see "Вкупно: 2 проблеми"
  
  Scenario: List problems reported by me
    Given I am an authenticated user
    And There are problems reported
    When I go to the my_problems page
    Then I should see "Вкупно: 1 проблем"
