Feature: Blog
  In order to be informed about what is happening on the site
  As a visitor
  I want to be able to read blog posts

  @run
  Scenario: Read blog posts
    Given now is "2010-01-01 12:00:00"
    And a post exists with title: "Hello world 1"
    And now is "2010-03-01 12:00:00"
    And a post exists with title: "Hello world 2"
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
