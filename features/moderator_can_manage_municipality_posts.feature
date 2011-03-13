Feature: Moderator can manage municipality posts
  In order to publish posts on municipality page
  As a moderator
  I want to be able to manage posts

  Scenario: Moderator can manage posts
    Given a municipality exists with name: "municipality1"
    And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56", name: "The moderator"
    And I sign in as "moderator@popravi.mk" with "password"
    When I follow "Posts"
    When I follow "New"
    And I check "Custom slug"
    And I fill in "Slug" with "my-custom-slug"
    And I fill in "Title" with "Hello world"
    And I fill in "Content" with "Post content"
    And I check "Publish"
    And I press "Save"
    Then I should see "Post was successfully created"
    And I should see "The moderator"
    And I should see "Hello world"
    And I should see "my-custom-slug"
    When I follow "Edit"
    And I fill in "Content" with "Post content 2"
    And I press "Save"
    Then I should see "Post was successfully updated."
    And I should see "hello-world"
    And I should see "Hello world"
    And I should see "Post content 2"
    When I follow "Delete"
    Then I should see "Post was successfully destroyed."
    And I should not see "Hello world"

  Scenario: Moderator can see only posts from their municipality
    Given a municipality "municipality1" exists with name: "municipality1"
    And a user "user1" exists with municipality: the municipality "municipality1", email: "moderator1@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56", name: "The moderator1"
    And a post exists with title: "Municipality 1 post", user: the user "user1"

    And a municipality "municipality2" exists with name: "municipality2"
    And a user "user2" exists with municipality: the municipality "municipality2", email: "moderator2@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56", name: "The moderator2"
    And a post exists with title: "Municipality 2 post", user: the user "user2"

    And I sign in as "moderator2@popravi.mk" with "password"

    When I follow "Posts"
    Then I should see "Municipality 2 post"
    And I should not see "Municipality 1 post"
