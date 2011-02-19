Feature: Visitor can see home page
  In order to see what is this app about
  As a visitor
  I want to be able to land on the home page

  Scenario: Visiting the site for the first time
    Given I am on the home page
    Then I should see "Подобри го својот град"
