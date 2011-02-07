require 'spec_helper'

describe Comment do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
  end

  describe "attributes" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:content) }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:commentable_id) }
    it { should validate_presence_of(:commentable_type) }

    it "is valid given valid attributes for unregistered user" do
      comment = Factory.build(:comment)
      comment.should be_valid
    end

    it "is valid given valid attributes for registered user" do
      comment = Factory.build(:comment, :user => Factory.create(:user))
      comment.should be_valid
    end

    it "validates email is valid" do
      comment = Factory.build(:comment, :email => "invalid_email")
      comment.should_not be_valid
      comment.errors[:email].should_not be_nil
    end
  end

  describe "commenter_name" do
    describe "logged in user" do
      it "displays name of the logged in user if name present" do
        user = Factory.create(:user, :name => "Test User")
        problem = Factory.create(:problem)
        comment = problem.comments.new(:content => "My comment")
        comment.user = user
        comment.commenter_name.should == "Test User"
      end

      it "displays 'Анонимен корисник'" do
        user = Factory.create(:user, :name => '')
        problem = Factory.create(:problem)
        comment = problem.comments.new(:content => "My comment")
        comment.user = user
        comment.commenter_name.should == "Анонимен корисник"
      end
    end

    describe "anonymous user" do
      it "displays name in the comment if name present" do
        problem = Factory.create(:problem)
        comment = problem.comments.new(:name => "My Name", :content => "My comment")
        comment.commenter_name.should == "My Name"
      end

      it "displays 'Анонимен корисник'" do
        problem = Factory.create(:problem)
        comment = problem.comments.new(:content => "My comment")
        comment.commenter_name.should == "Анонимен посетител"
      end
    end
  end

  describe "commenter_avatar" do
    describe "logged in user" do
      it "displays avatar of user" do
        user = Factory.create(:user, :avatar => File.open(File.join(Rails.root, 'public', 'images', 'rails.png')))
        problem = Factory.create(:problem)
        comment = problem.comments.new(:content => "My comment")
        comment.user = user
        comment.commenter_avatar.should match /rails\.png/
      end
    end

    describe "anonymous user" do
      it "displays gratar of user" do
        problem = Factory.create(:problem)
        comment = problem.comments.new(:content => "My comment")
        comment.commenter_avatar.should match /anonymous/
      end
    end
  end
end
