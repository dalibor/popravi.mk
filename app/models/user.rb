class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable, :confirmable,
         :rememberable, :trackable, :validatable

  # Attr accessible
  attr_accessible :name, :email, :password, :password_confirmation, :avatar, :municipality_id

  # Associations
  has_many :problems
  has_many :comments, :dependent => :destroy
  has_many :posts
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
  scope :admins, where('is_admin = TRUE')
  scope :moderators, where('is_admin = FALSE && municipality_id IS NOT NULL')
  scope :reporters, where('is_admin = FALSE && municipality_id IS NULL')
  scope :filter, proc {|filter|
    if filter == 'admins'
      admins
    elsif filter == 'moderators'
      moderators
    elsif filter == 'reporters'
      reporters
    end
  }

  def is_moderator?
    !is_admin && municipality_id.present?
  end

  def has_potentially_reported_problems?
    if Problem.count(:conditions => {:email => self.email, :user_id => nil}) > 0
      true
    else
      false
    end
  end

  def potentially_reported_problems
    Problem.find(:all, :conditions => {:email => self.email, :user_id => nil})
  end

  def take_ownership_of_problems(problems)
    problems.each do |problem|
      problem.user = self
      problem.save!
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  role                 :string(255)
#  problems_count       :integer(4)      default(0)
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  avatar_file_name     :string(255)
#  avatar_content_type  :string(255)
#  avatar_file_size     :integer(4)
#  avatar_updated_at    :datetime
#

