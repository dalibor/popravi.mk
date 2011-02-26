Feature: Visitor can search and filter problems
  In order to to find problems
  As a visitor
  I want to be able to search and filter problems

  Scenario: Search problems by description
    Given a problem exists with description: "Description 1"
    And a problem exists with description: "Description 2"
    And I am on the home page
    And I follow "Problems"
    When I fill in "Search" with "Description 1"
    And I press "Search"
    Then I should see "Total found: 1 problem"
    And I should see "Description 1"
    And I should not see "Description 2"

  Scenario: Filter problems by category
    Given a category exists with name: "Category 1"
    And a problem exists with description: "Problem from category 1", category: the category
    And a category exists with name: "Category 2"
    And a problem exists with description: "Problem from category 2", category: the category
    And I am on the home page
    And I follow "Problems"
    When I select "Category 1" from "Category"
    And I press "Search"
    Then I should see "Total found: 1 problem"
    And I should see "Problem from category 1"
    And I should not see "Problem from category 2"

  Scenario: Filter problems by municipality
    Given a municipality exists with name: "Municipality 1"
    And a problem exists with description: "Problem from municipality 1", municipality: the municipality
    Given a municipality exists with name: "Municipality 2"
    And a problem exists with description: "Problem from municipality 2", municipality: the municipality
    And I am on the home page
    And I follow "Problems"
    When I select "Municipality 1" from "Municipality"
    And I press "Search"
    Then I should see "Total found: 1 problem"
    And I should see "Problem from municipality 1"
    And I should not see "Problem from municipality 2"

  Scenario: Filter problems by status
    Given a municipality exists with name: "Municipality 1"
    And a problem exists with description: "Problem from municipality 1", municipality: the municipality, status: "approved"
    Given a municipality exists with name: "Municipality 2"
    And a problem exists with description: "Problem from municipality 2", municipality: the municipality, status: "activated"
    And I am on the home page
    And I follow "Problems"
    When I select "approved" from "Status"
    And I press "Search"
    Then I should see "Total found: 1 problem"
    And I should see "Problem from municipality 1"
    And I should not see "Problem from municipality 2"

  Scenario Outline: Search problems by date
    Given a municipality exists with name: "Municipality 1"
    And a problem exists with description: "Problem 1", municipality: the municipality, created_at: "2010-07-20 20:25:49"
    Given a municipality exists with name: "Municipality 2"
    And a problem exists with description: "Problem 2", municipality: the municipality, created_at: "2011-08-20 20:25:49"
    And I am on the home page
    And I follow "Problems"
    When I select "<month>" from "Month"
    And I select "<year>" from "Year"
    And I press "Search"
    And I should see "<see>"
    And I should not see "<not_see>"

    Examples:
       | month  | year | see       | not_see   |
       | July   | 2010 | Problem 1 | Problem 2 |
       | July   |      | Problem 1 | Problem 2 |
       | August | 2011 | Problem 2 | Problem 1 |
       | August |      | Problem 2 | Problem 1 |
       |        | 2010 | Problem 1 | Problem 2 |
       |        | 2011 | Problem 2 | Problem 1 |
