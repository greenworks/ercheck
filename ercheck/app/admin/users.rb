ActiveAdmin.register User do
  menu :parent => "Masters", :if => proc{ current_user.role.name=="admin" }


  action_item :only => :show  do
    link_to "New User", "/admin/users/new"
  end

=begin
  member_action :reset_password do
    @user = User.find(params[:id])
    @user.update_attribute(:password,"password")
    redirect_to admin_users_path , :notice => "password was reset!"
  end

  action_item :only => :show   do
    link_to admin_users_path , :notice => "password was reset!"
  end
=end


  index do
    selectable_column
    column :id
    column :name
    column :email
    column :employer
    column :role
    column :manager
  default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :employer
      f.input :role
      f.input :manager
      f.input :password
    end
    f.buttons
  end

end
