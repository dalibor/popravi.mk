Feature: Admin can see problem status transitions
  In order to see status changes of a problem
  As a admin
  I want to be able to see transition history

  Scenario: Admin can see problem status transitions
    Given a municipality exists with name: "municipality1"
    And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56", name: "Moderator1"
    And a problem exists with municipality: the municipality, description: "problem1"
    And I sign in as "moderator@popravi.mk" with "password"
    And I follow "Admin"
    When I follow "Problems"
    And I follow "Edit"
    And I select "approved" from "Status"
    And I press "Save"
    And I follow "Edit"
    And I select "activated" from "Status"
    And I press "Save"
    And I follow "Edit"
    And I select "solved" from "Status"
    And I press "Save"
    And I follow "Logout"

    When I am authenticated as admin
    And I follow "Admin"
    And I follow "Problems"
    And I follow "Show"
    Then I should see "Problem status transitions"
    And I should see following problem status transitions:
       | no | from      | to        | user       | 
       | 1  |           | reported  | Test User  |
       | 2  | reported  | approved  | Moderator1 | 
       | 3  | approved  | activated | Moderator1 | 
       | 4  | activated | solved    | Moderator1 | 
