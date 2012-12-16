# require 'spec_helper'

# describe "Visitor" do
#   it "can filter blog posts by month" do
#     Given a user exists with is_admin: true
#     And now is "2010-01-01 12:00:00"
#     And a post exists with title: "Hello world 1", user: the user
#     And now is "2010-03-01 12:00:00"
#     And a post exists with title: "Hello world 2", user: the user
#     And I am on the home page
#     click_link "Blog"
#     click_link "Hello world 1"
#     page.should have_content "Hello world 1" within ".main"
#     page.should_not have_content "Hello world 2" within ".main"
#     click_link "Blog"
#     click_link "March 2010"
#     page.should have_content "Hello world 2" within ".main"
#     page.should_not have_content "Hello world 1" within ".main"
#     click_link "Blog"
#     click_link "January 2010"
#     page.should have_content "Hello world 1" within ".main"
#     page.should_not have_content "Hello world 2" within ".main"
#   end

#   it "can see last post from municipality on their page" do
#     Given a user exists with is_admin: true
#     And a post exists with title: "Hello world 1", content: "Post content", user: the user
#     And I am on the home page
#     page.should have_content "Hello world 1"
#     page.should have_content "Post content"
#   end

#   it "can read a blog post" do
#     Given a user exists with is_admin: true
#     And a post exists with user: the user
#     And I am on the home page
#     click_link "Blog"
#     click_link "Hello world 1"
#     page.should have_content "Hello world 1"
#   end
# end
