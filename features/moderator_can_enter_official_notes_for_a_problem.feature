Feature: Moderator can enter official notes for a problem
  In order to show details about problem resolution
  As a moderator
  I want to be able to enter official info to problems

Scenario: Moderator can enter official info to a problem
  Given a municipality exists with name: "municipality1"
  And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56"
  And a problem exists with municipality: the municipality, description: "problem1"
  And I sign in as "moderator@popravi.mk" with "password"
  When I follow "Problems"
  And I follow "problem1"
  And I follow "Edit"
  And I fill in "Official notes" with "My official notes"
  And I press "Save"
  Then I should see "Problem was successfully updated."
  And I should see "problem1"
  And I should see "My official notes"
  When I follow "Edit"
  And I fill in "Official notes" with "My official notes 2"
  And I press "Save"
  Then I should see "My official notes 2"
