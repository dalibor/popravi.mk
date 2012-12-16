# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable, :confirmable,
         :rememberable, :trackable, :validatable
  devise :encryptable, :encryptor => :sha1

  # Attributes
  attr_accessible :name, :email, :password, :password_confirmation, :avatar, :municipality_id

  # Associations
  has_many :problems
  has_many :comments, :dependent => :destroy
  has_many :posts
  has_many :rates
  has_many :attachments
  belongs_to :municipality

  # Paperclip
  has_attached_file :avatar, :styles => {:s => '60x60#'},
                  :url  => "/assets/avatars/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension",
                  :default_url => "/images/avatars/default_:style.png"

  #Validations
  #validates_attachment_presence :avatar
  #validates_attachment_size :avatar, :less_than => 5.megabytes
  #validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/pjpeg', 'image/pjpg', 'image/x-png', 'image/png', 'image/jpg']


  # Scopes
  scope :admins, where(['is_admin = ?', true])
  scope :moderators, where(['is_admin = ? AND municipality_id IS NOT NULL', false])
  scope :reporters, where(['is_admin = ? AND municipality_id IS NULL', false])
  scope :filter, proc {|filter|
    if filter == 'admins'
      admins
    elsif filter == 'moderators'
      moderators
    elsif filter == 'reporters'
      reporters
    end
  }
  scope :ordered, order("created_at DESC")

  # Devise override
  def send_confirmation_instructions
    assign_user_to_problems
    super
  end

  def is_moderator?
    !is_admin && municipality_id.present?
  end

  def full_name
    name || 'Анонимен Корисник'
  end

  private
  def assign_user_to_problems
    Problem.where(['email = ?', email]).each do |problem|
      problem.user = self
      problem.save(:validate => false)
    end
  end
end
