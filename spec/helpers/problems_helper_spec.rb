require 'spec_helper'

describe ProblemsHelper do
  describe "get_month_names" do
    it "returns month names" do
      get_month_names.should == [["January", 1], ["February", 2], ["March", 3], ["April", 4], ["May", 5], ["June", 6], ["July", 7], ["August", 8], ["September", 9], ["October", 10], ["November", 11], ["December", 12]]
    end
  end

end
