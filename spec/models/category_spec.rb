require 'spec_helper'

describe Category do
  describe "associations" do
    it { should have_many(:problems) }
  end

  describe "validations" do
    it { should validate_presence_of(:name)}

    it "is valid given valid attributes" do
      category = Factory.build(:category)
      category.should be_valid
    end
  end
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  position   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

