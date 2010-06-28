require 'spec_helper'

describe Country do
  describe "associations" do
    it { should have_many(:regions) }
  end

  describe "validations" do
    it "is valid given valid attributes" do
      country = Factory.build(:country)
      country.should be_valid
    end

    it "validates name is present" do
      country = Factory.build(:country, :name => nil)
      country.should_not be_valid
      country.errors.on(:name).should_not be_nil
    end
  end
end
