# Feature: Visitor can read municipality blog post
#   In order to be informed about what is happening in municipality
#   As a visitor
#   I want to be able to read municipality's blog posts

#   Scenario: Visitor can filter municipality's blog posts by month
#     Given a region exists with name: "region1"
#     And a municipality exists with name: "municipality1", region: the region
#     And user exists with municipality: the municipality
#     And now is "2010-01-01 12:00:00"
#     And a post exists with title: "Hello world 1", user: the user
#     And now is "2010-03-01 12:00:00"
#     And a post exists with title: "Hello world 2", user: the user
#     And I am on the home page
#     click_link "View all municipalities"
#     click_link "municipality1"
#     click_link "View all posts"
#     page.should have_content "Hello world 1"
#     page.should have_content "Hello world 2"
#     click_link "March 2010"
#     page.should have_content "Hello world 2"
#     page.should_not have_content "Hello world 1"
#     click_link "View all posts"
#     click_link "January 2010"
#     page.should have_content "Hello world 1"
#     page.should_not have_content "Hello world 2"

#   Scenario: Visitor can see last post from municipality on their page
#     Given a region exists with name: "region1"
#     And a municipality exists with name: "municipality1", region: the region
#     And user exists with municipality: the municipality
#     And a post exists with title: "Hello world 1", content: "Post content", user: the user
#     And I am on the home page
#     click_link "View all municipalities"
#     click_link "municipality1"
#     Then I follow "Hello world 1"
#     page.should have_content "Post content"

#   Scenario: Visitor can read municipality post
#     Given a region exists with name: "region1"
#     And a municipality exists with name: "municipality1", region: the region
#     And user exists with municipality: the municipality
#     And a post exists with title: "Hello world 1", user: the user
#     And I am on the home page
#     click_link "View all municipalities"
#     click_link "municipality1"
#     click_link "View all posts"
#     click_link "Hello world 1"
#     page.should have_content "Hello world 1"
