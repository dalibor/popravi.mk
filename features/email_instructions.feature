Feature: Email instructions
  In order to correct issues with my account
  As a user
  I want to receive instructions via email
 
  Scenario: Resend email confirmation instructions and activate account
    Given I am not authenticated
    And I signed up as "test_user@popravi.mk" with password "secretpass"
    And I go to the resend confirmation instructions page
    When I fill in "user_email" with "test_user@popravi.mk"
    And I press "user_submit"
    Then I should see "упатство како да ја потврдите вашата сметка"
    And I should receive 2 emails
    When I open the email with subject "Упатство за потврда"
    Then I should see "Упатство за потврда" in the email subject
    When I follow "Потврди ја мојата сметка" in the email
    Then I should see "Најавени сте како test_user@popravi.mk"

  Scenario: Send password change instructions and change password
    Given I am not authenticated
    And I signed up as "test_user@popravi.mk" with password "secretpass"
    And I confirmed my email address
    And I go to the send password instructions page
    When I fill in "user_email" with "test_user@popravi.mk"
    And I press "user_submit"
    Then I should see "упатство како да ја ресетирате лозинката"
    And I should receive 2 emails
    When I open the email with subject "Упатство за ресетирање на лозинка"
    Then I should see "Упатство за ресетирање на лозинка" in the email subject
    When I follow "Промени ја мојата лозинка" in the email
    Then I should see "Променете ја вашата лозинка"
    When I fill in "user_password" with "newsecretpass"
    And I fill in "user_password_confirmation" with "newsecretpass"
    When I press "user_submit"
    Then I should see "Најавени сте како test_user@popravi.mk"

  #Scenario: Resend unlock account instructions
    #Given I am not authenticated
    #And I signed up as "johndoe3@example.com" with password "secretpass"
    #And I confirmed my email address
    #And my account is locked
    #And I go to the send unlock instructions page
    #When I fill in "user_email" with "johndoe3@example.com"
    #And I press "Resend"
    #Then I should see "instructions about how to unlock your account"
    #And an email should be sent to "johndoe3@example.com" with "Unlock my account" in the body
