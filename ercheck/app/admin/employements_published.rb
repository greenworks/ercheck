ActiveAdmin.register_page "Employments Published" do

  menu :parent => "My Account", :if => proc{ current_user.role.name=="manager" }

  content do
    params[:status]="Published"
    render "/employements/index"
  end
end