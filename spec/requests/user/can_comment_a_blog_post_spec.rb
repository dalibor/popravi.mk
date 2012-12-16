require 'spec_helper'

describe "User" do
  let(:user) { create :user, name: "Authenticated User" }

  before :each do
    login(user)
    admin = create :admin
    create :post, user: admin
    visit root_path
  end

  it "can comment a blog post" do
    click_link "Blog"
    click_link "Hello world 1"
    page.should_not have_css "#comment_name"
    page.should_not have_css "#comment_email"
    fill_in "comment_content", with: "My comment"
    click_button "Send"
    page.should have_content "You have successfully commented."
    page.should have_content "Authenticated User"
    page.should have_content "My comment"
    page.should have_css ".comments img"
  end

  it "can see errors when commenting blog post" do
    click_link "Blog"
    click_link "Hello world 1"
    page.should_not have_css "#comment_name"
    page.should_not have_css "#comment_email"
    click_button "Send"
    page.should have_content "Comment can't be blank"
    page.should_not have_content "My comment"
    page.should_not have_css ".comments img"
  end
end
