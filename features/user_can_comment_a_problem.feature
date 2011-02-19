Feature: User can comment a problem
  In order give my opinion to a problem
  As a user
  I want to be able to comment a problem

  Scenario: User can comment a problem
    Given a user exists
    Given a municipality exists with name: "Municipality 1"
    And a problem exists with user: the user, municipality: the municipality
    And I am an authenticated user
    And I am on the home page
    When I follow "Municipality 1" within ".main"
    Then page should not have "#comment_name"
    And page should not have "#comment_email"
    And I fill in "comment_content" with "My comment"
    When I press "comment_submit"
    Then I should see "Authenticated User"
    And I should see "My comment"
    And page should have ".comments img"
