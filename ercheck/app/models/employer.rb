class Employer < ActiveRecord::Base
  has_many :employements
  has_many :employees, :through => :employements
  has_many :users
  belongs_to :industry

  attr_accessible :address, :city, :employer_code, :name, :employement_ids
  accepts_nested_attributes_for :employements, :allow_destroy => true


end
