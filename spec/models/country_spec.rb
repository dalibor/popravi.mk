require 'spec_helper'

describe Country do
  describe "associations" do
    it { should have_many(:regions) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it "is valid given valid attributes" do
      country = Factory.build(:country)
      country.should be_valid
    end
  end
end

# == Schema Information
#
# Table name: countries
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

