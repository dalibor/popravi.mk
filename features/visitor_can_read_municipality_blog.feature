Feature: Visitor can read municipality blog post
  In order to be informed about what is happening in municipality
  As a visitor
  I want to be able to read municipality's blog posts

Scenario: Visitor can filter municipality's blog posts by month
  Given a region exists with name: "region1"
  And a municipality exists with name: "municipality1", region: the region
  And user exists with municipality: the municipality
  And now is "2010-01-01 12:00:00"
  And a post exists with title: "Hello world 1", user: the user
  And now is "2010-03-01 12:00:00"
  And a post exists with title: "Hello world 2", user: the user
  And I am on the home page
  And I follow "View all municipalities"
  And I follow "municipality1"
  And I follow "View all posts"
  Then I should see "Hello world 1"
  And I should see "Hello world 2"
  And I follow "March 2010"
  Then I should see "Hello world 2"
  And I should not see "Hello world 1"
  When I follow "View all posts"
  And I follow "January 2010"
  Then I should see "Hello world 1"
  And I should not see "Hello world 2"

Scenario: Visitor can see last post from municipality on their page
  Given a region exists with name: "region1"
  And a municipality exists with name: "municipality1", region: the region
  And user exists with municipality: the municipality
  And a post exists with title: "Hello world 1", content: "Post content", user: the user
  And I am on the home page
  And I follow "View all municipalities"
  And I follow "municipality1"
  Then I follow "Hello world 1"
  And I should see "Post content"

Scenario: Visitor can read municipality post
  Given a region exists with name: "region1"
  And a municipality exists with name: "municipality1", region: the region
  And user exists with municipality: the municipality
  And a post exists with title: "Hello world 1", user: the user
  And I am on the home page
  And I follow "View all municipalities"
  And I follow "municipality1"
  And I follow "View all posts"
  And I follow "Hello world 1"
  Then I should see "Hello world 1"
