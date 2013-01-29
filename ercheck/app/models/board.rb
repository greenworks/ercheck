class Board < ActiveRecord::Base
  has_many :employees

  attr_accessible :address, :name
end
