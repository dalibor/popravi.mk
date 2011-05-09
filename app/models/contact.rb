class Contact < ActiveRecord::Base

  # Associations
  belongs_to :municipality

  # Validations
  validates_presence_of :about, :address, :phone
end
