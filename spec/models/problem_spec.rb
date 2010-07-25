require 'spec_helper'

describe Problem do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should belong_to(:municipality) }
    it { should have_attached_file(:photo) }
    it { should validate_attachment_presence(:photo) }
  end

  describe "validations" do
    it "is valid given valid attributes for unregistered user" do
      problem = Factory.build(:anonymous_problem)
      problem.should be_valid
    end

    it "is valid given valid attributes for registered user" do
      problem = Factory.build(:problem)
      problem.should be_valid
    end

    it "validates description is present" do
      problem = Factory.build(:problem, :description => nil)
      problem.should_not be_valid
      problem.errors.on(:description).should_not be_nil
    end

    it "validates photo is present when device_id is not present" do
      problem = Factory.build(:problem, :photo => nil)
      problem.should_not be_valid
      problem.errors.on(:photo_file_name).should_not be_nil
    end

    it "does not validates photo is present when device_id is present" do
      problem = Factory.build(:problem, :photo => nil, :device_id => "123")
      problem.should be_valid
    end

    it "validates longitude is present" do
      problem = Factory.build(:problem, :longitude => nil)
      problem.should_not be_valid
      problem.errors.on(:longitude).should_not be_nil
    end

    it "validates category is present" do
      problem = Factory.build(:problem, :category => nil)
      problem.should_not be_valid
      problem.errors.on(:category).should_not be_nil
    end

    it "validates municipality is present" do
      problem = Factory.build(:problem, :municipality => nil)
      problem.should_not be_valid
      problem.errors.on(:municipality).should_not be_nil
    end

    it "validates latitude is present" do
      problem = Factory.build(:problem, :latitude => nil)
      problem.should_not be_valid
      problem.errors.on(:latitude).should_not be_nil
    end

    it "validates email is present for unregistered user" do
      problem = Factory.build(:anonymous_problem, :email => nil)
      problem.should_not be_valid
      problem.errors.on(:email).should_not be_nil
    end

    it "doesn't validate email is present for users reporting from mobile device" do
      problem = Factory.build(:anonymous_problem, :email => nil, :device_id => "123456789")
      problem.should be_valid
      problem.errors.on(:email).should be_nil
    end

    it "doesn't validate email is present for registered user" do
      problem = Factory.build(:problem, :email => nil)
      problem.should be_valid
      problem.errors.on(:email).should be_nil
    end
  end
end
