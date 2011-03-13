Feature: Visitor can comment a blog post
  In order give my opinion to a blog post
  As a visitor
  I want to be able to comment a blog post

  Scenario: Visitor can comment a blog post
    Given a user exists with is_admin: true
    And a post exists with title: "Hello world 1", user: the user
    And I am on the home page
    When I follow "Blog"
    And I follow "Hello world 1"
    And I fill in "comment_name" with "My Name"
    And I fill in "comment_email" with "test_user@popravi.mk"
    And I fill in "comment_content" with "My comment"
    When I press "comment_submit"
    Then I should see "My Name"
    And I should see "My comment"

  Scenario: Visitor can see errors when commenting blog post
    Given a user exists with is_admin: true
    And a post exists with title: "Hello world 1", user: the user
    And I am on the home page
    When I follow "Blog"
    And I follow "Hello world 1"
    When I press "comment_submit"
    Then I should see "Comment can't be blank"
    And I should not see "My comment"
    And page should not have ".comments img"
