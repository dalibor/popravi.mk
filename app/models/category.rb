class Category < ActiveRecord::Base

  acts_as_list

  # Associations
  has_many :problems

  # Validations
  validates_presence_of :name
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  position   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

