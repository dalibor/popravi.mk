Feature: Moderator can manage problems
  In order to update site visitors with problem statuses
  As a moderator
  I want to be able to manage problems

  Scenario: Moderator can see only problem in their municipality
    Given a municipality exists with name: "municipality1"
    And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56"
    And a problem exists with municipality: the municipality, description: "problem1"
    And a municipality exists with name: "municipality2"
    And a user exists with municipality: the municipality
    And a problem exists with municipality: the municipality, description: "problem2"
    And I sign in as "moderator@popravi.mk" with "password"
    Then I should see "Welcome municipality moderator!"
    When I follow "Problems"
    Then I should see "problem1"
    And I should not see "problem2"
    And column "5" row "2" should have text "reported"
    When I follow "problem1"
    Then I should see "problem1"

  Scenario: Moderator can solve a problem
    Given a municipality exists with name: "municipality1"
    And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56"
    And a problem exists with municipality: the municipality, description: "problem1"
    And I sign in as "moderator@popravi.mk" with "password"
    Then I should see "Welcome municipality moderator!"
    When I follow "Problems"
    Then I should see "problem1"
    When I follow "Approve"
    Then I should see "Problem was successfully approved"
    And column "5" row "2" should have text "approved"
    When I follow "Activate"
    Then I should see "Problem was successfully activated"
    And column "5" row "2" should have text "activated"
    When I follow "Solve"
    Then I should see "Problem was successfully solved"
    And column "5" row "2" should have text "solved"

  Scenario: Moderator can mark problem as spam
    Given a municipality exists with name: "municipality1"
    And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56"
    And a problem exists with municipality: the municipality, description: "problem1"
    And I sign in as "moderator@popravi.mk" with "password"
    Then I should see "Welcome municipality moderator!"
    When I follow "Problems"
    Then I should see "problem1"
    When I follow "Invalidate"
    Then I should see "Problem was successfully invalidated."
    And column "5" row "2" should have text "invalid"
