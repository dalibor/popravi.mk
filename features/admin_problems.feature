Feature: Manage problems
  In order to validate problems information
  As a site administrator
  I want to manage problems

  Scenario: Manage problems
    Given I am authenticated as admin
    And I am on the admin page
    And there are no problems
    And a category exists
    And a municipality exists
    When I follow "Problems"
    When I follow "New"
    And I fill in "Description" with "Problem description"
    And I attach the file "public/images/rails.png" to "Photo"
    And I fill in "Latitude" with "42"
    And I fill in "Longitude" with "21"
    And I fill in "Email" with "test_user@popravi.mk"
    And I select "Abandoned vehicles" from "problem_category_id"
    And I select "Butel" from "problem_municipality_id"
    And I press "Save"
    Then I should see "Problem was successfully created"
    And I should see "Problem description"
    When I follow "Edit"
    And I fill in "Description" with "Problem description 2"
    And I press "Save"
    Then I should see "Problem was successfully updated"
    And I should see "Problem description 2"
