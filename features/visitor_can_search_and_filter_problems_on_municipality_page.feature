Feature: Visitor can search and filter problems on municipality
  In order to to find problems on municipality page
  As a visitor
  I want to be able to search and filter problems

  Scenario: Search problems by description
    Given a municipality exists with name: "municipality1"
    And a problem exists with description: "Problem1", municipality: the municipality
    And a problem exists with description: "Problem2", municipality: the municipality
    And I am on the home page
    When I follow "municipality1 2"
    Then I should be on the municipality page for: the municipality
    And I should see "Problem1"
    And I should see "Problem2"
    When I fill in "Search" with "Problem1"
    And I press "Search"
    Then I should be on the municipality page for: the municipality
    And I should see "Total found: 1 problem"
    And I should see "Problem1"
    And I should not see "Problem2"

  Scenario: Filter problems by category
    Given a municipality exists with name: "municipality1"
    And a category exists with name: "Category1"
    And a problem exists with description: "Problem1", category: the category, municipality: the municipality
    And a category exists with name: "Category2"
    And a problem exists with description: "Problem2", category: the category, municipality: the municipality
    And I am on the home page
    When I follow "municipality1 2"
    Then I should be on the municipality page for: the municipality
    And I should see "Problem1"
    And I should see "Problem2"
    When I select "Category1" from "Category"
    And I press "Search"
    Then I should be on the municipality page for: the municipality
    And I should see "Total found: 1 problem"
    And I should see "Problem1"
    And I should not see "Problem2"

  Scenario: Filter problems by status
    Given a municipality exists with name: "municipality1"
    And a problem exists with description: "Problem1", municipality: the municipality, status: "approved"
    And a problem exists with description: "Problem2", municipality: the municipality, status: "activated"
    And I am on the home page
    When I follow "municipality1 2"
    Then I should be on the municipality page for: the municipality
    And I should see "Problem1"
    And I should see "Problem2"
    When I select "approved" from "Status"
    And I press "Search"
    Then I should be on the municipality page for: the municipality
    And I should see "Total found: 1 problem"
    And I should see "Problem1"
    And I should not see "Problem2"

    @run
  Scenario Outline: Search problems by date
    Given a municipality exists with name: "municipality1"
    And a problem exists with description: "Problem1", municipality: the municipality, created_at: "2010-07-20 20:25:49"
    And a problem exists with description: "Problem2", municipality: the municipality, created_at: "2011-08-20 20:25:49"
    And I am on the home page
    When I follow "municipality1 2"
    Then I should be on the municipality page for: the municipality
    And I should see "Problem1"
    And I should see "Problem2"
    When I select "<month>" from "Month"
    And I select "<year>" from "Year"
    And I press "Search"
    Then I should be on the municipality page for: the municipality
    And I should see "Total found: 1 problem"
    And I should see "<see>"
    And I should not see "<not_see>"

    Examples:
       | month  | year | see       | not_see   |
       | July   | 2010 | Problem1 | Problem2 |
       | July   |      | Problem1 | Problem2 |
       | August | 2011 | Problem2 | Problem1 |
       | August |      | Problem2 | Problem1 |
       |        | 2010 | Problem1 | Problem2 |
       |        | 2011 | Problem2 | Problem1 |
