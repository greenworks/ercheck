class HighestQualification < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :employees
  has_many :employements

end
