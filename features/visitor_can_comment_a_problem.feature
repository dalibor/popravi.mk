Feature: Visitor can comment a problem
  In order give my opinion to a problem
  As a visitor
  I want to be able to comment a problem

  Scenario: Visitor can comment a problem
    Given a user exists
    And a municipality exists with name: "Municipality 1"
    And a problem exists with user: the user, municipality: the municipality
    And I am on the home page
    When I follow "Municipality 1" within ".main"
    And I fill in "comment_name" with "My Name"
    And I fill in "comment_email" with "test_user@popravi.mk"
    And I fill in "comment_content" with "My comment"
    When I press "comment_submit"
    Then I should see "My Name"
    And I should see "My comment"
