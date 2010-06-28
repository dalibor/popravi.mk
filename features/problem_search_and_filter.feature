Feature: Search and filter problems
  In order to to find problems
  As a user
  I want to be able to search and filter problems

    Scenario: Search problems by subject
        Given there are reported problems
        And I am on the home page
        When I follow "Problems"
        Then I should see "Total: 3 problems"
        When I fill in "q" with "Subject 1"
        And I press "Search"
        Then I should see "Total: 1 problem"
        And I should see "Subject 1"

    Scenario: Search problems by description
        Given there are reported problems
        And I am on the home page
        When I follow "Problems"
        Then I should see "Total: 3 problems"
        When I fill in "q" with "Description 1"
        And I press "Search"
        Then I should see "Total: 1 problem"
        And I should see "Description 1"

    Scenario: Filter problems by category
        Given there are reported problems
        And I am on the home page
        When I follow "Problems"
        Then I should see "Total: 3 problems"
        When I select "Category 1" from "Category"
        And I press "Search"
        Then I should see "Total: 1 problem"
        And I should see "Category 1"

    Scenario: Filter problems by municipality
        Given there are reported problems
        And I am on the home page
        When I follow "Problems"
        Then I should see "Total: 3 problems"
        When I select "Municipality 1" from "Municipality"
        And I press "Search"
        Then I should see "Total: 1 problem"
        And I should see "Municipality 1"
