require 'spec_helper'

describe Problem do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:last_editor) }
    it { should belong_to(:category) }
    it { should belong_to(:municipality) }
    it { should belong_to(:api_key) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:problem_transitions).dependent(:destroy) }
    it { should have_many(:rates).dependent(:destroy) }
    #it { should have_attached_file(:photo) }
  end

  describe "attributes" do
    it { should allow_mass_assignment_of(:category_id) }
    it { should allow_mass_assignment_of(:municipality_id) }
    it { should allow_mass_assignment_of(:description) }
    it { should allow_mass_assignment_of(:status) }
    it { should allow_mass_assignment_of(:longitude) }
    it { should allow_mass_assignment_of(:latitude) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:device_id) }
    it { should allow_mass_assignment_of(:photo) }
    it { should allow_mass_assignment_of(:weight) }
    it { should_not allow_mass_assignment_of(:official_notes) }
  end

  describe "validations" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:municipality_id) }
    it { should validate_numericality_of(:weight) }
    it { should ensure_inclusion_of(:weight).in_range(1..10) }
    #it { should validate_attachment_presence(:photo) }
    #
    
    it "allows status assignment for official statuses" do
      Problem::STATUSES.each do |status|
        problem = Factory.build(:problem, :status => status)
        problem.should be_valid
      end
    end

    it "does not allows invalid status assignment" do
      Problem::STATUSES.each do |status|
        problem = Factory.create(:problem)
        problem.status = 'invalid_status'
        problem.should_not be_valid
      end
    end

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

  describe "assign_user" do
    it "assigns user when user is nil" do
      user    = Factory.create(:user, :email => 'test_user@popravi.mk')
      problem = Factory.build(:problem, :email => 'test_user@popravi.mk', :user => nil)
      problem.save
      problem.user.should == user
    end

    it "does not assigns user when user is present" do
      user1   = Factory.create(:user, :email => 'test_user1@popravi.mk')
      user2   = Factory.create(:user, :email => 'test_user2@popravi.mk')
      problem = Factory.build(:problem, :email => 'test_user1@popravi.mk', :user => user2)
      problem.save
      problem.user.should == user2
    end
  end

  describe "current_rating" do
    it "returns 0.0 when no rates" do
      problem = Factory.create(:problem)

      problem.current_rating.should == ''
      problem.rates.count == 0
    end

    it "returns current_rating" do
      problem = Factory.create(:problem)
      Factory.create(:rate, :weight => 10, :problem => problem)
      Factory.create(:rate, :weight => 9, :problem => problem)

      problem.current_rating.should == 9.5
      problem.rates.count == 2
    end
  end

  describe "solved_at" do
    it "sets solved_at when status is changed to solved" do
      time1 = Time.parse("2010-01-01 12:00:00")
      Time.stub(:now).and_return(time1)
      problem = Factory.create(:problem)
      problem.solved_at.should be_nil
      problem.status = 'solved'
      problem.save!
      problem.solved_at.should == time1

      time2 = Time.parse("2010-02-01 12:00:00")
      Time.stub(:now).and_return(time2)
      problem.status = 'solved'
      problem.description = 'changed'
      problem.save!
      problem.solved_at.should == time1

      problem.status = 'approved'
      problem.save!
      problem.solved_at.should be_nil
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

