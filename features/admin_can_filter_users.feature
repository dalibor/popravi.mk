Feature: Admin can filter users
  In order to see admins and moderators
  As a admin
  I want be able to filter users by role

  Scenario: Admin can filter users by role
    Given a municipality exists with name: "municipality"
    And a user exists with email: "moderator@popravi.mk", municipality: the municipality
    And a user exists with email: "reporter@popravi.mk"
    And I am authenticated as admin
    And I am on the admin page

    When I follow "Users"
    Then I should see "admin@popravi.mk"
    And I should see "moderator@popravi.mk"
    And I should see "reporter@popravi.mk"

    When I follow "Admins"
    Then I should see "admin@popravi.mk"
    And I should not see "moderator@popravi.mk"
    And I should not see "reporter@popravi.mk"

    When I follow "Moderators"
    Then I should not see "admin@popravi.mk"
    And I should see "moderator@popravi.mk"
    And I should not see "reporter@popravi.mk"

    When I follow "Reporters"
    Then I should not see "admin@popravi.mk"
    And I should not see "moderator@popravi.mk"
    And I should see "reporter@popravi.mk"
