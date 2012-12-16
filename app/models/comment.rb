# encoding: utf-8
class Comment < ActiveRecord::Base
  EMAIL_REG_EXP = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)\z/i

  # Attr accessible
  attr_accessible :name, :email, :content

  # Associations
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  # Validations
  validates_presence_of :content, :commentable_id, :commentable_type
  validates_format_of :email, :with => EMAIL_REG_EXP, :allow_blank => true

  # Scopes
  scope :ordered, order("id DESC")

  def commenter_name
    if user && user.municipality.present?
      if user.name.present?
        "#{user.name} (#{user.municipality.name})"
      else
        "Анонимен корисник (#{user.municipality.name})"
      end
    elsif user && !user.municipality.present?
      user.name.present? ? user.name : "Анонимен корисник"
    else
      name.present? ? name : 'Анонимен корисник'
    end
  end

  def commenter_avatar
    if user
      user.avatar(:s)
    elsif email.blank?
      "avatars/anonymous.png"
    else
      "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}.png?s=60"
    end
  end
end
