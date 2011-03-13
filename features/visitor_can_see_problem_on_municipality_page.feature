Feature: Visitor can see problem on municipality page
  In order to see how municipality is working
  As a visitor
  I want to be able to see problem on municipality page

  Scenario: Visitor can see problems on municipality page
    Given a region exists with name: "region1"
    And a municipality exists with name: "municipality1", region: the region
    And a problem exists with description: "problem1", municipality: the municipality
    And I am on the home page
    Then I should see "municipality1 1"
    When I follow "View all municipalities"
    And I follow "municipality1"
    And I follow "problem1"
    Then I should see "problem1"
