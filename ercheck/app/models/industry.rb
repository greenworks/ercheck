class Industry < ActiveRecord::Base
  attr_accessible :name

  has_many :employers
end
