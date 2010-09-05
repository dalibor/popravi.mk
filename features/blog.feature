Feature: Blog
  In order to be informed about what is happening on the site
  As a user
  I want to be able to read blog posts

    Scenario: Read blog posts
        Given I am on the home page
        And posts exists
        And I follow "Блог"
        When I follow "Hello world 1"
        Then I should see "Hello world 1"
        And I should not see "Hello world 2"
        When I follow "Блог"
        And I follow "Март 2010"
        Then I should see "Hello world 2"
        And I should not see "Hello world 1"
        When I follow "Блог"
        And I follow "Јануари 2010"
        Then I should see "Hello world 1"
        And I should not see "Hello world 2"
