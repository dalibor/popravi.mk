Feature: Visitor can see home page
  In order to see what is this app about
  As a visitor
  I want to be able to land on the home page

  Scenario: Visiting the site for the first time
    Given I am on the home page
    Then I should see "Improve your city"

  Scenario: Visitor can see last 5 reported problems
    Given there are problems reported
    When I go to the home page
    Then I should see the last 5 problems
