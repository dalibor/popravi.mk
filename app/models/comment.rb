class Comment < ActiveRecord::Base

  # Gravatar
  is_gravtastic :email, :secure => true, :size => 60

  # Attr accessible
  attr_accessible :name, :email, :content

  # Associations
  belongs_to :user
  belongs_to :problem

  # Validations
  validates_presence_of :content
  validates_presence_of :problem_id
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
      "avatars/default_s.png"
    else
      gravatar_url
    end
  end
end
