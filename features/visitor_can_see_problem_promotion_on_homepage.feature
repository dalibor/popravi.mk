Feature: Visitor can see problem promotion on home page
  In order to promote municipality for their work
  As a visitor
  I want to be able to see problem problem promotion on home page

  Scenario: Visitor can see problem promotion on home page
    Given a region exists with name: "region1"
    And a municipality exists with name: "municipality1", region: the region
    And a problem exists with description: "problem1", municipality: the municipality, status: "solved"
    And the problem status has changed to: "solved"
    And I am on the home page
    Then I should see "municipality1 solved a problem"
