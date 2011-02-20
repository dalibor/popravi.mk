require 'spec_helper'

describe ProblemTransition do
  describe "associations" do
    it { should belong_to(:problem) }
  end
end
