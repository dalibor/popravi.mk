require 'spec_helper'

describe "User" do

  before :each do
    visit root_path
    region = create :region, name: "region1"
    municipality = create :municipality, name: "municipality1", region: region
    user = create :user, municipality: municipality, name: "Authenticated User"
    create :post, user: user
    create :post, title: "Hello world 1", user: user
    login(user)
    visit root_path
    click_link "View all municipalities"
    click_link "municipality1"
    click_link "View all posts"
    click_link "Hello world 1"
  end

  it "can comment a municipality blog post" do
    page.should_not have_content "#comment_name"
    page.should_not have_content "#comment_email"
    fill_in "comment_content", with: "My comment"
    click_button "Send"
    page.should have_content "You have successfully commented."
    page.should have_content "Authenticated User"
    page.should have_content "My comment"
    page.should have_css ".comments img"
  end

  it "can see errors when commenting a municipality blog post" do
    page.should_not have_content "#comment_name"
    page.should_not have_content "#comment_email"
    click_button "Send"
    page.should have_content "Comment can't be blank"
    page.should_not have_content "My comment"
    page.should_not have_content ".comments img"
  end
end
