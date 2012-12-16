require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many(:problems) }
    it { should have_many(:comments) }
    it { should have_many(:posts) }
    it { should have_many(:rates) }
    it { should have_many(:attachments) }
    it { should belong_to(:municipality) }
  end

  describe "attributes" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
    it { should allow_mass_assignment_of(:avatar) }
  end

  describe "instance methods" do
    describe "moderator" do
      it "is moderator if is not admin and is attached to municipality" do
        user = create(:user, :is_admin => false, :municipality_id => 1)
        user.is_moderator?.should be_true
      end

      it "is not moderator when it is admin and is attached to municipality" do
        user = create(:user, :is_admin => true, :municipality_id => 1)
        user.is_moderator?.should be_false
      end

      it "is not moderator when it is admin and is not attached to municipality" do
        user = create(:user, :is_admin => true, :municipality_id => nil)
        user.is_moderator?.should be_false
      end

      it "is not moderator when it is not admin and not attached to municipality" do
        user = create(:user, :is_admin => false, :municipality_id => nil)
        user.is_moderator?.should be_false
      end
    end
  end
end
