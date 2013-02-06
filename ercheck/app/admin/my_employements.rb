ActiveAdmin.register_page "My Employments" do

  menu :parent => "My Account", :if => proc{ current_user.role.name!="admin" }

  content do
    params[:status]="All"
    render "/employements/index"
  end

end