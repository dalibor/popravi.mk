require 'spec_helper'

describe "Visitor" do
  it "can sign in" do
    user = create :user
    visit root_path
    click_link 'Sign in'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"
    page.should have_content "Signed in successfully."
  end

  it "can display invalid login credentials" do
    user = create :user, email: "test_user@popravi.mk", password: "password"
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: "test_user@popravi.mk"
    fill_in "Password", with: "wrongpass"
    click_button "Login"
    page.should have_content "Invalid email or password"
    current_path.should == user_session_path
  end

  it "can ask for confirmation" do
    user = create :user, email: "test_user@popravi.mk", password: "password", confirmed_at: nil
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: "test_user@popravi.mk"
    fill_in "Password", with: "password"
    click_button "Login"
    page.should have_content "You have to confirm your account before continuing."
    current_path.should == user_session_path
  end
end
