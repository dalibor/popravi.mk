Feature: Admin can manage API keys
  In order to open API for other client applications
  As a site administrator
  I want to be able to manage api keys

  @run
  Scenario: Admin can manage api keys
    Given I am authenticated as admin
    When I follow "API Keys"
    And I follow "New"
    And I fill in "Name" with "API Key 1"
    And I fill in "Key" with "y3i21o"
    And I fill in "Description" with "Key 1 description"
    And I press "Save"
    Then I should see "Api key was successfully created"
    And I should see "API Key 1"
    And I should see "y3i21o"
    And I should see "Key 1 description"
    When I follow "Edit"
    And I fill in "Name" with "API Key 2"
    And I press "Save"
    Then I should see "Api key was successfully updated"
    And I should see "API Key 2"
