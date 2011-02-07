require 'spec_helper'

describe Problem do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should belong_to(:municipality) }
    it { should have_many(:comments) }
    #it { should have_attached_file(:photo) }
    #it { should validate_attachment_presence(:photo) }
  end

  describe "validations" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:municipality_id) }

    it "is valid given valid attributes for unregistered user" do
      problem = Factory.build(:problem)
      problem.should be_valid
    end

    it "is valid given valid attributes for registered user" do
      problem = Factory.build(:problem, :user => Factory.create(:user))
      problem.should be_valid
    end

    it "does not validates photo is present when device_id is present" do
      problem = Factory.build(:problem, :photo => nil, :device_id => "123")
      problem.should be_valid
    end

    it "doesn't validate email is present for users reporting from mobile device" do
      problem = Factory.build(:problem, :email => nil, :device_id => "123456789")
      problem.should be_valid
      problem.errors[:email].should == []
    end

    it "doesn't validate email is present for registered user" do
      problem = Factory.build(:problem, :email => nil)
      problem.should be_valid
      problem.errors[:email].should == []
    end
  end

  describe "named scopes" do
    describe "with_photo" do
      it "includes problems with photo" do
        problem = Factory.create(:problem)
        Problem.with_photo.should include(problem)
      end

      it "excludes problems without photo" do
        problem = Factory.create(:problem, :photo => nil)
        Problem.with_photo.should_not include(problem)
      end
    end
  end
end
