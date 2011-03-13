Feature: Visitor can comment a municipality blog post
  In order give my opinion to a blog post
  As a visitor
  I want to be able to comment a blog post

  Scenario: Visitor can comment a municipality blog post
    Given a region exists with name: "region1"
    And a municipality exists with name: "municipality1", region: the region
    And user exists with municipality: the municipality
    And a post exists with title: "Hello world 1", user: the user
    And I am on the home page
    And I follow "View all municipalities"
    And I follow "municipality1"
    And I follow "View all posts"
    And I follow "Hello world 1"
    And I fill in "comment_name" with "My Name"
    And I fill in "comment_email" with "test_user@popravi.mk"
    And I fill in "comment_content" with "My comment"
    When I press "comment_submit"
    Then I should see "My Name"
    And I should see "My comment"

  Scenario: Visitor can see errors when commenting municipality blog post
    Given a region exists with name: "region1"
    And a municipality exists with name: "municipality1", region: the region
    And user exists with municipality: the municipality
    And a post exists with title: "Hello world 1", user: the user
    And I am on the home page
    And I follow "View all municipalities"
    And I follow "municipality1"
    And I follow "View all posts"
    And I follow "Hello world 1"
    When I press "comment_submit"
    Then I should see "Comment can't be blank"
    And I should not see "My comment"
    And page should not have ".comments img"
