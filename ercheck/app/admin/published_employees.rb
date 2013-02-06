ActiveAdmin.register_page "Published Employees" do


  menu :parent => "My Account", :if => proc{ current_user.role.name=="manager" }

  #scope :published

  content do
     params[:status]="Published"
     render "/employees/employees"
  end

end