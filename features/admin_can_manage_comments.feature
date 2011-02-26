Feature: Admin can manage comments
  In order to modify comments of reported problems
  As a site administrator
  I want to be able to manage comments

  Scenario: Admin can manage comments
    Given I am authenticated as admin
    And a problem exists
    And a comment exists with commentable: the problem
    When I follow "Comments"
    And I follow "Edit"
    And I fill in "Content" with "Comment name 2"
    And I press "Save"
    Then I should see "Comment was successfully updated"
    And I should see "Comment name 2"
