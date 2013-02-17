ActiveAdmin.register_page "Approved Employees" do


  menu :parent => "Employee Records", :if => proc{ current_user.role.name=="manager" }

  #scope :published

  content do
     params[:status]="Approved"
     render "/employements/index"
#     render "/employees/employees"
  end

end