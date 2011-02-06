Feature: Manage comments
  In order to modify comments of reported problems
  As a site administrator
  I want to manage comments

  Scenario: Manage comments
    Given I am authenticated as admin
    And I am on the admin page
    And a problem exists
    And a comment exists with commentable: the problem
    When I follow "Comments"
    And I follow "Edit"
    And I fill in "Content" with "Comment name 2"
    And I press "Save"
    Then I should see "Comment was successfully updated"
    And I should see "Comment name 2"
