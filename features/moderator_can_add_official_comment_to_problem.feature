Feature: Moderator can add official comment to a problem
  In order to infor people about their reported problems
  As a moderator
  I want to be able to add official comment to a problem

  Scenario: Moderator can add official comment to a problem
    Given a municipality exists with name: "municipality1"
    And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56"
    And a problem exists with municipality: the municipality, description: "problem1"
    And I sign in as "moderator@popravi.mk" with "password"
    And I go to the home page
    And I follow "problem1"
    And I fill in "comment_content" with "My official comment"
    When I press "comment_submit"
    Then I should see "My official comment" within ".official"
