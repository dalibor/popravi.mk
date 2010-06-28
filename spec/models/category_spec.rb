require 'spec_helper'

describe Category do
  describe "associations" do
    it { should have_many(:problems) }
  end

  describe "validations" do
    it "is valid given valid attributes" do
      category = Factory.build(:category)
      category.should be_valid
    end

    it "validates name is present" do
      category = Factory.build(:category, :name => nil)
      category.should_not be_valid
      category.errors.on(:name).should_not be_nil
    end
  end
end
