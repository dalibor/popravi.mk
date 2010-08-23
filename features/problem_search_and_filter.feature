Feature: Search and filter problems
  In order to to find problems
  As a user
  I want to be able to search and filter problems

    Scenario: Search problems by description
        Given there are reported problems for searching
        And I am on the home page
        When I follow "Преглед"
        When I fill in "s_q" with "Description 1"
        And I press "Барај"
        Then I should see "Вкупно пронајдени: 1 проблем"
        And I should see "Description 1"

    Scenario: Filter problems by category
        Given there are reported problems for searching
        And I am on the home page
        When I follow "Преглед"
        When I select "Category 1" from "s_c"
        And I press "Барај"
        Then I should see "Вкупно пронајдени: 2 проблеми"
        And I should see "Category 1"

    Scenario: Filter problems by municipality
        Given there are reported problems for searching
        And I am on the home page
        When I follow "Преглед"
        When I select "Municipality 1" from "s_m"
        And I press "Барај"
        Then I should see "Вкупно пронајдени: 2 проблеми"
        And I should see "Municipality 1"

    Scenario: Search problems in municipality
        Given there are reported problems for searching
        And I am on the home page
        When I follow "Преглед"
        And I follow "Municipality 1 2"
        Then I should see "Вкупно пронајдени: 2 проблеми"
