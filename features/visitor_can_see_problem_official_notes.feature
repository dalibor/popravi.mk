Feature: Visitor can see problem's official notes
  In order to see details about a problem resolution
  As a visitor
  I want be able to see problem's official notes

  Scenario: Visitor can see problem's official notes
    Given a user exists
    And a municipality exists with name: "Municipality 1"
    And a problem exists with user: the user, municipality: the municipality, description: "problem1", official_notes: "problem1 official notes"
    And I am on the home page
    When I follow "problem1"
    Then I should see "problem1"
    And I should see "problem1 official notes"
