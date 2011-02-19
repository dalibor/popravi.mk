Feature: User can comment a blog post
  In order give my opinion to a blog post
  As a user
  I want to be able to comment a blog post

  Scenario: User can comment a blog post
    Given I am an authenticated user
    And a post exists
    And I am on the home page
    When I follow "Blog"
    And I follow "Hello world 1"
    Then page should not have "#comment_name"
    And page should not have "#comment_email"
    And I fill in "comment_content" with "My comment"
    When I press "comment_submit"
    Then I should see "Authenticated User"
    And I should see "My comment"
    And page should have ".comments img"
