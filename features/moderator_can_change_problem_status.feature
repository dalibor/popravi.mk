Feature: Moderator can change problem status
  In order to give feedback to citizens
  As a moderator
  I want to be able to change problem status

  Scenario: Moderator can change problem status
    Given a municipality exists with name: "municipality1"
    And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56"
    And a problem exists with municipality: the municipality, description: "problem1"
    And I sign in as "moderator@popravi.mk" with "password"
    And I follow "Admin"
    When I follow "Problems"
    And I follow "problem1"
    And I follow "Edit"
    And I select "solved" from "Status"
    And I press "Save"
    Then I should see "Problem was successfully updated."
    And I should see "problem1"
    And I should see "solved"
