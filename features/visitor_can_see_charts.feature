Feature: Visitor can see charts
  In order to view visual representation of charts
  As a visitor
  I want to be able to view charts

  Scenario Outline: Visitor can see a chart
    Given a problem exists with description: "Description 1"
    And a problem exists with description: "Description 2"
    And I am on the home page
    And I follow "Problems"
    And I follow "<chart_type>"
    Then I should see "<chart_title>"

    Examples:
      | chart_type   | chart_title              |
      | Category     | Problems by category     |
      | Municipality | Problems by municipality |
      | Status       | Problems by status       |
