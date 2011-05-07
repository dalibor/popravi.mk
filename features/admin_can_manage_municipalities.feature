Feature: Admin can manage municipalities
  In order to modify municipalities where problems will be reported
  As a site administrator
  I want to be able to manage municipalities

  Scenario: Admin can manage municipalities
    Given I am authenticated as admin
    And a region exists
    And I follow "Admin"
    When I follow "Municipalities"
    And I follow "New"
    And I fill in "Name" with "Municipality name"
    And I select "Skopski" from "Region"
    And I press "Save"
    Then I should see "Municipality was successfully created"
    And I should see "Municipality name"
    When I follow "Edit"
    And I fill in "Name" with "Municipality name 2"
    And I press "Save"
    Then I should see "Municipality was successfully updated"
    And I should see "Municipality name 2"
