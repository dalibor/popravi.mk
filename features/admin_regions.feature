Feature: Manage regions
    In order to modify regions where problems will be reported
    As a site administrator
    I want to manage regions

    Scenario: Manage regions
        Given I am authenticated as admin
            And I am on the admin page
            And there are no regions
            And there is country
        When I follow "Regions"
        Then I should see "No regions have been added yet"
        When I follow "New Region"
            And I fill in "Name" with "Region name"
            And I select "Macedonia" from "Country"
            And I press "Create"
        Then I should see "Region was successfully created"
            And I should see "Region name"
        When I follow "Edit"
          And I fill in "Name" with "Region name 2"
          And I press "Update"
        Then I should see "Region was successfully updated"
            And I should see "Region name 2"
