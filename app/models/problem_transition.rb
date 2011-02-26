class ProblemTransition < ActiveRecord::Base

  # Associations
  belongs_to :problem
end

# == Schema Information
#
# Table name: problem_transitions
#
#  id         :integer(4)      not null, primary key
#  problem_id :integer(4)
#  from       :string(255)
#  to         :string(255)
#  created_at :datetime
#  updated_at :datetime
#

