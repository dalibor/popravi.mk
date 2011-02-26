require 'spec_helper'

describe Problem do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should belong_to(:municipality) }
    it { should have_many(:comments) }
    it { should have_many(:problem_transitions) }
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

  describe "years" do
    it "returns empty array when there are no problems" do
      Problem.years.should be_empty
    end

    it "returns proper year when there is one problem" do
      problem = Factory.create(:problem, :created_at => Date.parse("2010-10-01"))
      Problem.years.should == [2010]
    end

    it "returns proper years sorted when there are few problems" do
      problem = Factory.create(:problem, :created_at => Date.parse("2010-10-01"))
      problem = Factory.create(:problem, :created_at => Date.parse("2010-10-01"))
      problem = Factory.create(:problem, :created_at => Date.parse("2011-10-01"))
      Problem.years.should == [2010, 2011]
    end
  end
end


# == Schema Information
#
# Table name: problems
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)
#  category_id        :integer(4)
#  municipality_id    :integer(4)
#  description        :text
#  status             :string(255)     default("0")
#  longitude          :string(255)
#  latitude           :string(255)
#  email              :string(255)
#  device_id          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer(4)
#  photo_updated_at   :datetime
#  weight             :integer(4)      default(5)
#  sent_at            :datetime
#

