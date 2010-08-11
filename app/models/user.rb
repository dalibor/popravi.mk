class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable, :confirmable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation

  # Associations
  has_many :problems

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
