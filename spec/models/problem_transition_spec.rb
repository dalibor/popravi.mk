require 'spec_helper'

describe ProblemTransition do
  describe "associations" do
    it { should belong_to(:problem) }
    it { should belong_to(:user) }
  end
end
