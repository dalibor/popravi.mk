require 'spec_helper'

describe "Visitor" do
  let(:region) { create :region, name: "region1" }
  let(:municipality) { create :municipality, name: "municipality1", region: region }
  let(:user) { create :user, municipality: municipality }

  it "can filter municipality's blog posts by month" do
    Timecop.freeze(Time.parse("2010-01-01 12:00:00 UTC")) do
      create :post, title: "Hello world 1", user: user
    end
    Timecop.freeze(Time.parse("2010-03-01 12:00:00 UTC")) do
      create :post, title: "Hello world 2", user: user
    end
    visit root_path
    click_link "View all municipalities"
    click_link "municipality1"
    click_link "View all posts"
    page.should have_content "Hello world 1"
    page.should have_content "Hello world 2"
    click_link "March 2010"
    page.should have_content "Hello world 2"
    page.should_not have_content "Hello world 1"
    click_link "View all posts"
    click_link "January 2010"
    page.should have_content "Hello world 1"
    page.should_not have_content "Hello world 2"
  end

  it "can see last post from municipality on their page" do
    create :post, title: "Hello world 1", content: "Post content", user: user
    visit root_path
    click_link "View all municipalities"
    click_link "municipality1"
    click_link "Hello world 1"
    page.should have_content "Post content"
  end

  it "can read municipality post" do
    create :post, title: "Hello world 1", user: user
    visit root_path
    click_link "View all municipalities"
    click_link "municipality1"
    click_link "View all posts"
    click_link "Hello world 1"
    page.should have_content "Hello world 1"
  end
end
