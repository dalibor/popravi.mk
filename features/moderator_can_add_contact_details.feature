Feature: Moderator can edit contact details
  In order to present my municipality
  As a moderator
  I want to be able to edit contact details

  Scenario: Moderator can edit contact details
    Given a municipality exists with name: "municipality1"
    And a user exists with municipality: the municipality, email: "moderator@popravi.mk", password: "password", confirmed_at: "2010-07-25 14:05:56"
    And I sign in as "moderator@popravi.mk" with "password"
    And I follow "Admin"
    And I follow "Contact"
    And I fill in "About" with "About muniicpality1"
    And I fill in "Address" with "My address"
    And I fill in "Phone" with "My phone"
    And I fill in "Web" with "My web"
    And I fill in "E-mail" with "municipality@popravi.mk"
    And I press "Save"
    Then I should see "Contact details were successfully saved."
    And the "About" field should contain "About muniicpality1"
    When I fill in "About" with "About muniicpality2"
    And I press "Save"
    Then I should see "Contact details were successfully saved."
    And the "About" field should contain "About muniicpality2"
