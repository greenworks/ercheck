class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :subordinates, :class_name => "User",   :foreign_key => "manager_id"
  belongs_to :manager, :class_name => "User"
  belongs_to :employer

  has_many :employees
  has_many :employements

  # Setup accessible (or protected) attributes for your model
  attr_accessible :user_id, :name, :role_id, :email, :password, :password_confirmation, :remember_me, :employer_id, :manager_id\
  # attr_accessible :title, :body

  def self.search_reporting_users(manager)
    if manager
      where(' id =? OR manager_id =?', "#{manager}", "#{manager}")
    else
      where(' id =?', "#{manager}")
    end
  end

  def self.search_manager_by_employer_id(employer_id)
    if employer_id
      where(' role_id = 2 AND employer_id =?', "#{employer_id}")
    else
      where(' role_id = 9 ')
    end
  end


end
