ActiveAdmin.register_page "Submitted Employees" do


  menu :parent => "My Account", :if => proc{ current_user.role.name=="manager" }

  #scope :published

  content do
     params[:status]="Submitted"
     render "/employees/employees"
  end

end