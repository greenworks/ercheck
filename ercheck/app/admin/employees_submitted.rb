ActiveAdmin.register_page "Submitted Employees" do


  menu :parent => "Employee Records", :if => proc{ current_user.role.name=="manager" }

  #scope :published

  content do
     params[:status]="Submitted"
     render "/employements/index"
#     render "/employees/employees"
  end

end