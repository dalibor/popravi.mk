require 'spec_helper'

describe "Visitor" do
  let(:user) { create :user  }

  before :each do
    admin = create :admin
    create :post, title: "Hello world 1", user: admin
    visit root_path
  end

  it "can comment a blog post" do
    click_link "Blog"
    click_link "Hello world 1"
    fill_in "Name", with: "My Name"
    fill_in "Email", with: "test_user@popravi.mk"
    fill_in "Comment", with: "My comment"
    click_button "Send"
    page.should have_content "My Name"
    page.should have_content "My comment"
  end

  it "can see errors when commenting blog post" do
    click_link "Blog"
    click_link "Hello world 1"
    click_button "Send"
    page.should have_content "Comment can't be blank"
    page.should_not have_content "My comment"
    page.should_not have_css ".comments img"
  end
end
