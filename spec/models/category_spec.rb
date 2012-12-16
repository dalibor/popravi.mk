require 'spec_helper'

describe Category do
  describe "associations" do
    it { should have_many(:problems) }
  end

  describe "validations" do
    it { should validate_presence_of(:name)}

    it "is valid given valid attributes" do
      category = build(:category)
      category.should be_valid
    end
  end
end
