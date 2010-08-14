class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable, :confirmable,
         :rememberable, :trackable, :validatable

  # Attr accessible
  attr_accessible :name, :email, :password, :password_confirmation, :avatar

  # Associations
  has_many :problems
  has_many :comments, :dependent => :destroy

  # Paperclip
  has_attached_file :avatar, :styles => {:s => '60x60#'},
                  :url  => "/assets/avatars/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension",
                  :default_url => "/images/avatars/default_:style.png"

  #Validations
  #validates_attachment_presence :avatar
  #validates_attachment_size :avatar, :less_than => 5.megabytes
  #validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/pjpeg', 'image/pjpg', 'image/x-png', 'image/png', 'image/jpg']

  def is_admin?
    self.role == "admin"
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
