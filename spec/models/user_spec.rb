require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many(:problems) }
    it { should have_many(:comments) }
    it { should have_many(:posts) }
    it { should have_many(:rates) }
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
        user = Factory.create(:user, :is_admin => false, :municipality_id => 1)
        user.is_moderator?.should be_true
      end

      it "is not moderator when it is admin and is attached to municipality" do
        user = Factory.create(:user, :is_admin => true, :municipality_id => 1)
        user.is_moderator?.should be_false
      end

      it "is not moderator when it is admin and is not attached to municipality" do
        user = Factory.create(:user, :is_admin => true, :municipality_id => nil)
        user.is_moderator?.should be_false
      end

      it "is not moderator when it is not admin and not attached to municipality" do
        user = Factory.create(:user, :is_admin => false, :municipality_id => nil)
        user.is_moderator?.should be_false
      end
    end
  end
end


# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  is_admin             :boolean(1)      default(FALSE)
#  problems_count       :integer(4)      default(0)
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  avatar_file_name     :string(255)
#  avatar_content_type  :string(255)
#  avatar_file_size     :integer(4)
#  avatar_updated_at    :datetime
#  municipality_id      :integer(4)
#

