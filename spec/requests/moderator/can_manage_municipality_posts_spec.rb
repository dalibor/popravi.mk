require 'spec_helper'

describe "Moderator" do
  let(:municipality) { create(:municipality, name: "municipality1") }
  let(:moderator) { create(:user, municipality: municipality, email: 'moderator@popravi.mk', name: 'The moderator') }

  before :each do
    problem = create :problem, municipality: municipality, description: "problem1"
    create :comment, commentable: problem, user: moderator
  end

  it "can manage posts" do
    login(moderator)
    click_link "Admin"
    click_link "Posts"
    click_link "New"
    check "Custom slug"
    fill_in "Slug", with: "my-custom-slug"
    fill_in "Title", with: "Hello world"
    fill_in "Content", with: "Post content"
    check "Publish"
    click_button "Save"
    page.should have_content "Post was successfully created"
    page.should have_content "The moderator"
    page.should have_content "Hello world"
    page.should have_content "my-custom-slug"
    click_link "Edit"
    fill_in "Content", with: "Post content 2"
    click_button "Save"
    page.should have_content "Post was successfully updated."
    page.should have_content "hello-world"
    page.should have_content "Hello world"
    page.should have_content "Post content 2"
    click_link "Delete"
    page.should have_content "Post was successfully destroyed."
    page.should_not have_content "Hello world"
  end

  it "can see only posts from their municipality" do
    moderator1 = create :user, municipality: municipality, email: "moderator1@popravi.mk", name: "The moderator1"
    create :post, title: "Municipality 1 post", user: moderator1

    municipality2 = create(:municipality, name: "municipality1")
    moderator2 = create :user, municipality: municipality2, email: "moderator2@popravi.mk", name: "The moderator2"
    create :post, title: "Municipality 2 post", user: moderator2

    login(moderator2)

    click_link "Admin"
    click_link "Posts"
    page.should have_content "Municipality 2 post"
    page.should_not have_content "Municipality 1 post"
  end
end
