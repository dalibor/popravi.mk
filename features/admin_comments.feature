Feature: Manage comments
    In order to modify comments of reported problems
    As a site administrator
    I want to manage comments

    Scenario: Manage comments
        Given I am authenticated as admin
            And I am on the admin page
            And There are comments
        When I follow "Comments"
        And I follow "Edit"
          And I fill in "Name" with "Comment name 2"
          And I press "Update"
        Then I should see "Comment was successfully updated"
            And I should see "Comment name 2"
