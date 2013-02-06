ActiveAdmin.register_page "Approved Employees" do


  menu :parent => "My Account", :if => proc{ current_user.role.name=="manager" }

  #scope :published

  content do
     params[:status]="Approved"
     render "/employees/employees"
  end

end