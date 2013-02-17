ActiveAdmin.register_page "Published Employees" do


  menu :parent => "My Account", :if => proc{ current_user.role.name=="managerx" }

  #scope :published

  content do
     params[:status]="Published"
     render "/employements/index"
#     render "/employees/employees"
  end

end