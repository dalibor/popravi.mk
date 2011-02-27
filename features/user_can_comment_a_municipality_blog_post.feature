Feature: User can comment a municipality blog post
  In order give my opinion to a blog post
  As a user
  I want to be able to comment a blog post

Scenario: User can comment a municipality blog post
  Given I am an authenticated user
  And a region exists with name: "region1"
  And a municipality exists with name: "municipality1", region: the region
  And user exists with municipality: the municipality
  And a post exists with title: "Hello world 1", user: the user
  And I am on the home page
  And I follow "View all municipalities"
  And I follow "municipality1"
  And I follow "View all posts"
  And I follow "Hello world 1"
  Then page should not have "#comment_name"
  And page should not have "#comment_email"
  And I fill in "comment_content" with "My comment"
  When I press "comment_submit"
  Then I should see "You have successfully commented."
  And I should see "Authenticated User"
  And I should see "My comment"
  And page should have ".comments img"

Scenario: User can see errors when commenting a municipality blog post
  Given I am an authenticated user
  And a region exists with name: "region1"
  And a municipality exists with name: "municipality1", region: the region
  And user exists with municipality: the municipality
  And a post exists with title: "Hello world 1", user: the user
  And I am on the home page
  And I follow "View all municipalities"
  And I follow "municipality1"
  And I follow "View all posts"
  And I follow "Hello world 1"
  Then page should not have "#comment_name"
  And page should not have "#comment_email"
  When I press "comment_submit"
  Then I should see "Comment can't be blank"
  And I should not see "My comment"
  And page should not have ".comments img"
