Feature: Admin can manage problems
  In order to validate problems information
  As a site administrator
  I want to be albe to manage problems

  Scenario: Admin can manage problems
    Given I am authenticated as admin
    And I am on the admin page
    And a category exists
    And a municipality exists
    When I follow "Problems"
    And I follow "New"
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

  Scenario: Admin can change state of a problem
    Given I am authenticated as admin
    And a problem exists with description: "problem1"
    When I follow "Problems"
    Then I should see "problem1"
    And column "7" row "2" should have text "reported"
    When I follow "Edit"
    And I select "solved" from "Status"
    And I press "Save"
    Then I should see "Problem was successfully updated"
    When I follow "List"
    And column "7" row "2" should have text "solved"
    When I follow "Edit"
    And I select "approved" from "Status"
    And I press "Save"
    Then I should see "Problem was successfully updated"
    When I follow "List"
    And column "7" row "2" should have text "approved"
