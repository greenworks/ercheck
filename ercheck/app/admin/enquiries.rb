ActiveAdmin.register Enquiry do

  menu :priority => 10 ,   :if => proc{ current_user.role.name=="admin" }

end
