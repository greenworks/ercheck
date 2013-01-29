class Status < ActiveRecord::Base
  has_many :employements
  has_many :employees

  attr_accessible :name
end
