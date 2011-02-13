class Category < ActiveRecord::Base

  acts_as_list

  # Associations
  has_many :problems

  # Validations
  validates_presence_of :name

  def self.top(limit_count)
    Category.find :all,
                  :select => "categories.id,
                              categories.name,
                              COUNT(*) as problems_count",
                  :joins => :problems,
                  :group => "categories.id",
                  :limit => limit_count,
                  :order => "problems_count DESC"
  end
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

