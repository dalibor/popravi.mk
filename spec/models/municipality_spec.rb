require 'spec_helper'

describe Municipality do
  describe "associations" do
    it { should have_many(:problems) }
    it { should belong_to(:region) }
  end

  describe "validations" do
    it "is valid given valid attributes" do
      municipality = Factory.build(:municipality)
      municipality.should be_valid
    end

    it "validates name is present" do
      municipality = Factory.build(:municipality, :name => nil)
      municipality.should_not be_valid
      municipality.errors.on(:name).should_not be_nil
    end
  end
end
