Feature: Manage users
    In order to validate users information
    As a site administrator
    I want to manage users

    Scenario: Manage users
        Given I am authenticated as admin
            And I am on the admin page
        When I follow "Users"
        And I follow "New User"
            And I fill in "user_name" with "Test User 2"
            And I fill in "user_email" with "test_user2@popravi.mk"
            And I fill in "user_password" with "secretpass"
            And I fill in "user_password_confirmation" with "secretpass"
            And I press "Create"
        Then I should see "User was successfully created"
            And I should see "Test User 2"
        When I follow "Edit"
          And I fill in "user_name" with "Test User 3"
          And I press "Update"
        Then I should see "User was successfully updated"
            And I should see "Test User 3"
