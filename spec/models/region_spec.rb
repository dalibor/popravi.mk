require 'spec_helper'

describe Region do
  describe "associations" do
    it { should have_many(:municipalities) }
    it { should belong_to(:country) }
  end

  describe "validations" do
    subject { Factory.create(:region) }
    it { should validate_presence_of(:name) }
  end
end

# == Schema Information
#
# Table name: regions
#
#  id         :integer(4)      not null, primary key
#  country_id :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

