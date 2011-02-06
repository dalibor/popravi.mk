Feature: Manage countries
  In order to modify countries where problems will be reported
  As a site administrator
  I want to manage countries

  Scenario: Manage countries
    Given I am authenticated as admin
    And I am on the admin page
    And there are no countries
    When I follow "Countries"
    When I follow "New"
    And I fill in "Name" with "Country name"
    And I press "Save"
    Then I should see "Country was successfully created"
    And I should see "Country name"
    When I follow "Edit"
    And I fill in "Name" with "Country name 2"
    And I press "Save"
    Then I should see "Country was successfully updated"
    And I should see "Country name 2"
