class Problem < ActiveRecord::Base
  # Associations
  belongs_to :user, :counter_cache => true
  belongs_to :category
  belongs_to :municipality

  # Validations
  validates_presence_of :name, :if => Proc.new { |problem| problem.user_id.blank? }
  validates_presence_of :email, :if => Proc.new { |problem| problem.user_id.blank? }
  validates_presence_of :subject
  validates_presence_of :description
  validates_presence_of :longitude
  validates_presence_of :latitude
  validates_presence_of :category_id
  validates_presence_of :municipality_id

  attr_accessor :address

  # Status
  #  0 New
  # -1 Invalid
end
