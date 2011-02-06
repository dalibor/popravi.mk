Feature: Manage categories
  In order to modify categories of reported problems
  As a site administrator
  I want to manage categories

  Scenario: Manage categories
    Given I am authenticated as admin
    And I am on the admin page
    And there are no categories
    When I follow "Categories"
    And I follow "New"
    And I fill in "Name" with "Category name"
    And I press "Save"
    Then I should see "Category was successfully created"
    And I should see "Category name"
    When I follow "Edit"
    And I fill in "Name" with "Category name 2"
    And I press "Save"
    Then I should see "Category was successfully updated"
    And I should see "Category name 2"

  Scenario: Change position of category
    Given I am authenticated as admin
    And a category exists with name: "Category 1", position: "1"
    And a category exists with name: "Category 2", position: "2"
    And I am on the admin page
    When I follow "Categories"
    Then I should see "Category 1" within ".odd"
    And I should see "Category 2" within ".even"
    When I follow "Move up"
    Then I should see "Category 1" within ".even"
    And I should see "Category 2" within ".odd"
