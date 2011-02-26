Feature: Admin can manage regions
  In order to modify regions where problems will be reported
  As a site administrator
  I want to be albe to manage regions

  Scenario: Admin can manage regions
    Given I am authenticated as admin
    And I am on the admin page
    And a country exists with name: "Macedonia"
    When I follow "Regions"
    When I follow "New"
    And I fill in "Name" with "Region name"
    And I select "Macedonia" from "Country"
    And I press "Save"
    Then I should see "Region was successfully created"
    And I should see "Region name"
    When I follow "Edit"
    And I fill in "Name" with "Region name 2"
    And I press "Save"
    Then I should see "Region was successfully updated"
    And I should see "Region name 2"
