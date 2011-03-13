Feature: Visitor cannot rate a problem
  In order to count valid ratings
  As a visitor
  I want to not be able to rate a problem

  Scenario: Visitor cannot rate a problem
    Given a municipality exists with name: "Municipality 1"
    And a problem exists with municipality: the municipality
    And I am on the home page
    When I follow "Municipality 1" within ".main"
    Then page should not have ".formtastic.rate"
    And I should not see "Rate"
