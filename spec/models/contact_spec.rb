require 'spec_helper'

describe Contact do
  describe "associations" do
    it { should belong_to(:municipality) }
  end

  describe "validations" do
    it { should validate_presence_of(:about) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone) }
  end
end
