Feature: Visitor can read blog posts
  In order to be informed about what is happening on the site
  As a visitor
  I want to be able to read blog posts

Scenario: Visitor can filter blog posts by month
  Given a user exists with is_admin: true
  And now is "2010-01-01 12:00:00"
  And a post exists with title: "Hello world 1", user: the user
  And now is "2010-03-01 12:00:00"
  And a post exists with title: "Hello world 2", user: the user
  And I am on the home page
  And I follow "Blog"
  When I follow "Hello world 1"
  Then I should see "Hello world 1"
  And I should not see "Hello world 2"
  When I follow "Blog"
  And I follow "March 2010"
  Then I should see "Hello world 2"
  And I should not see "Hello world 1"
  When I follow "Blog"
  And I follow "January 2010"
  Then I should see "Hello world 1"
  And I should not see "Hello world 2"

Scenario: Visitor can see last post from municipality on their page
  Given a user exists with is_admin: true
  And a post exists with title: "Hello world 1", content: "Post content", user: the user
  And I am on the home page
  Then I should see "Hello world 1"
  And I should see "Post content"

Scenario: Visitor can read a blog post
  Given a user exists with is_admin: true
  And a post exists with user: the user
  And I am on the home page
  When I follow "Blog"
  And I follow "Hello world 1"
  Then I should see "Hello world 1"
