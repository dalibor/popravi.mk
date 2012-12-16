require 'spec_helper'

describe Rate do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:problem) }
  end

  describe "attributes" do
    it { should allow_mass_assignment_of(:problem_id) }
    it { should allow_mass_assignment_of(:user_id) }
    it { should allow_mass_assignment_of(:weight) }
  end

  describe "validations" do
    subject { create(:rate) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:problem_id) }
    it { should validate_presence_of(:weight) }
    it { should validate_numericality_of(:weight) }
    it { should ensure_inclusion_of(:weight).in_range(1..10) }
    it { should validate_uniqueness_of(:problem_id).scoped_to(:user_id) }
  end
end
