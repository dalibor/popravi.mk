class ProblemTransition < ActiveRecord::Base

  # Associations
  belongs_to :problem
  belongs_to :user
end
