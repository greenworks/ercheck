ActiveAdmin.register_page "Employments Approved" do

  menu :parent => "My Account", :if => proc{ current_user.role.name=="manager" }

  content do
    params[:status]="Approved"
    render "/employements/index"
  end

end