require 'spec_helper'

describe Municipality do
  describe "associations" do
    it { should have_many(:problems) }
    it { should belong_to(:region) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it "is valid given valid attributes" do
      municipality = Factory.build(:municipality)
      municipality.should be_valid
    end
  end
end
