Feature: Manage categories
    In order to modify categories of reported problems
    As a site administrator
    I want to manage categories

    Scenario: Manage categories
        Given I am authenticated as admin
            And I am on the admin page
            And there are no categories
        When I follow "Categories"
        Then I should see "No categories have been added yet"
        When I follow "New Category"
            And I fill in "Name" with "Category name"
            And I press "Create"
        Then I should see "Category was successfully created"
            And I should see "Category name"
        When I follow "Edit"
          And I fill in "Name" with "Category name 2"
          And I press "Update"
        Then I should see "Category was successfully updated"
            And I should see "Category name 2"
