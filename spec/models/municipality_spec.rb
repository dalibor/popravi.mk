require 'spec_helper'

describe Municipality do
  describe "associations" do
    it { should belong_to(:region) }
    it { should have_many(:problems) }
    it { should have_many(:users) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it "is valid given valid attributes" do
      municipality = Factory.build(:municipality)
      municipality.should be_valid
    end
  end
end

# == Schema Information
#
# Table name: municipalities
#
#  id         :integer(4)      not null, primary key
#  region_id  :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

