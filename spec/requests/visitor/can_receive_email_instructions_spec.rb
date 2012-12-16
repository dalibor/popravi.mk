require 'spec_helper'

describe "Visitor" do
  it "can resend email confirmation instructions and activate account" do
    user = create :user, email: "test_user@popravi.mk", password: "password", confirmed_at: nil
    visit('/users/sign_out')
    click_link "Sign in"
    click_link "I didn't received confirmation instructions on email?"
    fill_in "Email", with: user.email
    click_button "Send confirmation"
    page.should have_content "You will receive an email with instructions about how to confirm your account in a few minutes."
    unread_emails_for(user.email).size.should == parse_email_count(2)
    open_email(user.email, :with_subject => "Confirmation instructions")
    visit_in_email "Confirm my account"
    page.should have_content "Your account was successfully confirmed. You are now signed in."
  end

  it "can send password change instructions and change password" do
    user = create :user, email: "test_user@popravi.mk"
    visit('/users/sign_out')
    click_link "Sign in"
    click_link "I forgot my password"
    fill_in "user_email", with: "test_user@popravi.mk"
    click_button "Reset password"
    page.should have_content "You will receive an email with instructions about how to reset your password in a few minutes."
    unread_emails_for(user.email).size.should == parse_email_count(1)
    open_email(user.email, :with_subject => "Reset password instructions")
    current_email.subject.should have_content "Reset password instructions"
    visit_in_email "Change my password"
    page.should have_content "Change your password"
    fill_in "Password", with: "newsecretpass"
    fill_in "Password confirmation", with: "newsecretpass"
    click_button "Change my password"
    page.should have_content "Your password was changed successfully. You are now signed in."
  end
end
