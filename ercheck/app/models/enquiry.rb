class Enquiry < ActiveRecord::Base
  attr_accessible :company_name, :email, :message, :name, :phone, :website
end
