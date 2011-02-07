require 'spec_helper'

describe Region do
  describe "associations" do
    it { should have_many(:municipalities) }
    it { should belong_to(:country) }
  end

  describe "validations" do
    subject { Factory.create(:region) }
    it { should validate_presence_of(:name) }
  end
end
