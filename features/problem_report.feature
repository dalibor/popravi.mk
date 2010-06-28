Feature: Report a problem
  In order to get street problems near me fixed
  As a user
  I want to be able to report a problem

    Scenario: Reporting a problem when user is not logged in
        Given I am on the home page
        And category exists
        And municipality exists
        When I follow "Report a problem"
        And I fill in "Subject" with "Problem subject"
        And I fill in "Description" with "Problem description"
        And I change the value of the hidden field "problem[latitude]" to "42"
        And I change the value of the hidden field "problem[longitude]" to "21"
        And I fill in "Name" with "Test User"
        And I fill in "Email" with "test_user@popravi.mk"
        And I select "Abandoned vehicles" from "Category"
        And I select "Butel" from "Municipality"
        And I press "Report problem"
        Then I should see "Problem was successfully reported"
        And I should not see "Edit problem report"
        
    Scenario: Reporting and editing a problem when user is logged in
        Given I am an authenticated user
        And I am on the home page
        And category exists
        And municipality exists
        When I follow "Report a problem"
        Then I should not see "Name"
        Then I should not see "Email"
        When I fill in "Subject" with "Problem subject"
        And I fill in "Description" with "Problem description"
        And I change the value of the hidden field "problem[latitude]" to "42"
        And I change the value of the hidden field "problem[longitude]" to "21"
        And I select "Abandoned vehicles" from "Category"
        And I select "Butel" from "Municipality"
        And I press "Report problem"
        Then I should see "Problem was successfully reported"
        And I should see "Problem subject"
        And I should see "Edit problem report"
        When I follow "Edit problem report"
        And I fill in "Subject" with "Problem subject 2"
        And I press "Update problem report"
        Then I should see "Problem report was successfully updated"
        And I should see "Problem subject 2"
