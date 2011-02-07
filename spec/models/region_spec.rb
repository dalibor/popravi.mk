require 'spec_helper'

describe Region do
  describe "associations" do
    it { should have_many(:municipalities) }
    it { should belong_to(:country) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it "is valid given valid attributes" do
      region = Factory.build(:region)
      region .should be_valid
    end
  end
end
