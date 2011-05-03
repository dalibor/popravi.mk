require 'spec_helper'

describe Attachment do
  describe 'attributes' do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:attachment) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { Factory(:attachment) }
    it { should be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
  end
end
