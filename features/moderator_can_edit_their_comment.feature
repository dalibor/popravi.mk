Feature: Moderator can edit their comment
  In order to fix some wrong info
  As a moderator
  I want to be able to edit my comment

Scenario: Moderator can edit their comment
  Given a municipality exists with name: "municipality1"
  And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56"
  And a problem exists with municipality: the municipality, description: "problem1"
  And a comment exists with commentable: the problem, user: the user
  And I sign in as "moderator@popravi.mk" with "password"
  And I follow "Comments"
  Then I should see "My comment"
  And I follow "Edit"
  And I fill in "Content" with "My edited comment"
  And I press "Save"
  Then I should see "Comment was successfully updated."
  And I should see "My edited comment"
  And I follow "Edit"
  And I fill in "Content" with "My edited comment 2"
  And I press "Save"
  Then I should see "Comment was successfully updated."
  And I should see "My edited comment 2"
  When I follow "List"
  And I follow "Delete"
  Then I should see "Comment was successfully deleted."
  And I should not see "My edited comment 2"
