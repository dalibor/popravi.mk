require 'spec_helper'

describe Municipality do
  describe "associations" do
    it { should belong_to(:region) }
    it { should have_many(:problems) }
    it { should have_many(:users) }
    it { should have_many(:posts) }
    it { should have_one(:contact) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it "is valid given valid attributes" do
      municipality = build(:municipality)
      municipality.should be_valid
    end
  end
end
