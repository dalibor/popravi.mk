require 'spec_helper'

describe "Visitor" do
  it "can filter blog posts by month" do
    admin = create :admin
    Timecop.freeze(Time.parse("2010-01-01 12:00:00 UTC")) do
      create :post, title: "Hello world 1", user: admin
    end
    Timecop.freeze(Time.parse("2010-03-01 12:00:00 UTC")) do
      create :post, title: "Hello world 2", user: admin
    end
    visit root_path
    click_link "Blog"
    click_link "Hello world 1"
    within ".main" do
      page.should have_content "Hello world 1"
    end
    within ".main" do
      page.should_not have_content "Hello world 2"
    end
    click_link "Blog"
    click_link "March 2010"
    within ".main" do
      page.should have_content "Hello world 2"
    end
    within ".main" do
      page.should_not have_content "Hello world 1"
    end
    click_link "Blog"
    click_link "January 2010"
    within ".main" do
      page.should have_content "Hello world 1"
    end
    within ".main" do
      page.should_not have_content "Hello world 2"
    end
  end

  it "can see last post from municipality on their page" do
    admin = create :admin
    create :post, title: "Hello world 1", content: "Post content", user: admin
    visit root_path
    page.should have_content "Hello world 1"
    page.should have_content "Post content"
  end

  it "can read a blog post" do
    admin = create :admin
    create :post, user: admin
    visit root_path
    click_link "Blog"
    click_link "Hello world 1"
    page.should have_content "Hello world 1"
  end
end
