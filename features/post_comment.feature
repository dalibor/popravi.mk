Feature: Post a comment
  In order give my opinion to problems and blog posts
  As a user
  I want to be able to comment a problem and posts

    Scenario: Commenting problem when user is not logged in
        Given There are problems reported
        And I am on the home page
        When I follow "Municipality 1" within ".main"
        And I fill in "comment_name" with "My Name"
        And I fill in "comment_email" with "test_user@popravi.mk"
        And I fill in "comment_content" with "My comment"
        When I press "comment_submit"
        Then I should see "My Name"
        And I should see "My comment"

    Scenario: Commenting problem when user is logged in
        Given There are problems reported 
        And I am an authenticated user
        And I am on the home page
        When I follow "Municipality 1" within ".main"
        Then page should not have "#comment_name"
        And page should not have "#comment_email"
        And I fill in "comment_content" with "My comment"
        When I press "comment_submit"
        Then I should see "Authenticated User"
        And I should see "My comment"
        And page should have ".comments img"

    Scenario: Commenting post when user is not logged in
        Given posts exists
        And I am on the home page
        When I follow "Блог"
        And I follow "Hello world 1"
        And I fill in "comment_name" with "My Name"
        And I fill in "comment_email" with "test_user@popravi.mk"
        And I fill in "comment_content" with "My comment"
        When I press "comment_submit"
        Then I should see "My Name"
        And I should see "My comment"

    Scenario: Commenting problem when user is logged in
        Given I am an authenticated user
        And posts exists
        And I am on the home page
        When I follow "Блог"
        And I follow "Hello world 1"
        Then page should not have "#comment_name"
        And page should not have "#comment_email"
        And I fill in "comment_content" with "My comment"
        When I press "comment_submit"
        Then I should see "Authenticated User"
        And I should see "My comment"
        And page should have ".comments img"
