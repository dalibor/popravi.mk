Feature: Admin can see problem status transitions
  In order to see status changes of a problem
  As a admin
  I want to be able to see transition history

  Scenario: Admin can see problem status transitions
    Given a municipality exists with name: "municipality1"
    And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56"
    And a problem exists with municipality: the municipality, description: "problem1"
    And I sign in as "moderator@popravi.mk" with "password"
    When I follow "Problems"
    And I follow "Approve"
    And I follow "Activate"
    And I follow "Solve"
    And I follow "Logout"

    When I am authenticated as admin
    And I follow "Problems"
    And I follow "Show"
    Then I should see "Problem status transitions"
    And I should see following problem status transitions:
      | no | from      | to        |
      | 1  |           | reported  |
      | 2  | reported  | approved  |
      | 3  | approved  | activated |
      | 4  | activated | solved    |
