Feature: Manage comments
    In order to modify comments of reported problems
    As a site administrator
    I want to manage comments

    Scenario: Manage comments
        Given I am authenticated as admin
            And I am on the admin page
            And There are no comments
            And There are problems reported
        When I follow "Comments"
        Then I should see "No comments have been added yet"
        When I follow "New Comment"
            And I fill in "Name" with "Comment name"
            And I fill in "Content" with "My comment"
            And I select "Проблем со Category 1 во општина Municipality 1" from "comment_problem_id"
            And I press "Create"
        Then I should see "Comment was successfully created"
            And I should see "Comment name"
            And I should see "My comment"
            And I should see "Проблем со Category 1 во општина Municipality 1"
        When I follow "Edit"
          And I fill in "Name" with "Comment name 2"
          And I press "Update"
        Then I should see "Comment was successfully updated"
            And I should see "Comment name 2"
