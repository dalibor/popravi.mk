require 'spec_helper'

describe "Visitor" do
  it "can sign up" do
    email = "test_user@popravi.mk"
    visit root_path
    click_link "Sign up"
    fill_in "Email", with: email
    fill_in "Password", with: "secretpass"
    fill_in "Password confirmation", with: "secretpass"
    click_button "Register"
    page.should have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    unread_emails_for(email).size.should == parse_email_count(1)
    open_email(email)
    current_email.subject.should have_content("Confirmation instructions")
    visit_in_email "Confirm my account"
    page.should have_content "Your account was successfully confirmed. You are now signed in."
  end
end
