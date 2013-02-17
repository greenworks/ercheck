ActiveAdmin.register_page "My Employments" do

  menu :parent => "Employee Records", :if => proc{ current_user.role.name=="adminx" }

  content do
    params[:status]="All"
    render "/employements/index"
  end

  action_item  do
    link_to 'Add Employee',new_admin_employee_path
  end
end