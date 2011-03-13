Feature: User can comment a blog post
  In order give my opinion to a blog post
  As a user
  I want to be able to comment a blog post

  Scenario: User can comment a blog post
    Given I am an authenticated user
    And a user exists with is_admin: true
    And a post exists with title: "Hello world 1", user: the user
    And I am on the home page
    When I follow "Blog"
    And I follow "Hello world 1"
    Then page should not have "#comment_name"
    And page should not have "#comment_email"
    And I fill in "comment_content" with "My comment"
    When I press "comment_submit"
    Then I should see "You have successfully commented."
    And I should see "Authenticated User"
    And I should see "My comment"
    And page should have ".comments img"

  Scenario: User can see errors when commenting blog post
    Given I am an authenticated user
    And a user exists with is_admin: true
    And a post exists with title: "Hello world 1", user: the user
    And I am on the home page
    When I follow "Blog"
    And I follow "Hello world 1"
    Then page should not have "#comment_name"
    And page should not have "#comment_email"
    When I press "comment_submit"
    Then I should see "Comment can't be blank"
    And I should not see "My comment"
    And page should not have ".comments img"
