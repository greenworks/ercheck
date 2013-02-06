ActiveAdmin.register_page "Employments Submitted" do

  menu :parent => "My Account", :if => proc{ current_user.role.name=="manager" }

  content do
    params[:status]="Submitted"
    render "/employements/index"
  end
end