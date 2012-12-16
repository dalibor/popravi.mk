require 'spec_helper'

describe Post do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user_id) }

    it "is valid given valid attributes" do
      post = build(:post)
      post.should be_valid
    end
  end

  describe "slug" do
    it "sets slug when no custom slug is used" do
      post = create(:post, :title => "New title")
      post.slug.should == "new-title"
    end

    it "does not set slug when custom slug is used" do
      post = create(:post, :custom_slug => "1", :slug => "my-custom-slug")
      post.slug.should == "my-custom-slug"
    end
  end

  describe "published" do
    it "does not set published_at when published is not checked" do
      post = create(:post, :published => "0")
      post.published_at.should be_nil
    end

    it "does sets published_at when published is checked" do
      post = create(:post, :published => "1")
      post.published_at.should_not be_nil
    end

    it "removes published_at when post is unpublished" do
      post = create(:post, :published => "1")
      post.published = "0"
      post.save
      post.published_at.should be_nil
    end
  end

  describe "archive items" do
    it "finds archive items" do
      Time.stub(:now).and_return(Time.parse("2010-01-01 12:00:00"))
      create(:post, :user => create(:user), :published => true,
                     :title => "Hello world 1")
      Time.stub(:now).and_return(Time.parse("2010-03-01 12:00:00"))
      create(:post, :user => create(:user), :published => true,
                     :title => "Hello world 2")
      Post.archive_items.should == [[2010, 1], [2010, 3]]
    end
  end

  describe "named scopes" do
    describe "published" do
      it "includes published posts" do
        post = create(:post)
        Post.published.should include(post)
      end

      it "excludes problmes without photo" do
        post = create(:post, :published => false)
        Post.published.should_not include(post)
      end
    end

    describe "for month" do
      it "filters posts for months" do
        Time.stub(:now).and_return(Time.parse("2010-01-01 12:00:00"))
        post1 = create(:post, :user => create(:user),
                               :published => true, :title => "Hello world 1")
        Time.stub(:now).and_return(Time.parse("2010-03-01 12:00:00"))
        post2 = create(:post, :user => create(:user),
                               :published => true, :title => "Hello world 2")

        Post.for_month(2010, 1).should include(post1)
        Post.for_month(2010, 1).should_not include(post2)
        Post.for_month(2010, 3).should include(post2)
        Post.for_month(2010, 3).should_not include(post1)
      end
    end
  end

  describe "set_published_at" do
    it "does not reset published_at timestamp" do
      Time.stub(:now).and_return(Time.parse("2010-01-01 12:00:00"))
      post = create(:post, :user => create(:user),
                             :published => true, :title => "Hello world 1")
      post.published_at.year.should == 2010

      Time.stub(:now).and_return(Time.parse("2011-01-01 12:00:00"))
      post.title = 'Hello world 2'
      post.save!
      post.published_at.year.should == 2010
    end
  end
end
