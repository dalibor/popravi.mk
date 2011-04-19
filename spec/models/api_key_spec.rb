require 'spec_helper'

describe ApiKey do

  describe "associations" do
    it { should have_many(:problems) }
  end
end
