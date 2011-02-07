require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many(:problems) }
    it { should have_many(:comments) }
    it { should have_many(:posts) }
  end

  describe "attributes" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
    it { should allow_mass_assignment_of(:avatar) }
  end

  describe "instance methods" do
    it "is admin" do
      user = Factory.create(:user, :role => "admin")
      user.is_admin?.should == true
    end

    it "is not admin" do
      user = Factory.create(:user, :role => "moderator")
      user.is_admin?.should == false
    end

    it "does not have potentially reported problems" do
      user = Factory.create(:user)
      user.has_potentially_reported_problems?.should == false
    end

    it "has potentially reported problems" do
      Factory.create(:problem, :email => "user@popravi.mk")
      Factory.create(:problem, :email => "user@popravi.mk")
      user = Factory.create(:user, :email => "user@popravi.mk")
      user.has_potentially_reported_problems?.should == true
    end

    it "can count potentially reported problems" do
      Factory.create(:problem, :email => "user@popravi.mk")
      user = Factory.create(:user, :email => "user@popravi.mk")
      user.potentially_reported_problems.length.should == 1
    end

    it "can take ownership of problems" do
      user = Factory.create(:user, :email => "user@popravi.mk")
      p1 = Factory.create(:problem, :email => "user@popravi.mk")
      p2 = Factory.create(:problem, :email => "user@popravi.mk")
      user.problems.count.should == 0
      user.take_ownership_of_problems([p1, p2])
      user.problems.count.should == 2
    end
  end
end
