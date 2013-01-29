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
  attr_accessible :email, :password, :password_confirmation, :remember_me, :employer_id
  # attr_accessible :title, :body

  def self.search(manager)
    if manager
      where('manager_id =?', "#{4}")
    else
      scoped
    end
  end
end
