class Rate < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :problem, :counter_cache => true

  # Validations
  validates_presence_of :user_id, :problem_id, :weight
  validates_uniqueness_of :problem_id, :scope => :user_id
  validates_numericality_of :weight
  validates_inclusion_of :weight, :in => 1..10
end
