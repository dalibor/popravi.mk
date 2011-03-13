Feature: Visitor can see list of municipalities
  In order to see which municipalities has lots of problems
  As a visitor
  I want to be able to see list of municipalities with problems there

  Scenario: Visitor can see list of municipalities
    Given a region exists with name: "region1"
    And a municipality exists with name: "municipality1", region: the region
    And a problem exists with description: "problem1", municipality: the municipality
    And a problem exists with description: "problem2", municipality: the municipality
    And I am on the home page
    Then I should see "municipality1 2"
    When I follow "View all municipalities"
    Then I should be on the municipalities page
    Then I should see "municipality1"
    And I should see "Total problems 2"
    And I should see "region1"
