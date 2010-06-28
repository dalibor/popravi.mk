require 'spec_helper'

describe Region do
  describe "associations" do
    it { should have_many(:municipalities) }
    it { should belong_to(:country) }
  end

  describe "validations" do
    it "is valid given valid attributes" do
      region = Factory.build(:region)
      region .should be_valid
    end

    it "validates name is present" do
      region = Factory.build(:region, :name => nil)
      region.should_not be_valid
      region.errors.on(:name).should_not be_nil
    end
  end
end
