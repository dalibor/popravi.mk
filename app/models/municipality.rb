class Municipality < ActiveRecord::Base

  # Associations
  belongs_to :region
  has_many :problems
  has_many :users
  has_many :posts, :through => :users

  # Validations
  validates_presence_of :name

  # Scopes
  scope :ordered, order('name ASC')
end

# == Schema Information
#
# Table name: municipalities
#
#  id         :integer(4)      not null, primary key
#  region_id  :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

