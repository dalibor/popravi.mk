class Comment < ActiveRecord::Base

  # Gravatar
  include Gravtastic
  gravtastic

  # Attr accessible
  attr_accessible :name, :email, :content

  # Associations
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  # Validations
  validates_presence_of :content, :commentable_id, :commentable_type
  validates_format_of :email, :with => EMAIL_REG_EXP, :allow_blank => true

  def commenter_name
    if user
      user.name.present? ? user.name : 'Анонимен корисник'
    else
      name.present? ? name : 'Анонимен посетител'
    end
  end

  def commenter_avatar
    if user
      user.avatar(:s)
    elsif email.blank?
      "avatars/anonymous.png"
    else
      gravatar_url
    end
  end
end

# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  user_id          :integer(4)
#  commentable_id   :integer(4)
#  name             :string(255)
#  email            :string(255)
#  content          :text
#  approved         :boolean(1)      default(TRUE)
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_type :string(255)
#

