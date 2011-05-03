class Attachment < ActiveRecord::Base

  has_attached_file :attachment

  # Validations
  validates_presence_of :name, :user_id
  validates_attachment_presence :attachment
  validates_attachment_size :attachment, :less_than => 5.megabytes

  # Associations
  belongs_to :user
end
